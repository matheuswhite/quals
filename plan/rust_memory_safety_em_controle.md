---
author: Claude (claude-opus-4-7)
created: 2026-05-20
---

# Rust em Sistemas de Controle: Garantias de Memory Safety

## Visão geral

*Memory safety* no Rust é a eliminação **por construção** de uma classe específica de bugs. O type system + ownership + borrow checker recusam programas que poderiam apresentar:

| Classe de bug | UB em C/C++? | Eliminado por Rust safe? |
|---|---|---|
| Use-after-free | Sim | Sim (lifetimes) |
| Double-free | Sim | Sim (ownership) |
| Dangling pointer | Sim | Sim (lifetimes) |
| Out-of-bounds read/write | Sim | Sim (bounds check → panic, não UB) |
| Null pointer dereference | Sim | Sim (sem `null` em safe Rust) |
| Uninitialized read | Sim | Sim (inicialização obrigatória) |
| Iterator invalidation | Sim | Sim (borrow checker) |
| Data race | Sim | Sim (`Send` + `Sync` + borrow checker) |

A pergunta relevante para um sistema de controle é: **quais algoritmos são particularmente vulneráveis a essas classes de bug?** Resposta: aqueles cuja implementação depende de buffers indexados, estruturas dinâmicas ou estado compartilhado entre contextos.

| Classe de bug em C | Onde aparece em controle |
|---|---|
| OOB / off-by-one em buffer | Smith Predictor (delay line), filtros FIR/IIR com histórico, lookup tables de ganho |
| Use-after-free / dangling | MPC com solver QP que aloca workspace, controle adaptativo com vetor de parâmetros redimensionável |
| Data race / torn read | ADC via DMA → estimador, encoder ISR → loop de controle, comandos de trajetória → controlador |
| Uninit read | Estimadores no startup (P, x̂ não inicializados), LUTs antes do carregamento |
| Buffer overflow de mensagem | Fusão de sensores via UART/CAN/MAVLink, controle distribuído (ROS, EtherCAT) |

---

## Caso 1: Smith Predictor / Delay Line

### Cenário

O Smith Predictor compensa atraso de transporte usando uma linha de atraso de N amostras. O mesmo padrão aparece em filtros FIR, observadores com histórico e qualquer compensação de dead-time.

### Implementação em C

```c
#define DELAY_SAMPLES 50

typedef struct {
    float buffer[DELAY_SAMPLES];
    int write_idx;
} DelayLine;

float delay_step(DelayLine *d, float input) {
    float out = d->buffer[d->write_idx];
    d->buffer[d->write_idx] = input;
    d->write_idx = (d->write_idx + 1) % DELAY_SAMPLES;
    return out;
}
```

### Bugs de memory safety que compilam silenciosamente

1. **Stack-alloc sem zerar**: `DelayLine d;` deixa `d.write_idx` com valor de pilha qualquer. A primeira chamada acessa `buffer[lixo]` — **OOB read/write em endereço arbitrário, UB**.
2. **Index negativo via aritmética com sinal**: variantes com delay variável como `d->buffer[(d->write_idx + k) % DELAY_SAMPLES]`. Se `k` for negativo (autor esqueceu `unsigned`), `%` em C tem sinal implementação-definido → índice negativo → OOB.
3. **Use-after-free com alocação dinâmica**: `DelayLine *d = malloc(...); free(d); delay_step(d, x);` — controlador lê de memória já realocada para outro propósito.

### Implementação em Rust

```rust
pub struct DelayLine<const N: usize> {
    buffer: [f32; N],
    write_idx: usize,
}

impl<const N: usize> DelayLine<N> {
    pub const fn new() -> Self {
        Self { buffer: [0.0; N], write_idx: 0 }
    }

    pub fn step(&mut self, input: f32) -> f32 {
        let out = self.buffer[self.write_idx];        // bounds check
        self.buffer[self.write_idx] = input;          // bounds check
        self.write_idx = (self.write_idx + 1) % N;
        out
    }
}
```

### Garantias do compilador

