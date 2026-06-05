---
author: Claude (claude-opus-4-8)
created: 2026-06-04
---

<!-- LTeX: enabled=false -->

# Esqueleto do Cap. 4 — Metodologia Proposta

Outline de planejamento (Regra 4): descreve **o que cada seção precisa responder** e **as decisões a tomar** — não contém prosa da tese. Companheiro de [`outline_geral.md`](outline_geral.md) (visão de todos os capítulos) e [`roadmap_escrita.md`](roadmap_escrita.md) (quando escrever).

## Por que reorganizar (contexto da decisão de 2026-06-04)

A estrutura herdada do `.tex` (Requisitos → Arquitetura → Implementação → Validação → Critérios) descreve *como construir a biblioteca* — coerente com o enquadramento antigo (Aule = objeto central). Sob o **título novo** (fronteira de segurança + custo de data races; Aule = veículo) e os **8 objetivos** da §1.2, os objetivos da qualificação (1–3) são de **caracterização/análise**, não de construção — e a estrutura herdada **não tem seção para eles**.

A reorganização mapeia **método ↔ objetivo (1-pra-1)** e separa qualificação (obj 1–3, em execução, detalhados) de pós-qualificação (obj 4–8, apresentados como protocolo/plano).

| Seção | Objetivo | Fase | Natureza |
|---|---|---|---|
| 4.1 Caracterização da pesquisa | — (enquadra) | — | meta |
| 4.2 Método: taxonomia de padrões de data race | 1 | **qualificação** | analítica |
| 4.3 Método: caracterização da fronteira safe/unsafe | 2 | **qualificação** | analítica / por construção |
| 4.4 Método: catalogação do espaço de design | 3 | **qualificação** | analítica |
| 4.5 A Aule como veículo de instanciação | 4 | pós-qual | construção (plano) |
| 4.6 Protocolo do experimento de custo | 5–7 | pós-qual | experimental (protocolo) |
| 4.7 Protocolo: verificação por tipos vs C+MISRA | 8 | pós-qual | qualitativo (protocolo) |

> O **ponto-de-virada** (forward/`Signal`) **migra** para 4.5 (decisão de design do veículo) — deixa de ancorar 4.1–4.3, como previa o roadmap antigo. A âncora da qualificação passa a ser a fronteira + o espaço de design.

---

## 4.1 Caracterização da Pesquisa

**Perguntas que a seção responde:**
- Que tipo de pesquisa é (aplicada? básica?) e qual a abordagem?
- Quais são os **dois produtos** distintos da metodologia e como se separam: (a) caracterização analítica da fronteira + espaço de design (obj 1–3, qualificação); (b) avaliação experimental de custo + comparação de verificação (obj 4–8, pós-qual)?
- Que **natureza de evidência** cada produto gera? (por construção / "compila vs. não-compila" nos obj 1–3; numérica / ciclos e deadlines nos obj 5–8; qualitativa-comparativa no obj 8)
- Onde termina a qualificação e começa a pós-qualificação (linha obj 3 | obj 4)?

**Decisão a tomar:**
- O `.tex` atual diz "experimental e quantitativa". Mas os obj 1–3 (o que a qualificação entrega) **não** são experimentais — são analíticos. Reclassificar a natureza (candidato: pesquisa **mista** / aplicada com fase analítica + fase experimental). Decidir o rótulo.

---

## 4.2 Método: Taxonomia de Padrões de Data Race (obj 1)

**Perguntas que a seção responde:**
- O que delimita um "padrão de data race em controle concorrente"? (estado mutável compartilhado entre ≥ 2 contextos de execução de um algoritmo de controle)
- Quais os **contextos de execução** relevantes no domínio embarcado? (ISR ↔ tarefa; DMA ↔ tarefa; tarefas RTOS em prioridades distintas; núcleos distintos em multi-core)
- **De onde** os padrões são levantados? (fontes: literatura de controle embarcado; padrões canônicos de concorrência produtor-consumidor; os casos demonstrativos do cap. 5; a tabela "classe de bug × onde aparece em controle" de [`rust_memory_safety_em_controle.md`](rust_memory_safety_em_controle.md))
- Qual o **critério de inclusão/exclusão** de um padrão? (precisa: aparecer em algoritmo de controle real **e** ser data race especificamente — não outra classe de memory bug)
- Como a taxonomia é **estruturada**? **Decidido (2026-06-04):** três eixos a cruzar —
  - **par de contextos** (ISR↔tarefa; DMA↔tarefa; tarefa↔tarefa por prioridade; core↔core);
  - **estrutura do dado compartilhado** (escalar/flag — setpoint, modo; buffer/fila — amostras; struct coerente — `x̂`+`P` do estimador);
  - **padrão de acesso** (produtor→consumidor; leitor↔escritor; read-modify-write compartilhado).
  Cada célula relevante = um padrão; os casos do cap. 5 instanciam células específicas.

