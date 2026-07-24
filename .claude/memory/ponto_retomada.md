---
name: ponto-retomada
description: "Cap. 4 COMPLETO (4.1-4.7). Cap. 5 em andamento: 5.2.1 (cenario P1) e 5.2.2 (data race em C, com listagem do TSan) ESCRITAS + revisadas em banca + defensaveis, mas UNCOMMITTED (msgs docs: dadas). PROXIMO (sabado W7) = 5.2.3 (recusa do rustc, E0277) -> 5.2.4 (atomic) -> 5.2.5 (trio). Snippets src/p1 prontos e outputs (rustc+TSan) salvos. PAREDE REAL = ENTREGA 11/ago (nao 26/ago). ROADMAP DESATUALIZADO: diz 4.7 esqueleto, mas esta completa - corrigir."
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
    - "Claude (claude-opus-4-8), 2026-07-23"
  type: project
  originSessionId: bfd04e9d-3381-42a2-bac3-e70b75a64a40
---

**Ponto de retomada — sessão de 23/jul/2026 (noite). Salvo para o sábado (W7, 25/jul).**

## ⏭️ PRÓXIMO PASSO (sábado W7) = §5.2.3 — A recusa do compilador em Rust safe
`Resultados_Parciais.tex`, `\label{subsec:setpoint-reject}`. É o **CLÍMAX** do caso: o mesmo padrão P1, em Rust safe, que **NÃO compila**.
- Onde entra a **mensagem real do `rustc` (`E0277`, `Cell<f32>` não é `Sync`)** que o Matheus já salvou → colar como listagem (`lstlisting` inline igual ao TSan da §5.2.2, ou `\lstinputlisting` de arquivo em `src/p1/`).
- **Reusar** o critério da §4.3.2 via `\ref{subsec:unsafe-criteria}` — NÃO re-derivar.
- Verbo desta subseção: o compilador **recusa** (contraste com "compila e cala" da §5.2.2). É a evidência primária.
- Depois: **§5.2.4** (forma segura com `AtomicU32` — store/load + `Ordering`; DR inexprimível) → **§5.2.5** (leitura como evidência = **trio da §4.7.2** preenchido p/ P1; P1 100% safe, sem `unsafe` residual, contraste com o P2). **§5.1** (estado da Aule; `Mirror::Primitive32`) e **§5.3** (limitações) em NOITES.

## Estado do Cap. 5 (23/jul) — §5.2.1 e §5.2.2 ESCRITAS, revisadas em banca, DEFENSÁVEIS
- **§5.2.1 (Cenário e o padrão P1, `subsec:setpoint-scenario`):** setpoint escalar; tarefa comm (escreve) × loop de controle (lê); mapeia p/ P1 ⟨Tarefa-Tarefa, Escalar, Leitor-Escritor⟩ pelo **teste de distinção** (cabe em atômico → corta P3; não depende do valor anterior → corta P4); **exclusão justificada da Aule** (P1 mora na borda; usar a lib passaria a ideia de que a garantia é da lib, não do Rust). Furos fechados na revisão: hazard reamarrado à definição de DR ("indivisível e ordenado"); exemplo do pêndulo trocado (colidia com o P3 do §4.6); `\text{}` na tupla.
- **§5.2.2 (O data race em C, `subsec:setpoint-c`):** mapeia as 4 cláusulas da definição (`\ref{sec:dr-def}`); C **compila e cala**; hazard latente/não-determinístico; **TSan confirma** via `lstlisting` inline (`label=code:tsan-out`, saída real: T1 `comm_task` write / T2 `control_loop` read / global `g_setpoint`, 4 bytes); **versão ingênua = não é strawman**. Furos fechados: "mais de 1 escrita"→"pelo menos 1"; `$\text{g_setpoint}$` (erro do `_`)→escapado.
- **Ambas UNCOMMITTED.** Working tree: só `capitulos/Resultados_Parciais.tex` (+46/−1). Msgs dadas (`docs:`, **SEM** trailer Claude — é prosa do Matheus): `docs: redige 5.2.1 (cenario e o padrao P1) do cap. 5` e `docs: redige 5.2.2 (o data race em C) com listagem do TSan`. Split de hunk no lazygit (as duas no mesmo arquivo). Untracked à parte: `.vscode/ltex.*` (fora destes commits).
- Miudezas restantes (NÃO furo): usar `\texttt{}` p/ identificadores (`$\text{...}$` renderiza romano, não monospace); "por que"→"porque" causal (§5.2.2); legenda da listagem com "no...no".