- **Construir um `DelayLine` sem inicializar é impossível** — `new()` exige todos os campos. (1) eliminado.
- **Acesso fora do range gera panic** determinístico em debug e release, não UB. (2) vira erro reproduzível em teste.
- **Use-after-free é impossível** — `&mut self` exige um borrow vivo; lifetimes garantem que a referência não sobrevive ao dono. (3) eliminado.
- **Capacidade `N` no nível do tipo** — não é possível confundir `DelayLine<50>` com `DelayLine<100>` por engano.

---

## Caso 2: DMA ISR → Loop de Controle (Produtor-Consumidor)

### Cenário

Padrão universal em controle embarcado: ADC dispara DMA, ISR de *transfer complete* coloca amostras num buffer, loop de controle consome. O mesmo padrão aparece em qualquer comunicação entre ISR e tarefa de aplicação.

### Implementação em C

```c
#define BUF_SIZE 1024
static uint16_t adc_buf[BUF_SIZE];
static volatile size_t write_idx;
static volatile size_t read_idx;

void DMA1_IRQHandler(void) {
    adc_buf[write_idx] = ADC1->DR;
    write_idx = (write_idx + 1) % BUF_SIZE;
}

void control_loop(void) {
    while (read_idx != write_idx) {
        uint16_t s = adc_buf[read_idx];
        read_idx = (read_idx + 1) % BUF_SIZE;
        process(s);
    }
}
```

### Bugs de memory safety

1. **`volatile` não é atômico**. Em arquitetura de 16 bits ou se `size_t` for 64 bits em Cortex-M, `write_idx` é lido em duas instruções → **torn read** → consumidor lê valor inválido → `adc_buf[valor_invalido]` → OOB. UB documentado em C11 §5.1.2.4.
2. **Sem memory barrier**, compilador pode reordenar a escrita em `adc_buf` para *depois* da atualização de `write_idx` → consumidor lê posição "preenchida" que ainda não foi escrita → leitura de lixo.
3. **Sem detecção de overflow**: se consumidor for lento, produtor sobrescreve dados não consumidos silenciosamente.

### Implementação em Rust com `heapless::spsc::Queue`

```rust
use heapless::spsc::{Queue, Producer, Consumer};

#[rtic::app(/* ... */)]
mod app {
    #[local] struct Local {
        producer: Producer<'static, u16, 1024>,
        consumer: Consumer<'static, u16, 1024>,
    }

    #[init(local = [q: Queue<u16, 1024> = Queue::new()])]
    fn init(ctx: init::Context) -> (Shared, Local) {
        let (producer, consumer) = ctx.local.q.split();
        (Shared {}, Local { producer, consumer })
    }

    #[task(binds = DMA1_CH1, local = [producer])]
    fn dma_isr(ctx: dma_isr::Context) {
        let sample = read_adc_dr();
        let _ = ctx.local.producer.enqueue(sample);  // Result: Ok ou Err(amostra)
    }

    #[task(local = [consumer], priority = 2)]
    async fn control_loop(ctx: control_loop::Context) {
        while let Some(sample) = ctx.local.consumer.dequeue() {
            process(sample);
        }
    }
}
```

### Garantias do compilador

- **`Producer` e `Consumer` são `Send` mas não `Sync`** — cada um é movido para exatamente um contexto. O compilador não permite ambos acessarem o mesmo índice. Os bugs (1) e (2) viram impossíveis: nenhum índice compartilhado existe na superfície do API.
- A implementação interna do `heapless::spsc` usa `AtomicUsize` com ordenamento `Acquire`/`Release` correto, escrito **uma vez** e auditado.
- Capacidade fixa no tipo (`1024`), sem alocação dinâmica, determinístico.
- Overflow silencioso (3) vira `Err(sample)` explícito → o autor é obrigado a decidir o que fazer.

---

## Caso 3: MPC Adaptativo com Atualização Dinâmica de Obstáculos

### Cenário

Em planejamento de trajetória para veículo autônomo / drone, é comum ter três contextos rodando em frequências diferentes:

- **Tarefa de planejamento** (~50 Hz): resolve QP via MPC, publica trajetória
- **Tarefa de percepção** (~10 Hz): recebe mapa atualizado de obstáculos, reconfigura o problema do MPC (restrições novas)
- **Loop de baixo nível** (~1 kHz): lê trajetória publicada e gera comando para os atuadores

A reconfiguração do QP quando obstáculos mudam é arquiteturalmente **correta** — o conjunto de restrições mudou, o problema é estruturalmente diferente, o workspace precisa ser realocado. O bug está em outro lugar: a trajetória "publicada" para o low-level pode ter ficado apontando para memória do workspace antigo.

### Implementação em C — três módulos

**Arquivo `planner/mpc.h`** — API pública do módulo de planejamento:

```c
typedef struct AdaptiveMpc AdaptiveMpc;

typedef struct {
    const float *u_horizon;   // trajetória de controle ao longo do horizonte
    float t_published;        // tempo em que foi calculada
    uint32_t seq;             // contador monotônico de soluções
    int length;
} PublishedTrajectory;

AdaptiveMpc *adaptive_mpc_create(int horizon,
                                 const Polyhedron *obstacles, int n_obs);
void adaptive_mpc_destroy(AdaptiveMpc *mpc);

PublishedTrajectory adaptive_mpc_step(AdaptiveMpc *mpc, const float *x_now);
void adaptive_mpc_update_obstacles(AdaptiveMpc *mpc,
                                   const Polyhedron *obs, int n);
```

**Arquivo `planner/mpc.c`** — implementação:

```c
struct AdaptiveMpc {
    OSQPWorkspace *qp;
    Polyhedron *obstacles;
    int n_obstacles;
    int horizon;
    uint32_t seq;
};

AdaptiveMpc *adaptive_mpc_create(int horizon,
                                 const Polyhedron *obs, int n_obs) {
    AdaptiveMpc *mpc = calloc(1, sizeof(*mpc));
    mpc->obstacles = clone_polyhedra(obs, n_obs);
    mpc->n_obstacles = n_obs;
    mpc->horizon = horizon;
    mpc->qp = osqp_setup_problem(horizon, mpc->obstacles, n_obs);
    return mpc;
}

void adaptive_mpc_destroy(AdaptiveMpc *mpc) {
    if (!mpc) return;
    osqp_cleanup(mpc->qp);
    free(mpc->obstacles);
    free(mpc);
}

PublishedTrajectory adaptive_mpc_step(AdaptiveMpc *mpc, const float *x_now) {
    osqp_update_initial_state(mpc->qp, x_now);
    osqp_solve(mpc->qp);
    mpc->seq++;

    // O solver mantém a solução no workspace; expomos ponteiro para evitar cópia.
    return (PublishedTrajectory){
        .u_horizon = mpc->qp->solution->x,
        .t_published = monotonic_time(),
        .seq = mpc->seq,
        .length = mpc->horizon,
    };
}

void adaptive_mpc_update_obstacles(AdaptiveMpc *mpc,
                                   const Polyhedron *obs, int n) {
    osqp_cleanup(mpc->qp);
    free(mpc->obstacles);

    mpc->obstacles = clone_polyhedra(obs, n);
    mpc->n_obstacles = n;
    mpc->qp = osqp_setup_problem(mpc->horizon, mpc->obstacles, n);
}
```

**Arquivo `control/scheduler.c`** — orquestração entre tarefas:

```c
static AdaptiveMpc *g_mpc;
static PublishedTrajectory g_last_trajectory;   // publicada para o low-level
static portMUX_TYPE g_traj_mux = portMUX_INITIALIZER_UNLOCKED;

// 50 Hz - tarefa de planejamento
void planning_tick(void) {
    float x_now[STATE_DIM];
    read_state_estimate(x_now);

    PublishedTrajectory traj = adaptive_mpc_step(g_mpc, x_now);

    portENTER_CRITICAL(&g_traj_mux);
    g_last_trajectory = traj;
    portEXIT_CRITICAL(&g_traj_mux);
}

// 10 Hz - callback quando o módulo de percepção atualiza obstáculos
void perception_callback(const Polyhedron *obstacles, int n) {
    adaptive_mpc_update_obstacles(g_mpc, obstacles, n);
    // Próximo planning_tick recomputa com obstáculos novos.
}

// 1 kHz - low-level controller (alta prioridade)
void low_level_tick(void) {
    PublishedTrajectory traj;

    portENTER_CRITICAL(&g_traj_mux);
    traj = g_last_trajectory;
    portEXIT_CRITICAL(&g_traj_mux);

    float t_now = monotonic_time();
    int idx = (int)((t_now - traj.t_published) / CONTROL_DT);
    if (idx >= 0 && idx < traj.length) {
        float u_des = traj.u_horizon[idx];   // (★)
        apply_control(u_des);
    }
}
```

