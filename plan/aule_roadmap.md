---
author: Claude (claude-opus-4-7)
created: 2026-05-20
modified:
  - 2026-05-20: Claude (claude-opus-4-7) — added LTeX disable magic comment
  - 2026-05-28: Claude (claude-opus-4-7) — fixed cross-reference to meeting_alan.md (now mirrored in plan/)
  - 2026-05-28: Claude (claude-opus-4-7) — corrected advisor attribution (Icaro is the advisor; Alan is an idea collaborator)
---

<!-- LTeX: enabled=false -->

# Roadmap da Biblioteca `aule` — Lacunas e Priorização

Análise comparando o estado atual de `aule` com uma toolbox de referência de controle (MATLAB Control System Toolbox + `python-control`), e proposta de fases de evolução alinhada à direção da tese registrada em [`meeting_alan.md`](meeting_alan.md).

## Estado atual

### Cobertura existente

| Categoria | O que está implementado |
|---|---|
| Abstração de simulação | `Block` trait + `Simulation` iterator + `Signal<T>`, com operadores algébricos para encadear blocos |
| Representações | `Tf`, `SS` (contínuo) e `DTf`, `DSS` (discreto) — **SISO apenas** |
| Variáveis simbólicas | `s`, `z`, `z⁻¹` ao estilo MATLAB |
| Polinômios | `Polynomial<T>` genérico em `Float`, com `+`, `-`, `*`, divisão, companion matrix |
| Integradores | Euler, RK4 |
| Conversões | TF → SS canônica controlável |
| PID | Com anti-windup por *integrator clamping* |
| Filtros | LP/HP 1ª ordem; Biquad, Butterworth, Chebyshev I/II, Bessel, BP/BS 2ª ordem |
| Outros blocos | Delay, Saturation, Observador de Luenberger (L fornecido externamente) |
| Identificação | 1ª ordem: Ziegler-Nichols, Hägglund, Smith, Sundaresan-Krishnaswamy. 2ª ordem: Mollenkamp, Smith — todas via resposta ao degrau |
| Sinais de entrada | step, ramp, impulse, sinusoid, square, sawtooth, CSV |
| Métricas | IAE, ISE, ITAE, Good-Hart |
| I/O | Plotter, RTPlotter, Writer (CSV), Printer |
| Tier 2 | Smith Predictor (com e sem filtro) |
| Embarcado | `no_std` via features; ponte SWD para HIL com probe-rs |

### Pontos fortes arquiteturais

- `no_std` correto com gating por features (`std`, `alloc`, `swd`)
- Generics em `Float` (f32/f64)
- Ergonomia do `s`/`z` algébrico próxima ao MATLAB
- `RTPlotter` + bridge SWD destravam HIL — diferencial sobre MATLAB/`python-control`
- Anti-windup de PID corretamente separado em modo de saturação superior/inferior

---

## Lacunas por categoria

### A) Análise em frequência — praticamente ausente

| Item | Status | Comentário |
|---|---|---|
| Avaliação H(jω) | ✗ | Falta `Polynomial::eval_complex(jω)` |
| Diagrama de Bode (magnitude/fase) | ✗ | Plotter também não existe |
| Diagrama de Nyquist | ✗ | |
| Carta de Nichols | ✗ | |
| Margem de ganho / margem de fase | ✗ | Precisa de cruzamentos de 0 dB e -180° |
| Margem de atraso | ✗ | |
| Frequência de cruzamento (ωc, ωg) | ✗ | |
| Banda passante / largura de banda | ✗ | |
| Pico de ressonância Mr, ωr | ✗ | |
| Sensitividade S, complementar T | ✗ | |
| Disk margin | ✗ | |

**Pré-requisito:** suporte a `Complex<T>` no `Polynomial`.

### B) Análise de resposta temporal — só os geradores

| Item | Status |
|---|---|
| Rise time (10–90 %, 0–100 %) | ✗ |
| Settling time (2 %, 5 %) | ✗ |
| Overshoot % (Mp) | ✗ |
| Peak time tp | ✗ |
| Steady-state value, steady-state error | ✗ |
| Delay time | ✗ |
| Pulse / ramp / resposta arbitrária | parcial (existem os geradores, não a análise) |

