---
name: ponto-retomada
description: "Cap. 4: 4.1 e 4.2.1 REDIGIDAS e revisadas (banca, 8 pontos fechados em 14/jun); 3.3 adiada; proximo = redigir 4.2.2 (Os Tres Eixos) — pergunta de completude dos eixos ja guardada no plano"
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-14
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 14/jun/2026.**

## Estado atual do Cap. 4 (14/jun)
- **4.1 Caracterização — REDIGIDA e aprovada no conteúdo** (revisão de banca, 5/jun). Acabamento pendente: ortografia/concordância; `\cite`→`\citet` quando o autor é sujeito; confirmar as 3 definições no Wazlawick §2.6.
- **4.2.1 Método de Levantamento — REDIGIDA e REVISADA (14/jun).** A revisão de banca fechou 8 pontos: (1) DR × race condition agora são "conceitos distintos, frequentemente confundidos" (não subconjunto; o quadrante "DR sem race condition" refuta o subconjunto); (2) "não é revisão sistemática" justificado por inventário descritivo × **modelo generativo** ("o que pode ocorrer" × "o que foi reportado"); (3) "células candidatas" (não "cada célula = padrão distinto" — coerente com a poda); (4) critério de **inclusão + exclusão** (OOB/UAF/uninit fora do escopo); (5) hedge "exaustivo da combinação de dimensões, não da realidade"; (6) abertura "recapitular/adotar a definição da fundamentação" (não "definir" — fecha o vazamento fundamentação→metodologia); (7) happens-before como **relação entre** acessos; (8) 3ª "fonte" virou **"verificação de casos"** (desarma a auto-autoridade). **Acabamento mecânico pendente:** concorrente→concorrentes, adotado→adotada (refere "a definição"), bugs relacionado→relacionados, algorítmos→algoritmos, encadeamento de vírgulas.
- **4.2 Taxonomia — nomenclatura/poda FECHADAS** (`plan/cap_4_metodologia.md` §4.2): P1 Tipo primitivo compartilhado · P2 Produtor-consumidor · P3 Tipo composto compartilhado · P4 Read-modify-write compartilhado. P5→variante P1; P6→funde P2; P7 (core↔core)→limitação (Cortex-M0 single-core). Eixo organizador = garantia exigida no safe; direção eixos→garantia.
- **3.3 (Concorrência/Modelo de Memória) — ADIADA por decisão do Matheus (14/jun):** fechar a 4.2 primeiro, voltar à 3.3 depois. A 3.3 é dona da definição de DR, happens-before e DR×race condition (refs Helmbold & McDowell 1996, Netzer & Miller 1992, C11 §5.1.2.4); a 4.2.1 só remete via `\ref{sec:dr-def}`, `\ref{sec:dr-vs-race}`, `\ref{cap:fundamentacao}` (mostram `??` até a 3.3 existir). +32 linhas pendentes (não commitadas) em `fundamentacao.tex` = início da 3.3.

## Próxima etapa — 4.2.2 (Os Três Eixos)
- Orientar/redigir: por que estes 3 eixos (par de contexto · estrutura do dado · padrão de acesso) e não outros; necessidade + ortogonalidade; como geram a matriz. Roteiro em blocos em `plan/cap_4_metodologia.md` §4.2.2.
- **Pergunta de banca já guardada no plano (§4.2.2, após o bloco 6):** "como garantir que os 3 eixos geram o espaço COMPLETO, não só o que vocês imaginaram?" (suficiência) → defesa: cada eixo deriva de uma cláusula da def. de DR; representativo não exaustivo; filtro+casos como rede.
- Depois 4.2.3 (tabela dos 4 padrões). Claude não toca no `.tex` (Regras 1 e 3).

## Pendências (não bloqueiam)
- Acabamento mecânico da 4.1 e 4.2.1.
- Redigir a 3.3 e fechar os labels que a 4.2.1 referencia.
- `refs/` tem o PDF do **Helmbold & McDowell (1996)** que o Matheus trouxe — formatar `.bib` quando ele pedir (bibliotecário, Regra 7); decidir se versiona PDFs ou gitignora `refs/`.
- Confirmar/citar **ARMv6-M** (Cortex-M0 sem LDREX/STREX → seção crítica): sustenta o custo do P4.
- `referencias.bib`: ~46 entradas herdadas a limpar; validar 12 refs novas; completar autores de `sharma2024rust`.
- 4.3–4.7 conforme roadmap. §4.2 cumpre o F7 — ver [[review-checklist-enforce]].

## Contexto de prazo
- Parede dura: **31/ago/2026**. Semana 09–14 jun = fechar 4.2. Ritmo ≈ 1 seção/semana. Ver `plan/roadmap_escrita.md`.
