---
name: ponto-retomada
description: "Cap. 4: §4.5.2 (composicao forward como decisao de memory safety) COMPLETA — 5 blocos fechados no argumento (04/jul). Proxima = 4.5.3 (instanciacao do catalogo + politica de unsafe). Acabamento: ortografia da 4.5. Reconferir no ../aule (ausente): last_output por valor?, Block com tipos associados?, Signal generico?, EndlessSimulation?. Pendencias: src/p2_snippet.rs a versionar; ESP32/HAL; commit 4.5.2 staged."
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-14
  - Claude (claude-opus-4-8), 2026-06-15
  - Claude (claude-opus-4-8), 2026-06-18
  - Claude (claude-opus-4-8), 2026-06-21
  - Claude (claude-opus-4-8), 2026-06-26
  - Claude (claude-opus-4-8), 2026-07-01
  - Claude (claude-opus-4-8), 2026-07-04
metadata:
  type: project
---

**Ponto de retomada — sessão de 04/jul/2026.**

## Estado do Cap. 4
- **4.1, 4.2, 4.3 — COMPLETAS.** **§4.4 — COMPLETA** (26/jun; acabamento: 7 `\cite` vazios + ortografia + nomes entre as 3 tabelas + refs `sec:cost-exp*`).
- **§4.5.1 — FECHADA no argumento** (01/jul, commit `d3f641d`). Acabamento ortográfico pode não ter sido aplicado (lista no histórico).
- **§4.5.2 (Composição forward como decisão de memory safety) — COMPLETA, os 5 blocos fechados no argumento (04/jul).**

## Estrutura da §4.5.2 (5 blocos, na numeração do Matheus)
1. **Abertura** — anuncia a estrutura da subseção.
2. **Mecanismo** — `Simulation`/`EndlessSimulation` (impl `Iterator`); `trait Block` com **tipos associados** `Input`/`Output`; `output(Signal<Input>) -> Signal<Output>`; operador `*` sobre `&mut dyn Block<Input=…, Output=…>` (via `Mul` + trait `AsBlock`); `Signal<T>` encapsula valor (f32/f64/Complex32/DMatrix<f32>) + estado (dt, tempo). Fecho: fluxo unidirecional; feedback só via `last_output`.
3. **Safe por construção** — cadeia A→E: (A) concorrência é requisito do HW (ISR/ADC × tarefa); (B) data race exige compartilhamento mutável; (C) forward não compartilha (por valor); (D) ⇒ sem race no núcleo; (E1) o race mora na borda = **caso P2** (`unsafe`, fora da Aule, casa 4.3.3); (E2) âncora **enabler**: a garantia é do Rust safe, não criada pelo forward.
4. **Backward e custos** — fan-out + estado mutável → múltiplas `&mut` → fere o borrow checker. 3 saídas: (1) mutabilidade interior + refcount = matriz **`Rc`/`Arc` × `RefCell`/`Mutex`** (sãs: `Rc<RefCell>` single-thread, borrow-runtime/panic; `Arc<Mutex>` multi-thread, lock/sync/deadlock; **`Rc<Mutex>` e `Arc<RefCell>` = antipadrões**); (2) arena+índices (perde verificação estática); (3) raw pointers+`unsafe` (sai do safe). Conclusão calibrada: backward é **válido**, mas **ou** sai do safe (raw ptr) **ou** move a verificação para runtime — **ao contrário** do forward (compile-time). **Analítico, não medido.**
5. **Ressalvas** — o `*` usa **dispatch dinâmico** (vtable) porque implementado sobre `&mut dyn Block` (trait object) → **não é custo zero**; `output` sobre o **tipo concreto** monomorfiza (custo zero). Custo é do **veículo** (trait object p/ ergonomia), **não da garantia** → **confound a isolar em 4.6** (`\ref{sec:experiment-proc}`).

## Acabamento pendente da §4.5.2 (Claude aponta, Matheus aplica — NÃO é conteúdo)
- Ortografia acumulada dos par. 272–284: `o junção`→a junção (278); `referencia(s)`; `concorrencia`; `principio`; `calculo`; `indice(s)`; `possivel`; `mantem`; `analitica`; `monorfização`→monomorfização; `despacho dinamico`; `por que`→porque (causal); `pode se ver`→pode-se; `Esse é uma maneira`→Essa é; `operador multiplicação`→de multiplicação; concordâncias (`a transmissão dos dados são`); `Por fim… ponto final` (redundância).

## Pendências a confirmar no ../aule (repo AUSENTE neste device) — antes da defesa
- `last_output` retorna **por valor/cópia** (snapshot)? — sustenta o feedback k/k-1 (bloco 3).
- `trait Block` tem mesmo `type Input`/`Output` e é usado como `dyn Block<Input=…, Output=…>`? existe `AsBlock` (retorna `&mut dyn Block`)?
- `Signal<T>` é genérico (não enum)? `Copy` p/ f32/f64 e *move* p/ DMatrix?
- `EndlessSimulation` existe com esse nome? ambos impl `Iterator`?
- (fatos da 4.5.1) observador/SS exigem `alloc`? feature `swd`?

## Próxima etapa
- **§4.5.3 (Instanciação do catálogo + política de `unsafe`)** — próxima a redigir.
- Depois: 4.6 (protocolo; label `sec:experiment-proc` JÁ existe; isolar custo do dispatch dinâmico = confound), 4.7.

## Pendências gerais (não bloqueiam)
- **Commit 4.5.2:** `.tex` staged; mensagem `docs:` sugerida (sem `Co-Authored-By` — prosa do Matheus, Claude não editou o `.tex`). Branch **1 atrás** de `origin/main` (`dfafd46 WIP`) → após commitar, `git pull --rebase`.
- **`src/p2_snippet.rs`** (+`src/p2/`) AINDA untracked — `\coderust` da 4.3.3; build quebra p/ quem clonar. `refs/` (PDF Helmbold & McDowell) a decidir versionar × gitignore.
- ⚠️ **ESP32 / HAL da Aule** — sustenta "implementar em hardware" (4.5.1) + plataforma (4.6). Atômicos Xtensa (`S32C1I`) — peso do P4. (Decisão 2026-06-15.)
- Acabamento §4.4: 7 `\cite{}` vazios + ortografia + nomes entre as 3 tabelas.
- Citações 4.3.2: `rust-error-index`, `rust-safe-soundness` — ver [[citacoes-pendentes]].
- `referencias.bib`: ~46 herdadas a limpar; validar 12; autores de `sharma2024rust`.
- Roteiros dos blocos 2–5 da 4.5.2: sugerido registrar em `plan/*.md` (andaime) — ainda não feito.

## Roadmap / prazo
- §4.5.1 ✓, §4.5.2 ✓. Cap. 4 completo ~12–19/jul; cap. 5 ~02/ago; **parede dura 31/ago/2026**; ~1 seção/semana.