**Saída (entregável do obj 1):** a taxonomia em si (tabela/figura), pronta para alimentar 4.3.

**Nota de escopo (honestidade):** a taxonomia é só de **data race** — não cobre OOB, UAF, uninit. **Decidido (2026-06-04):** delay line (Caso 1, OOB/uninit) e MPC workspace (Caso 3, UAF) saem do núcleo — não são data race. Os casos do cap. 5 instanciam células de DR: setpoint escalar (didático/abertura), ISR/DMA→buffer (central), estado composto estimador↔controlador.

---

## 4.3 Método: Caracterização da Fronteira safe/unsafe (obj 2)

**Perguntas que a seção responde:**
- Para cada padrão da taxonomia (4.2), qual o **procedimento** para localizar a fronteira? (tentar exprimir o padrão em Rust *safe*; registrar o que o compilador recusa — `Send`/`Sync`/borrow — e onde força `unsafe`)
- O que define o **lado safe** vs. o **lado unsafe** de um padrão? (safe = exprimível sem `unsafe`, garantia codificada no tipo; unsafe = exige bloco `unsafe` / FFI / acesso direto a registrador / `static mut`)
- Qual o **critério de evidência** da fronteira? (compila vs. não-compila; mensagem do borrow checker; obrigação de `Send`+`Sync`)
- Como tratar padrões que caem **dos dois lados**? (ex.: ISR↔DMA — a fila SPSC é safe, mas o acesso ao registrador do periférico é `unsafe` dentro da HAL; a fronteira passa *dentro* do padrão)
- Que **ferramentas** apoiam a caracterização? (`rustc`; inspeção de `Send`/`Sync`; `miri` para UB em testes; `cargo-call-stack` fica fora — é outra classe)

**Saída (entregável do obj 2):** o mapa da fronteira por padrão.

---

## 4.4 Método: Catalogação do Espaço de Design das Garantias (obj 3)

**Perguntas que a seção responde:**
- Para os padrões do **lado safe**, quais as **alternativas** de implementar a sincronização que torna o data race inexprimível? Candidatos a eixos: atomics / lock-free; `Mutex` / critical-section; message-passing (SPSC `heapless::Queue`); recursos do RTIC (priority-ceiling); `Arc` / refcount; cópia *owned* (sem compartilhar ponteiro).
- O que é um **"eixo"** do espaço de design? (dimensão de escolha independente — ex.: cópia vs. compartilhamento; bloqueante vs. lock-free; estático/`no_std` vs. heap)
- Qual o **critério** para considerar o espaço "catalogado"? (cada padrão safe mapeado às opções viáveis em `no_std`, com trade-offs anotados: custo de runtime, ergonomia, footprint, determinismo)
- Como o catálogo **alimenta o obj 4**? (cada eixo → um candidato a implementar na Aule — "um por eixo")

**Saída (entregável do obj 3):** o catálogo do espaço de design. **Fecha a parte da qualificação.**

---

## 4.5 A Aule como Veículo de Instanciação (obj 4 — pós-qual, apresentar como plano)

> Aqui condensam, **reposicionadas como veículo** (não contribuição), as antigas seções "Requisitos / Arquitetura / Implementação".

**Perguntas que a seção responde:**
- Por que a Aule é o **veículo** adequado? (dá realismo aos casos vs. exemplos de brinquedo; `no_std`/embedded; já madura — ver [`aule_roadmap.md`](aule_roadmap.md))
- **Ponto-de-virada** (composição *forward* + `Signal`/monoid): por que é decisão de **memory safety** e não só de arquitetura? (mantém garantias estáticas, `no_std` sem heap — evita o `Rc<RefCell>`/arena/`unsafe` a que o grafo *backward* empurraria em Rust)
- Como traduzir o **catálogo (4.4)** em implementação? (critério "um por eixo do espaço de design")
- **Política de `unsafe`:** quando aceitar, como isolar (HAL/FFI), como **medir** o tamanho da fronteira.
- Requisitos do veículo herdados: `no_std`, `alloc` opcional, portabilidade host ↔ embedded.

