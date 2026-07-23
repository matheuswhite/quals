---
name: ponto-retomada
description: "Cap. 4 COMPLETO ponta a ponta (4.1-4.7). 4.7 (dimensoes/trio/limites+honestidade) redigida e revisada em banca, conteudo fechado; fecho de secao + de capitulo escritos; todos os labels de secao criados; ref quebrada da 4.7 corrigida. Pendente: passe de forma geral do cap. 4. PROXIMO = cap. 5, caso setpoint escalar (P1) — caso UNICO (corte 3->1, 20/jul), intocavel. Defesa 26/ago."
metadata:
  node_type: memory
  author: Claude (claude-opus-4-8)
  created: 2026-05-31
  co-authors:
    - "Claude (claude-opus-4-8), 2026-06-05"
    - "Claude (claude-opus-4-8), 2026-06-10"
    - "Claude (claude-opus-4-8), 2026-06-14"
    - "Claude (claude-opus-4-8), 2026-06-15"
    - "Claude (claude-opus-4-8), 2026-06-18"
    - "Claude (claude-opus-4-8), 2026-06-21"
    - "Claude (claude-opus-4-8), 2026-06-26"
    - "Claude (claude-opus-4-8), 2026-07-01"
    - "Claude (claude-opus-4-8), 2026-07-04"
    - "Claude (claude-opus-4-8), 2026-07-22"
  type: project
  originSessionId: bfd04e9d-3381-42a2-bac3-e70b75a64a40
---

**Ponto de retomada — sessão de 22/jul/2026.**

## Estado do Cap. 4 — COMPLETO ponta a ponta (4.1–4.7)
- 4.1–4.6 fechadas (ver histórico no co-authors / `plan/roadmap_escrita.md`). **§4.7 (obj 8) REDIGIDA e revisada em banca — conteúdo fechado (22/jul).**
  - **4.7.1** Dimensão de comparação (`subsec:dim-comp`): 4 dimensões (momento · natureza · esforço · fronteira do inseguro), cada uma = 1 pergunta + 2 respostas (C × Rust). Controlado: mesmos P1–P4, mesmo alvo, mesmo algoritmo; varia só o regime de verificação.
  - **4.7.2** O artefato comparativo (`subsec:dim-inst`): o **trio** {snippet C (com MISRA) · Rust safe que não compila · diagnóstico do sanitizer} por padrão; mapeamento trio→dimensões; MISRA disciplina mas não mecaniza DR → resta o sanitizer (runtime); sanitizer roda no host; ISR↔tarefa (alvo) e tarefa↔tarefa (host) caem no mesmo padrão (Opção A da taxonomia).
  - **4.7.3** Limites do sanitizer e honestidade (`subsec:dim-bounds`): limites do sanitizer (cobertura dinâmica; TSan≠ASan≠UBSan → 3 execuções × 1 compilador Rust) + limites do Rust safe (não previne race condition lógica/deadlock; não elimina unsafe de borda; "compila ≠ logicamente correto"); recorte (ganho em DR, representativo, unsafe pequeno/isolado/auditável).
- **Fecho da §4.7 + fecho do capítulo** escritos (`Metodologia_Proposta.tex` ll. 447/449). Labels de todas as seções criados: `sec:research-kind` (4.1) · `sec:taxonomy` (4.2) · `sec:border` (4.3) · `sec:cost` (4.4) · `sec:aule` (4.5) · `sec:experiment-proc` (4.6) · `sec:type-system-vs-sanitizer` (4.7). A `\ref{4.7}` quebrada foi corrigida.

## Pendência do Cap. 4 (acabamento, NÃO conteúdo — passe de forma final)
- **§4.7 inteira:** acentos/concordância — "dinamica", "desarpercebido", "Há ausencia", "previnir", "expremível", "prenvensão", "deterministica", "fonteira", "são descrito os custos", "será mostrado"; **"é descrito … é descrito" DUPLICADO (l. 449)**; caixa dos sanitizers ("TSAN"→TSan); "Undefined-Behaviors".
- Heranças: 7 `\cite` vazios na 4.4.1; `\cite` do firmware na 4.6.3; ortografia das §4.5.1–3; nomes entre as 3 tabelas da 4.4.

## PRÓXIMO PASSO (sábado W7) — Cap. 5: caso setpoint escalar (P1)
- **Caso ÚNICO e profundo (corte 3→1, decisão 20/jul) — intocável.** Núcleo material do cap. 5 (`Resultados_Parciais.tex` hoje só tem `\section{Análise de Eficiência}`).
- Setpoint escalar compartilhado (tarefa de comunicação escreve × loop de controle lê): em C compila/roda com DR latente; em Rust safe o compilador recusa → força `AtomicU32` (store/load + `Ordering`). Evidência **por construção** (compila/não-compila), qualitativa, independe do experimento.
- Amarra ao cap. 4: é **P1** da taxonomia (`sec:taxonomy`); P1 fica **inteiramente safe** na fronteira (`sec:border` / 4.3.3 — sem unsafe residual, contraste com o P2); é o **trio da 4.7.2** (`subsec:dim-inst`) preenchido para P1.
- ⚠️ O snippet untracked `src/p2_snippet.rs` é do **P2** (ISR↔DMA), NÃO do caso do corte (P1/setpoint) → precisa de snippet próprio do setpoint (`AtomicU32`); o P2 vira material pós-qual (cap. 6). Confirmar.
- Roteiro completo entregue na sessão de 22/jul (registrar em `plan/` se quiser andaime versionado).

## Pendências gerais (não bloqueiam)
- **Untracked:** `refs/` (PDF de artigo — decidir versionar × `.git/info/exclude`); `src/` (`p2_snippet.rs` a versionar **+ `src/p2/target/` = build do Cargo → precisa `.gitignore` ANTES do `git add`**).
- **ESP32/Xtensa:** atômicos (`S32C1I`) — escalar (P1) tem atomic barato (bom p/ o caso setpoint: safe **e** sem custo); confirmar no `../aule` (HAL / `no_std` no alvo Xtensa).
- **Citações:** `rust-error-index`, `rust-safe-soundness` (linha RustBelt — serve à 4.3.2 **e** à 4.7.3 "safe Rust é sound"). Ver [[citacoes-pendentes]].
- `referencias.bib`: herdadas a limpar.

## Prazo (defesa qua 26/ago — parede)
- W7 (20–26/jul): **cap. 4 fecha** (4.7 ✓, resta passe de forma) + caso setpoint do cap. 5. Cap. 5 completo ~02/ago (enviar cap. 4 + cap. 5 ao Icaro juntos). Ver `plan/roadmap_escrita.md`.