Já existe esqueleto comentado em `src/tier3/mod.rs` (`step_response`).

### C) Análise de polos/zeros e root locus

| Item | Status |
|---|---|
| Root finder para polinômios | ✗ (faer expõe autovalores; falta wrapper) |
| Pole–zero map | ✗ |
| Root locus (varredura em K) | ✗ |
| Routh-Hurwitz (estabilidade contínua) | ✗ |
| Jury (estabilidade discreta) | ✗ |
| Critério de Nyquist | ✗ |

### D) Espaço de estados — análise estrutural

| Item | Status |
|---|---|
| Matriz de controlabilidade `[B AB A²B ...]` | ✗ |
| Matriz de observabilidade `[C; CA; CA²; ...]` | ✗ |
| Gramianos de controlabilidade/observabilidade | ✗ |
| Decomposição de Kalman | ✗ |
| Realização mínima | ✗ |
| Formas canônicas observável, de Jordan, modal | parcial (apenas controlável) |
| Realização balanceada + redução de ordem (Hankel) | ✗ |
| Verificação de estabilidade via autovalores de A | ✗ |

### E) MIMO — limitação estrutural

`SS::new` força `b: column`, `c: row`, `d: scalar`. `Tf` opera sobre polinômios escalares. Implicações:

- LQR, LQG, MPC genéricos exigem MIMO
- Decoupling, SVD de plantas, RGA (Relative Gain Array)
- Matriz de funções de transferência (TFM): `Mat<Tf<T>>`

Esse é o redesenho mais impactante: trocar `Mat<T>` para `B`, `C`, `D` MIMO afeta toda a hierarquia abaixo. **Decisão crítica:** fazer antes de qualquer MPC/LQR.

### F) Conversão contínuo ↔ discreto

| Item | Status |
|---|---|
| `c2d` ZOH (Zero-Order Hold) | ✗ |
| `c2d` Tustin (bilinear) com pré-warp | ✗ |
| `c2d` FOH, matched, impulse-invariant | ✗ |
| `d2c` | ✗ |

Hoje, ir de um `Tf` contínuo identificado para um `DTf` discreto pro PID embarcado é manual.

### G) Álgebra de interconexão — só simulada, não simbólica

Loop fechado é simulável via operadores, mas não há:

| Item | Status |
|---|---|
| `series(G1, G2)` → TF resultante | ✗ |
| `parallel(G1, G2)` | ✗ |
| `feedback(G, H)` → `G/(1+GH)` | ✗ |
| `connect()` (block diagram → TF/SS unificado) | ✗ |
| SS → TF | ✗ (só TF → SS) |

Sem isso, não dá pra computar margens do *loop transfer* `L = GK` antes de simular.

### H) Identificação — restrita a degrau, 1ª/2ª ordem

| Item | Status |
|---|---|
| Resposta ao degrau, 1ª/2ª ordem | ✓ |
| Resposta ao impulso / PRBS / chirp | ✗ |
| ARX, ARMAX, OE, Box-Jenkins | ✗ |
| Mínimos quadrados em batch | ✗ |
| RLS (recursivo, online) | ✗ |
| Subespaço (N4SID, MOESP) | ✗ |
| Identificação no domínio da frequência | ✗ |
| NARX / NARMAX (não-linear) | ✗ — apesar de o Aguirre estar nas referências |
| Métricas de validação (FIT %, autocorr. dos resíduos, correlação cruzada) | ✗ |
| Geração de PRBS | ✗ |

### I) Controladores avançados

| Item | Status | Prioridade pra tese |
|---|---|---|
| **MPC** (linear, com restrições) | ✗ | **Alta** — em `meeting_alan.md` |
| **IMC** (Internal Model Control) | ✗ | **Alta** — em `meeting_alan.md` |
| LQR (Riccati algébrica contínua/discreta) | ✗ | Alta |
| LQG (LQR + Kalman) | ✗ | Alta |
| Pole placement (Ackermann, place) | ✗ | Média |
| Feedforward | ✗ | Média |
| Gain scheduling estruturado | ✗ | Média |
| Cascata estruturada | ✗ | Média |
| Adaptativo (MRAC, STR) | ✗ | Baixa |
| Sliding mode | ✗ | Baixa |
| H∞ / H2 | ✗ | Baixa |
| Repetitivo / ILC | ✗ | Baixa |