### Por que esse bug é difícil de detectar

A revisão de código superficial passa: cada módulo, isolado, parece correto.

1. **`planner/mpc.c` está consistente consigo mesmo.** `step()` retorna ponteiro para `qp->solution->x`. `update_obstacles()` faz `osqp_cleanup()` antes de realocar — a ordem do cleanup está correta dentro da função. Não há `free` "óbvio na linha de cima".

2. **`scheduler.c` protege o acesso a `g_last_trajectory` com mutex.** O autor pensou no problema de concorrência. O struct é copiado por valor sob lock. Parece OK.

3. **O bug é a interação:** o struct `PublishedTrajectory` contém `const float *u_horizon` — um ponteiro pra dentro do workspace do solver. Copiar o struct sob mutex copia o **ponteiro**, não os dados. Quando `perception_callback` faz `osqp_cleanup(mpc->qp)`, a memória apontada por `g_last_trajectory.u_horizon` é liberada. A linha `★` lê de memória inválida.

4. **A janela de manifestação é estreita.** Só acontece quando:
   - `perception_callback` executa entre dois `planning_tick` (≤ 20 ms de janela)
   - **E** `low_level_tick` lê antes do próximo `planning_tick` republicar
   - **E** o alocador tiver reaproveitado a memória pra outra coisa
   - Em testes unitários de cada módulo, isso nunca acontece.
   - Em testes de integração curtos, o evento de obstáculo pode nunca coincidir com a janela.
   - Em campo, depois de horas de operação, acontece — e é interpretado como "glitch transitório".

5. **Sanitizers podem não pegar.** AddressSanitizer detecta UAF quando há reuso da memória liberada; se o alocador devolve a mesma região poucos µs depois, ASAN identifica. Mas se nada realoca naquela região, ASAN não percebe — você lê o conteúdo "vazio" da heap interna do OSQP, que pode ainda ser numericamente plausível. ThreadSanitizer também não detecta porque o acesso *está* sob mutex; o problema é a vida do ponteiro, não a sincronização.

6. **Code review não pega facilmente.** Para perceber, o revisor precisa rastrear: "`u_horizon` aponta para dentro de `qp`; `qp` pode ser destruído por outra tarefa; existe sincronização entre essas duas operações?" Esse raciocínio cruza três arquivos e duas frequências de tarefa. Em uma PR de 200 linhas, é exatamente o tipo de problema que escapa.

### Implementação em Rust — versão com lifetimes

A primeira tentativa de tradução literal expõe o problema na cara do compilador:

```rust
pub struct AdaptiveMpc {
    qp: OsqpWorkspace,
    obstacles: Vec<Polyhedron>,
    horizon: usize,
    seq: u32,
}

pub struct PublishedTrajectory<'a> {
    pub u_horizon: &'a [f32],     // empresta de algum lugar
    pub t_published: f32,
    pub seq: u32,
}

impl AdaptiveMpc {
    pub fn step(&mut self, x_now: &[f32]) -> PublishedTrajectory<'_> {
        self.qp.update_initial_state(x_now);
        self.qp.solve();
        self.seq += 1;
        PublishedTrajectory {
            u_horizon: self.qp.solution(),   // &'a [f32], 'a tied to &self
            t_published: monotonic_time(),
            seq: self.seq,
        }
    }

    pub fn update_obstacles(&mut self, obs: Vec<Polyhedron>) {
        self.qp = OsqpWorkspace::setup(self.horizon, &obs);
        self.obstacles = obs;
    }
}
```