**Notas de honestidade (a banca cutuca):**
- Forward é **enabler, não prova** — viabiliza, não demonstra a eliminação (a prova são os casos + experimento).
- O encadeamento via operador `*` usa `&mut dyn Block` (**dispatch dinâmico**) → **não** alegar "zero-custo" sem ressalva (o caminho monomorfizado é a chamada direta `.output()`).
- Custo do *backward* é argumento técnico + literatura (não foi implementado/medido) — ver `outline_geral.md` §ponto-de-virada.

---

## 4.6 Protocolo do Experimento de Custo (obj 5–7 — pós-qual, protocolo)

**Perguntas que a seção responde:**
- **Planta-alvo (DECIDIDO 2026-06-04):** pêndulo invertido + realimentação de estados (state feedback). Kalman/observador entra como opção (estado estimado compartilhado → célula "struct coerente" da taxonomia). Smith Predictor e MPC aposentados.
- **Plataforma:** Cortex-M0 (dos objetivos). Placa específica indefinida — plano: simulação host + HIL via `probe-rs` (já na Aule). Decidir se fecha agora ou na execução.
- **Implementações comparadas:** C + FreeRTOS + MISRA (estado da arte) vs. Rust + `heapless` + RTIC.
- **Métricas:** overhead de tempo de execução — ciclos/iteração (obj 5); perda de deadlines (obj 6); comparação dos dois entre Rust e C (obj 7).
- **Como medir** overhead/deadlines em Cortex-M0? (DWT cycle counter; instrumentação via `probe-rs`)
- **Controle de variáveis:** mesmo algoritmo, mesma plataforma, mesmas condições de carga.
- Hipótese a refutar: "Rust é mais lento" — esperado empate; como evidenciar.

**Nota:** apresentado como **protocolo** — o experimento é conceito hoje, nada implementado.

---

## 4.7 Protocolo: Verificação por Tipos vs. C+MISRA+Sanitizers (obj 8 — pós-qual, protocolo qualitativo)

**Perguntas que a seção responde:**
- Como **comparar** a verificação por tipos/compilação (Rust safe) com o estado da arte em C (MISRA + ASan/TSan/UBSan + padrões ISO)?
- **Artefato central:** para cada bug, o **trio** {snippet C que o produz; erro de compilação Rust que o impede; diagnóstico do sanitizer correspondente}.
- **Métricas qualitativas:** bugs que o sanitizer detecta em C e que **não compilam** em Rust; boilerplate de segurança eliminado (locks manuais, bounds checks, verificação de init); tamanho da fronteira `unsafe`.
- **Onde o sanitizer NÃO pega** (eixo de honestidade — ver Caso 3: UAF sob mutex que o TSan não vê porque o acesso *está* sincronizado; o problema é a vida do ponteiro).
- **Deslocamento da verificação** (eixo transversal 5): de revisão humana + ferramenta externa em runtime → para o sistema de tipos em compilação.

---

## Decisões em aberto / divergências a reconciliar

1. ~~Quais casos sob o título "data races"?~~ **RESOLVIDO (2026-06-04):** estreitar para data race puro. Caso 1 (delay line, OOB/uninit) e Caso 3 (MPC workspace, UAF) **aposentados do núcleo**. Taxonomia construída sobre padrões reais de DR (ver 4.2); casos do cap. 5 = setpoint escalar (didático) + ISR/DMA→buffer (central) + estado composto estimador↔controlador.
2. ~~Planta do experimento.~~ **RESOLVIDO (2026-06-04):** pêndulo invertido + realimentação de estados (ver 4.6). Smith Predictor + Kalman + MPC aposentados; Kalman pode reaparecer como observador.
3. ~~`no_std` vs. `std` no Caso 3.~~ **RESOLVIDO por tabela-rasa:** com o MPC fora, a questão do `Arc`/`arc_swap` em Cortex-M0 deixa de existir. Pêndulo + state feedback é `no_std`-friendly.
4. **Natureza da pesquisa (4.1):** trocar "experimental e quantitativa" por rótulo que cubra a fase analítica (obj 1–3). Ver 4.1.
5. **Fechar critérios agora ou na dissertação?** (decisão em aberto herdada do `outline_geral.md` §4).

## Pendência de manutenção do roadmap

`roadmap_escrita.md` (semana 1) ainda manda "4.1–4.3 ancorado no forward/`Signal`". Com esta reorganização, a semana 1 passa a ser **4.1–4.4** (caracterização: obj 1–3), e o forward/`Signal` migra para 4.5. Atualizar o roadmap quando esta estrutura for confirmada.