### J) Estimação não-linear — só Luenberger linear

| Item | Status |
|---|---|
| Kalman filter (KF linear discreto) | ✗ |
| EKF (Estendido) | ✗ |
| UKF (Unscented) | ✗ |
| Particle filter | ✗ |
| Moving Horizon Estimation | ✗ |
| Cálculo automático de L (Luenberger) via pole placement | ✗ — usuário fornece L pronto |

### K) Sintonia automática de PID — ausente

Identificação de planta existe, mas **não há regras de sintonia**:

| Regra | Status |
|---|---|
| Ziegler-Nichols (resposta) | ✗ |
| Ziegler-Nichols (oscilação) | ✗ |
| Cohen-Coon | ✗ |
| IMC tuning (Rivera-Morari) | ✗ |
| Skogestad SIMC | ✗ |
| AMIGO (Åström-Hägglund) | ✗ |
| Lambda tuning | ✗ |

Hoje, `ZieglerNichols` é apenas identificação de modelo (K, τ, θ).

### L) Otimização — ausente

Para MPC, IMC com restrições:

| Item | Status |
|---|---|
| Solver QP | ✗ |
| Solver LP | ✗ |
| Solver NLP | ✗ |

Caminhos: bindings para `osqp`, `clarabel-rs` (puro Rust), `argmin` (framework Rust).

### M) Análise não-linear — ausente

| Item | Status |
|---|---|
| Linearização em ponto de operação | ✗ |
| Função descritiva | ✗ |
| Retrato de fase | ✗ |
| Lyapunov (busca direta / SOS) | ✗ |
| Bifurcação | ✗ |

### N) Robustez — ausente

Sensitividades S, T, KS, SG; ganhos estruturados; análise μ; *stability margins* clássicas além de ganho/fase.

### O) Plantas de referência — ausente

Sem biblioteca de modelos canônicos pra benchmark/exemplo:

- DC motor, BLDC, PMSM
- Massa-mola-amortecedor
- Pêndulo invertido / carro-pêndulo
- Ball-on-beam, ball-and-plate
- Tanques (acoplados, série)
- Quadrotor (linearizado)
- Trocador de calor
- Distillation column (Wood-Berry)

Útil pra documentação e validação cruzada (mesmo benchmark MATLAB ↔ aule).

### P) Verificação e testes

| Item | Status |
|---|---|
| Testes unitários em alguns blocos | parcial |
| Property-based (proptest, quickcheck) | ✗ |
| Benchmarks (Criterion) | ✗ |
| Fuzzing | ✗ |
| Verificação formal (Kani, Creusot, Prusti) | ✗ — **mencionado em `meeting_alan.md`** |
| CI configurado | parcial (existe `.github/`) |
| Documentação API (rustdoc) | quase ausente |
| Comparação numérica contra `python-control` | ✗ |

### Q) Suporte de hardware

| Item | Status |
|---|---|
| Bridge SWD via probe-rs | ✓ |
| Integração `embedded-hal` (ADC, PWM, GPIO) | ✗ |
| Padrão RTIC / Embassy para tarefas | ✗ |
| Codegen / lookup tables com `const fn` | ✗ |
| Análise de pilha (`cargo-call-stack` hook) | ✗ |

---

## Roadmap proposto

A direção da tese registrada em `meeting_alan.md` aponta para **dead-time + MPC/IMC + segurança de buffer + borrow checker + verificação formal**. As fases abaixo priorizam:

1. fechar os gaps mais visíveis numa toolbox de controle,
2. destravar MPC/IMC (objetivo central da tese),
3. extrair o diferencial Rust que justifica a tese.

### Fase 1 — Fundamentos faltantes (alto retorno, baixo esforço)