Agora considere o código equivalente ao `scheduler.c`:

```rust
fn buggy_caller(mpc: &mut AdaptiveMpc, x_now: &[f32], new_obs: Vec<Polyhedron>) {
    let traj = mpc.step(x_now);              // (1) traj: PublishedTrajectory<'a>
                                              //     onde 'a = lifetime de &mut *mpc

    mpc.update_obstacles(new_obs);            // (2) ERRO DE COMPILAÇÃO:
                                              //     cannot borrow `*mpc` as mutable
                                              //     more than once at a time
                                              //     -- `mpc` is already borrowed by `traj`

    let u = traj.u_horizon[0];                // (3) usa traj
    apply_control(u);
}
```

Mensagem real do `rustc`:

```
error[E0499]: cannot borrow `*mpc` as mutable more than once at a time
  --> src/scheduler.rs:5:5
   |
3  |     let traj = mpc.step(x_now);
   |                --- first mutable borrow occurs here
4  |
5  |     mpc.update_obstacles(new_obs);
   |     ^^^ second mutable borrow occurs here
6  |
7  |     let u = traj.u_horizon[0];
   |             ----------------- first borrow later used here
```

O mesmo erro aparece se você tentar **armazenar** `traj` numa variável global, num campo de struct, ou passar pra outra tarefa: o lifetime `'a` está amarrado ao `&mut mpc`, e não há como esticá-lo. **Para o compilador aceitar, você é forçado a uma das duas saídas legítimas:**

### Implementação em Rust — saída 1: dados owned

```rust
pub struct OwnedTrajectory {
    pub u_horizon: heapless::Vec<f32, MAX_HORIZON>,
    pub t_published: f32,
    pub seq: u32,
}

impl AdaptiveMpc {
    pub fn step_owned(&mut self, x_now: &[f32]) -> OwnedTrajectory {
        self.qp.update_initial_state(x_now);
        self.qp.solve();
        self.seq += 1;

        let mut u = heapless::Vec::new();
        u.extend_from_slice(self.qp.solution()).unwrap();
        OwnedTrajectory { u_horizon: u, t_published: monotonic_time(), seq: self.seq }
    }
}
```

Custo: cópia de N×nu floats por ciclo de planejamento. Para N=50, nu=2, são 400 bytes a 50 Hz = 20 KB/s. Trivial. O low-level lê de memória que ele próprio detém — impossível dangling.

### Implementação em Rust — saída 2: zero-copy via `arc_swap`

Para horizontes muito longos onde a cópia importa, o ponteiro continua sendo passado, mas via `Arc` com `arc_swap::ArcSwap`:

```rust
use arc_swap::ArcSwap;
use std::sync::Arc;

pub struct SharedTrajectory {
    inner: ArcSwap<OwnedTrajectory>,
}

impl SharedTrajectory {
    pub fn publish(&self, traj: OwnedTrajectory) {
        self.inner.store(Arc::new(traj));
    }

    pub fn snapshot(&self) -> Arc<OwnedTrajectory> {
        self.inner.load_full()    // bump refcount; vida garantida enquanto o Arc viver
    }
}
```

O low-level pega um `Arc<OwnedTrajectory>` no início do tick, lê quantas vezes quiser, solta no fim. Se o planner publicar uma nova trajetória no meio do tick, a antiga não é liberada até o último `Arc` ser dropado. **Impossível dangling, sem mutex no caminho do leitor.**

### Versão completa com RTIC