## Snippets + outputs (src/p1) — PRONTOS e EXECUTADOS
`setpoint.c` (compila/roda/DR latente), `setpoint_safe.rs` (recusa `E0277`, `Cell<f32>` não é `Sync`), `setpoint_atomic.rs` (`Arc<AtomicU32>` — prefigura `Mirror::Primitive32`). Mensagem do `rustc` e saída do TSan **já salvas/coladas**. `src/**/target/` no `.gitignore`.

## Cap. 4 — COMPLETO ponta a ponta (4.1–4.7 + fecho). Só passe de forma pendente.
(4.7 redigida 20–22/jul, commits `12cf47f`/`f97e8e3`/`aa76250`; detalhe da 4.7 no histórico anterior deste arquivo.) Acabamento: **6 `\cite{}` vazios** (5 na 4.4.1 l.214 + 1 na 4.6.3 l.389 firmware); **tabela do resultado da sonda é TODO na §4.3.3 (l.154 — lacuna de conteúdo, não só forma)**; ortografia §4.5/§4.7; nomes entre as 3 tabelas da 4.4. `sec:dr-def`/`sec:dr-vs-race` seguem `??` (cap. 3 é esqueleto; nascem na W8).

## ⚠️ ROADMAP DESATUALIZADO — corrigir
`plan/roadmap_escrita.md` (commitado 23/jul, `5a16681`) ainda diz "**4.7 é só esqueleto**" e "cap. 4 não fechou" — FALSO: a 4.7 foi redigida em 20–22/jul, ANTES desse replan. A "Situação atual" + a tarefa de domingo W7 ("fechar 4.7") + a "Ação urgente" (enviar só 4.1–4.6) precisam de conserto: **o cap. 4 está inteiro → enviar o cap. 4 COMPLETO ao Icaro.** (O ponto de retomada LOCAL estava travado em 04/jul; re-sincronizado com o espelho do repo nesta sessão.)

## PAREDE REAL = ENTREGA à banca em ter 11/ago (15 dias corridos antes da defesa qua 26/ago)
NÃO é 26/ago. O período 12–26/ago é pós-entrega (só apresentação). Da janela (a partir de 23/jul) sobram: **3 sábados (25/jul, 01/ago, 08/ago) + ~8 noites**. Sábado 08/ago = **REVISÃO** (não escrita). Cortes já acionados: casos 3→1, 4.7/cap.1/cap.2 em noites. Núcleo intocável: caso setpoint (cap.5), protocolo (4.6), 3.3/3.4, passe de revisão final. **Ação urgente: cap. 4 completo ao Icaro AGORA** (cabe ~1 rodada de feedback do núcleo antes de 11/ago).

## Roteiros já dados (registrar em `plan/cap_5_resultados.md` se quiser andaime versionado — AINDA NÃO feito)
§5.2 inteiro (arco de 5 blocos = 5 subseções) + §5.2.1 + §5.2.2, no formato da skill `roteiro-academico` (imagem + missão + perguntas + blocos + defesa + fronteiras + apoios). **Workflow desta sessão:** roteiro por subseção → Matheus escreve → "verifique" (papel banca, sem mercê) → aponta furos → aplica → "verifique novamente". Repetir para §5.2.3.

## Pendências gerais (não bloqueiam)
- Citações: `rust-error-index`, `rust-safe-soundness` (linha RustBelt; serve à 4.3.2 e à 4.7.3) — ver [[citacoes-pendentes]].
- `../aule`: confirmar `Mirror::Primitive32`/`Channel` e fatos do §4.5 (`last_output` por valor?, `Block` com tipos associados?, `EndlessSimulation` existe?) antes da defesa.
- `refs/` a decidir versionar × gitignore; `referencias.bib` herdadas a limpar.
