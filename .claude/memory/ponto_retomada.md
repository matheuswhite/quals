---
name: ponto-retomada
description: "Cap. 4: §4.3 COMPLETA (abertura+4.3.1+4.3.2+4.3.3, fechada 21/jun, commits c279f25/f817e6b). Proxima = REDACAO da 4.4 (roteiro pronto no plano, e2f0870). Pendencias da 4.3.3: tabela da sonda (TODO) e src/p2_snippet.rs untracked. Plano da §4.3 atras do .tex."
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-14
  - Claude (claude-opus-4-8), 2026-06-15
  - Claude (claude-opus-4-8), 2026-06-18
  - Claude (claude-opus-4-8), 2026-06-21
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 21/jun/2026.**

## Estado do Cap. 4
- **4.1 e 4.2 (4.2.1/4.2.2/4.2.3) — REDIGIDAS e revisadas.** (4.2.3 com resíduos antigos não tocados: A3, B1-resíduo, E, B5 — ver abaixo.)
- **§4.3 (Caracterização da Fronteira safe/unsafe) — COMPLETA:** abertura + 4.3.1 (Procedimento) + 4.3.2 (Critério) + **4.3.3 (Padrões que Cruzam a Fronteira), redigida e revisada (banca), conceitualmente FECHADA (21/jun).** Commits: `c279f25` (4.3.3), `f817e6b` (`\coderust` + linguagem Rust na `ic.cls`).
- **§4.4 — roteiro CONSOLIDADO e registrado** em `plan/cap_4_metodologia.md` (commit `e2f0870`). No `.tex` ainda é ESQUELETO (4.4.1 "Eixos de Design" + 4.4.2 "Trade-offs", placeholders).

## 4.3.3 — fechada, mas com pendências de entregável/acabamento
- **TABELA da sonda (entregável do obj 2) ainda `% TODO`** — falta rodar `cargo check` nos 4 padrões e registrar os vereditos. O parágrafo de resultado (P1/P3/P4 inteiramente safe; P2 fronteira interna no caso ISR↔Tarefa) está AFIRMADO sem a tabela; preencher.
- **`src/p2_snippet.rs`** criado mas **untracked** — precisa conter o snippet MÍNIMO (não o caso completo do cap. 5) e ser versionado, senão `\coderust{...}{src/p2_snippet.rs}` quebra o build em quem clonar.
- **Refs próprias da 4.3.3 OK** (`subsec:border-procedure` / `subsec:taxonomy` / `subsec:unsafe-criteria` têm `\label`; `code:p2-snippet` vem do `\coderust`). **Mas a abertura da §4.3 e a 4.3.2 ainda referenciam labels do cap. 3** (`subsec:types_guarantee`, `sec:unsafe`, `sec:send_sync`) → `??` até o cap. 3 existir.
- `seção 4.4` hardcoded na 4.3.3 em vez de `\ref` — falta `\label{sec:cost}` na 4.4.
- ordem dos desfechos na 4.3.3 (safe/unsafe/interna) ≠ 4.3.1 (safe/interna/unsafe); o par. 1 generaliza "borda interna" (só vale p/ P2).
- ortografia acumulada da §4.3 (passada final).

## Próxima etapa — REDAÇÃO da 4.4 (roteiro PRONTO)
- Roteiro consolidado em `plan/cap_4_metodologia.md` (§4.4, 21/jun). **4.4.1 Dimensões de Design** (renomear de "Eixos de Design" no `.tex`): catálogo de alternativas safe (atomics / Mutex-critical-section / SPSC / RTIC / Arc / cópia owned) + mapeamento padrão→alternativa. **4.4.2 Trade-offs em `no_std`**: onde o "custo" do título é argumentado (gancho P3 ISA-independente; custo = preço da garantia forçada) + a matriz (entregável obj 3).
- **⚠️ fronteira fina 4.4.2 × 4.7:** custo intra-Rust aqui; comparação Rust×C+MISRA lá; C só como contraste conceitual (é a linha que a 4.3.3 quase cruzou).
- Depois: 4.5 (Aule veículo), 4.6 (protocolo experimento), 4.7 (verif. por tipos vs C+MISRA) — pós-qual, mais leves.

## Roadmap (replanejado 21/jun, commit `bc8ef8b`)
- W3 (22–28/jun) = 4.3.3 ✓; **W4 = 4.4**; cap. 4 completo ~19/jul; cap. 5 ~02/ago; revisão W11–W12; **parede 31/ago**. ~1 seção/semana; W10 sobrecarregada (gatilho dos cortes).

## Registro Regra 6 / pendências da §4.3
- **`plan/cap_4_metodologia.md` está ATRÁS do `.tex` na §4.3** — nota de pendência já anotada lá (21/jun): incorporar abertura/4.3.1/4.3.2/4.3.3 refinados (3 desfechos, critério contrafactual, escopo "taxonomia", soundness). O `.tex` é a fonte atual.
- **Citações faltam no `.bib`** — ver [[citacoes-pendentes]] (`rust-error-index`, `rust-safe-soundness`).

## Resíduos antigos da 4.2.3 (não tocados)
- A3 (`list:eleven-cells` → `enumerate`; labels), B1-resíduo (~linha 106), E (ortografia), B5 (na 4.2.2: critério de ortogonalidade forte demais). §4.2 cumpre o F7 — ver [[review-checklist-enforce]].

## Pendências antigas (não bloqueiam)
- Confirmar atômicos do Xtensa (`S32C1I`) — afeta o peso do P4 em 4.4.2.
- `refs/` e `src/` untracked — `src/p2_snippet.rs` PRECISA entrar (ver acima); `refs/` (PDF Helmbold & McDowell) ainda a decidir versionar × gitignore.
- `referencias.bib`: ~46 herdadas a limpar; validar 12; autores de `sharma2024rust`.

## Prazo
- Parede dura **31/ago/2026**. Ritmo ≈ 1 seção/semana.