```rust
#[rtic::app(device = ..., dispatchers = [SPI1])]
mod app {
    use super::*;

    #[shared]
    struct Shared {
        mpc: AdaptiveMpc,
        traj: SharedTrajectory,
    }

    #[task(shared = [mpc, traj], priority = 3)]
    async fn planning_task(mut ctx: planning_task::Context) {
        loop {
            let x = read_state_estimate();
            let new_traj = ctx.shared.mpc.lock(|m| m.step_owned(&x));
            ctx.shared.traj.lock(|t| t.publish(new_traj));
            Mono::delay(20.millis()).await;
        }
    }

    #[task(shared = [mpc], priority = 2)]
    async fn perception_task(mut ctx: perception_task::Context) {
        loop {
            let obs = receive_obstacle_update().await;
            ctx.shared.mpc.lock(|m| m.update_obstacles(obs));
        }
    }

    #[task(shared = [traj], priority = 5)]
    async fn low_level_task(mut ctx: low_level_task::Context) {
        loop {
            let snap = ctx.shared.traj.lock(|t| t.snapshot());
            let idx = trajectory_index(monotonic_time(), snap.t_published);
            if let Some(u) = snap.u_horizon.get(idx) {
                apply_control(*u);
            }
            Mono::delay(1.millis()).await;
        }
    }
}
```

### Garantias do compilador

- **A versão com ponteiro emprestado não compila** se o trajeto for armazenado entre uma `step()` e uma `update_obstacles()`. O bug fica visível na *primeira* tentativa de build.
- **A versão owned não pode danglar** — o low-level detém os dados.
- **A versão `ArcSwap`** dá zero-copy seguro: o leitor segura um `Arc`; o escritor pode publicar uma nova versão; a antiga só é liberada quando o último `Arc` morre. Sem mutex no caminho de leitura, sem dangling.
- A **decisão arquitetural** (copiar vs. compartilhar via refcount) sai à tona em forma de tipos diferentes, em vez de ficar escondida numa convenção informal "*não guarde esse ponteiro*".

---

## Onde memory safety do Rust não ajuda

- **Stack overflow** — Rust *safe* não tem profundidade de recursão verificada por tipo. Ferramentas externas (`cargo-call-stack`) analisam estaticamente o uso de pilha em targets embarcados.
- **Erros lógicos** — índice computado errado para uma LUT é índice *válido* e retorna ganho errado; o tipo não previne.
- **Erros físicos / de calibração** — nenhum sistema de tipos previne sensor enviesado.
- **Blocos `unsafe`** — HALs e FFI com solvers em C (OSQP, qpOASES) inevitavelmente envolvem `unsafe`. O esforço de auditoria passa a ser concentrado em superfícies pequenas e bem identificadas.
- **Panics em embarcado** — `arr[idx]` com `idx` OOB em Rust é `panic`, não UB. Em embarcado, panic pode disparar reset. Normalmente é o que se quer em controle (fail-fast), mas precisa ser dimensionado e usar `panic = "abort"` com um *panic handler* apropriado.

---

## Argumento para a tese

A formulação defensável:

> *"Em sistemas de controle embarcado, certas classes de bug de memória — torn reads em estado compartilhado entre ISR e tarefas, off-by-one em delay lines e histórias de filtros, use-after-free em workspaces de solvers MPC, leitura não inicializada de estimadores — são causas documentadas de falhas em campo (Toyota UA, Therac-25, Ariane V, MCAS). Rust elimina essas classes **por construção**, deslocando o esforço de verificação de revisão manual + ferramentas estáticas externas (MISRA-C + Polyspace + Coverity) para o compilador. O custo é confinar `unsafe` a interfaces de hardware claramente identificadas."*

## Experimento proposto

1. **Algoritmo**: Smith Predictor + Kalman de baixa ordem compartilhando estado com ISR de ADC + reconfiguração de horizonte (proxy para o cenário do Caso 3 em escala menor).
2. **Implementações**: C puro com FreeRTOS; Rust com `heapless` + RTIC.
3. **Sanitização**: AddressSanitizer, ThreadSanitizer, UBSan em ambos, executados em host com inputs sintéticos.
4. **Métricas**:
   - Bugs detectados por sanitizer em C que **não compilam** em Rust.
   - Linhas de "boilerplate de segurança" (locks explícitos, bounds checks manuais, verificações de inicialização).
   - Tamanho da fronteira `unsafe` no projeto Rust.
   - Performance (ciclos por iteração) — esperado: paridade.
5. **Documentar**: para cada bug, o snippet C que o produz, o erro do compilador Rust que o impede, e o diagnóstico do sanitizer correspondente.
