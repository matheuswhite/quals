---
name: ponto-retomada
description: "Cap. 4: §4.5 INTEIRA COMPLETA — 4.5.3 (instanciacao do catalogo + politica de unsafe) redigida 04/jul, blocos 1-4 fechados. Decisoes: blocos de sync = plan-only (dissertacao); forbid(unsafe_code) por-modulo no core; separacao de camadas descartada (so frase de reconciliacao com 4.5.2). Proxima = 4.6 (protocolo do experimento). Acabamento: ortografia das §4.5.1-3. Commits pendentes: docs 4.5.3 (.tex) + ai registro roteiro (plan). Pendencias: src/p2_snippet.rs a versionar; ESP32/HAL."
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

**Ponto de retomada — sessão de 04/jul/2026 (2ª atualização do dia).**

## Estado do Cap. 4
- **4.1, 4.2, 4.3 — COMPLETAS.** **§4.4 — COMPLETA** (26/jun; acabamento: 7 `\cite` vazios + ortografia + nomes entre as 3 tabelas + refs `sec:cost-exp*`).
- **§4.5 — INTEIRA COMPLETA (04/jul).** 4.5.1 (01/jul, `d3f641d`) · 4.5.2 (04/jul, `71d723c`) · **4.5.3 redigida 04/jul (blocos 1–4 fechados).**
- **§4.5.3 (Instanciação do catálogo + política de `unsafe`) — COMPLETA.** Roteiro registrado em `plan/cap_4_metodologia.md` (§4.5). `\label{subsec:catalogy-n-unsafe-policy}`; tabela `tab:tracking`.

## Estrutura da §4.5.2 (5 blocos, na numeração do Matheus)
1. **Abertura** — anuncia a estrutura da subseção.
2. **Mecanismo** — `Simulation`/`EndlessSimulation` (impl `Iterator`); `trait Block` com **tipos associados** `Input`/`Output`; `output(Signal<Input>) -> Signal<Output>`; operador `*` sobre `&mut dyn Block<Input=…, Output=…>` (via `Mul` + trait `AsBlock`); `Signal<T>` encapsula valor (f32/f64/Complex32/DMatrix<f32>) + estado (dt, tempo). Fecho: fluxo unidirecional; feedback só via `last_output`.
3. **Safe por construção** — cadeia A→E: (A) concorrência é requisito do HW (ISR/ADC × tarefa); (B) data race exige compartilhamento mutável; (C) forward não compartilha (por valor); (D) ⇒ sem race no núcleo; (E1) o race mora na borda = **caso P2** (`unsafe`, fora da Aule, casa 4.3.3); (E2) âncora **enabler**: a garantia é do Rust safe, não criada pelo forward.
4. **Backward e custos** — fan-out + estado mutável → múltiplas `&mut` → fere o borrow checker. 3 saídas: (1) mutabilidade interior + refcount = matriz **`Rc`/`Arc` × `RefCell`/`Mutex`** (sãs: `Rc<RefCell>` single-thread, borrow-runtime/panic; `Arc<Mutex>` multi-thread, lock/sync/deadlock; **`Rc<Mutex>` e `Arc<RefCell>` = antipadrões**); (2) arena+índices (perde verificação estática); (3) raw pointers+`unsafe` (sai do safe). Conclusão calibrada: backward é **válido**, mas **ou** sai do safe (raw ptr) **ou** move a verificação para runtime — **ao contrário** do forward (compile-time). **Analítico, não medido.**
5. **Ressalvas** — o `*` usa **dispatch dinâmico** (vtable) porque implementado sobre `&mut dyn Block` (trait object) → **não é custo zero**; `output` sobre o **tipo concreto** monomorfiza (custo zero). Custo é do **veículo** (trait object p/ ergonomia), **não da garantia** → **confound a isolar em 4.6** (`\ref{sec:experiment-proc}`).

## Estrutura da §4.5.3 (blocos 1–4; detalhe em `plan/cap_4_metodologia.md`)
1. **Ponte 4.4 + critério** — "um representante por dimensão", representativo não exaustivo (tempo verbal futuro, casa com plan-only).
2. **Mapeamento + tabela `tab:tracking`** — dimensão (4.4) → bloco planejado → feature → estado → caso; + frase de reconciliação com 4.5.2 (blocos sync = adaptadores de **borda**; núcleo forward segue safe/por valor).
3. **Política de `unsafe`** — 3 loci: HW/P2 *inevitável* (fora da Aule) · SWD *confinado* (dentro, debug/feature `swd`, único `unsafe` de hoje) · blocos sync *deliberados* (dentro, atrás de API safe). Regra: nunca no forward · API safe · invariante documentada. **`#![forbid(unsafe_code)]` por-módulo** garante o forward (NÃO crate-wide).
4. **Métrica da fronteira** (fundido no 3) — LoC `unsafe` (tamanho) + avaliação da invariante (correção); medição em 4.6.