| # | Item | Esforço | Destrava |
|---|---|---|---|
| 1 | **Resposta em frequência**: `Complex<T>` no `Polynomial`, avaliação H(jω), Bode plotter, margens de ganho/fase | Médio | Análise clássica completa, comparação visual com MATLAB |
| 2 | **Métricas de resposta temporal** (rise, settling, %OS, ess) — terminar `tier3/step_response` | Baixo | Apresentar resultados de PID com métricas padrão |
| 3 | **Álgebra de TFs** (`series`, `parallel`, `feedback`) | Baixo | Computar `L = GK`, `T = L/(1+L)` simbolicamente |
| 4 | **`c2d` Tustin + ZOH** | Baixo-Médio | Deploy embarcado a partir de planta contínua |
| 5 | **Routh-Hurwitz + Jury** | Baixo | Análise simbólica de estabilidade |

### Fase 2 — Núcleo da tese (MPC/IMC + dead-time)

| # | Item | Esforço | Destrava |
|---|---|---|---|
| 6 | **MIMO em SS** — pré-requisito pra LQR/MPC genéricos | **Alto** (refator) | LQR, LQG, MPC; **fazer antes do resto desta fase** |
| 7 | **Kalman filter discreto** (caso particular de Luenberger com L ótimo via Riccati) | Médio | Estimação probabilística |
| 8 | **LQR** com Riccati algébrica discreta (DARE) | Médio | Síntese ótima quadrática |
| 9 | **IMC** (sintonia + estrutura) | Médio | Tema central do `meeting_alan.md` |
| 10 | **MPC linear com restrições**, solver QP via `clarabel-rs` ou `osqp` | Alto | Tema central do `meeting_alan.md` |

### Fase 3 — Diferencial Rust (alinhado com a tese)

| # | Item | Esforço | Destrava |
|---|---|---|---|
| 11 | **Property-based tests** (proptest) para PID, filtros, SS — invariantes (estabilidade BIBO, monotonicidade de magnitude de filtro, anti-windup) | Médio | Argumento "testamos propriedades, não casos" |
| 12 | **Verificação formal com Kani** em blocos chave — provar ausência de panic em `PID::block`, `DelayLine::step`, etc. para faixas de entrada | Médio-Alto | Tema "prova formal da segurança do Rust" do `meeting_alan.md` |
| 13 | **Integração `embedded-hal` + RTIC** — exemplo completo rodando o mesmo PID/MPC em hardware real | Médio | Fecha o argumento "isso roda em motor real, não só simulação" |

### Fase 4 — Polimento de toolbox (pós-tese, se houver tempo)

- Root locus, Nichols, sensitividades, robustez
- Identificação além de degrau (ARX, RLS, PRBS)
- EKF / UKF
- Biblioteca de plantas de referência
- Sintonia automática de PID (Cohen-Coon, AMIGO, SIMC)
- Análise não-linear (linearização, função descritiva)

---

## Observação arquitetural

O `Block` trait carrega `SimulationState` no método `block(input, sim_state)`. Elegante pra simulação, mas amarra o controlador ao loop de `Simulation`. Pra rodar o mesmo `PID` em hardware real (sem `Simulation`), o usuário acaba criando um `SimulationState` artificial só pra cumprir a assinatura — visível implicitamente nos exemplos.

**Sugestão de refator antes da Fase 3:**

```rust
trait Controller {
    type Input;
    type Output;
    fn update(&mut self, input: Self::Input, dt: Duration) -> Self::Output;
    fn reset(&mut self);
}

trait Block: Controller {
    fn block(&mut self, input: Self::Input, sim_state: SimulationState) -> Self::Output {
        self.update(input, sim_state.dt())
    }
    // ... resto da API atual
}
```

Assim:
- O caminho embarcado (RTIC, Embassy) consome `Controller` sem fricção
- O caminho de simulação continua usando `Block` como hoje
- Mesma implementação cobre os dois casos — alinhado com o argumento "o mesmo código roda em simulação e em hardware" que a tese pode explorar

---

## Próximos passos recomendados

1. **Validar o roadmap** — confirmar ordem das fases com o orientador (Icaro) e com Alan (colaborador de ideias).
2. **Começar pela Fase 1** — entrega visível e rápida, fecha a pergunta "isso é uma toolbox de controle?".
3. **Tomar decisão arquitetural sobre MIMO cedo** — quanto mais código depender de SISO, mais caro o refator depois.
4. **Documentar com rustdoc + benchmarks** desde a Fase 1 — o capítulo "implementação" da tese se beneficia de docs autogeradas e gráficos de performance vs `python-control`.