**Decisões da sessão (04/jul):** blocos de sync = **plan-only** (implementação é dissertação; generaliza out-of-box ISR↔DMA do cap. 6); **separação "Aule × integração" descartada** do texto (descrevia o hoje, contradiria o plano de levar sync p/ dentro da Aule); **`forbid` adotado no core**. Fatos do `../aule` confirmados nesta sessão: core `no_std` sem `forbid` hoje; `unsafe` só em `tier1/bridge/swd.rs`; `Observer` sob `alloc`.

## Acabamento pendente da §4.5.3 (Claude aponta, Matheus aplica — NÃO é conteúdo)
- Ortografia da l. 310: `devem` existir · `Estes` limites · `concorrência` (2×) · `sincronização` · `políticas` · `superfície` · `APIs safe` · `promessa de que` · `são medidas as LoC` · `invariante documentada` (caiu o "-da").

## Acabamento pendente da §4.5.2 (Claude aponta, Matheus aplica — NÃO é conteúdo)
- Ortografia acumulada dos par. 272–284: `o junção`→a junção (278); `referencia(s)`; `concorrencia`; `principio`; `calculo`; `indice(s)`; `possivel`; `mantem`; `analitica`; `monorfização`→monomorfização; `despacho dinamico`; `por que`→porque (causal); `pode se ver`→pode-se; `Esse é uma maneira`→Essa é; `operador multiplicação`→de multiplicação; concordâncias (`a transmissão dos dados são`); `Por fim… ponto final` (redundância).

## Pendências a confirmar no ../aule (repo AUSENTE neste device) — antes da defesa
- `last_output` retorna **por valor/cópia** (snapshot)? — sustenta o feedback k/k-1 (bloco 3).
- `trait Block` tem mesmo `type Input`/`Output` e é usado como `dyn Block<Input=…, Output=…>`? existe `AsBlock` (retorna `&mut dyn Block`)?
- `Signal<T>` é genérico (não enum)? `Copy` p/ f32/f64 e *move* p/ DMatrix?
- `EndlessSimulation` existe com esse nome? ambos impl `Iterator`?
- (fatos da 4.5.1) observador/SS exigem `alloc`? feature `swd`?

## Próxima etapa
- **§4.6 (Protocolo do experimento de Custo)** — próxima a redigir. Label `sec:experiment-proc` JÁ existe; subseções 4.6.1–4.6.4 em esqueleto. **Isolar custo do dispatch dinâmico = confound** (herdado da ressalva da 4.5.2). Métrica da fronteira `unsafe` (LoC + invariante) é medida AQUI (a 4.5.3 só definiu).
- Depois: 4.7 (verificação por tipos vs C+MISRA+sanitizers) → **cap. 4 completo, enviar ao Icaro**.

## Pendências gerais (não bloqueiam)
- **Commit 4.5.3 — FEITO:** `d58ca5a` (docs, `.tex`) + `5d1135f` (ai, registro roteiro no `plan/`). Falta commitar só a atualização de roadmap + ponto de retomada (este arquivo) — `ai:`.
- **`src/p2_snippet.rs`** (+`src/p2/`) AINDA untracked — `\coderust` da 4.3.3; build quebra p/ quem clonar. `refs/` (PDF Helmbold & McDowell) a decidir versionar × gitignore.
- ⚠️ **ESP32 / HAL da Aule** — sustenta "implementar em hardware" (4.5.1) + plataforma (4.6). Atômicos Xtensa (`S32C1I`) — peso do P4. (Decisão 2026-06-15.)
- Acabamento §4.4: 7 `\cite{}` vazios + ortografia + nomes entre as 3 tabelas.
- Citações 4.3.2: `rust-error-index`, `rust-safe-soundness` — ver [[citacoes-pendentes]].
- `referencias.bib`: ~46 herdadas a limpar; validar 12; autores de `sharma2024rust`.
- Roteiros dos blocos 2–5 da 4.5.2: sugerido registrar em `plan/*.md` (andaime) — ainda não feito.

## Roadmap / prazo
- **§4.5 inteira ✓ (04/jul).** Restam 4.6 + 4.7 no cap. 4. Cap. 4 completo ~12/jul (marco W5); cap. 5 ~26/jul; **parede dura 31/ago/2026**; ~1 seção/semana. No prazo, com respiro.
