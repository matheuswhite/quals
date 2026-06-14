---
name: ponto-retomada
description: "Cap. 4: 4.1, 4.2.1 e 4.2.2 REDIGIDAS e revisadas (banca); 3.3 adiada; proximo = redigir 4.2.3 (A Taxonomia, tabela dos 4 padroes). Cap.4 ~2150 palavras."
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

## Estado do Cap. 4 (14/jun)
- **4.1 Caracterização — REDIGIDA e aprovada** (banca 5/jun). ~540 palavras.
- **4.2.1 Método de Levantamento — REDIGIDA e REVISADA** (8 pontos de banca fechados): DR × race condition como conceitos **distintos** (não subconjunto); "não é revisão sistemática" via **modelo generativo × inventário descritivo** ("o que pode ocorrer × o que foi reportado"); "células candidatas"; critério **inclusão + exclusão** (OOB/UAF/uninit fora); hedge "exaustivo da combinação, não da realidade"; **recapitular/adotar** a definição da fundamentação (não "definir"); happens-before como **relação**; 3ª fonte virou **verificação de casos**. ~597 palavras.
- **4.2.2 Os Três Eixos — REDIGIDA e REVISADA** (4 blocos): (1) **enunciar + necessidade** (cada eixo derivado de uma cláusula da def. de DR; eixo 1 = **par**, defendido "par não trio" pela def. C11 de 2 ações; perna descritiva = **modelo de concorrência**); (2) **ortogonalidade** (fixa-2-varia-1; testemunha = garantia **OU** modelo de concorrência; eixo 1 justificado pela exclusividade do modelo de concorrência); (3) **trava de direção** (eixos→garantia) + **delimitação negativa** (sincronização/bug-type/prioridade rejeitados) + **completude**; (4) **geração da matriz** (produto cartesiano 4×3×3 = 36 candidatos → 4.2.3 povoa+poda). ~1017 palavras. **⚠️ Pendente:** a tabela `tab:eixos-dr` está **sem `\\`** nas 4 linhas de dados (quebra a compilação) — adicionar; legenda "possível"→"possíveis".
- **Roteiro da 4.2.2 no plano:** fusões **1+2 e 3+4** → **4 blocos** (não 6). Pergunta de banca "completude dos eixos" guardada no bloco 3 do roteiro.
- **4.2 Taxonomia — nomenclatura/poda FECHADAS** (plano §4.2): P1 primitivo · P2 produtor-consumidor · P3 composto · P4 RMW; P5→var P1; P6→funde P2; P7 (core↔core)→limitação. Eixo organizador = garantia exigida no safe; direção eixos→garantia.
- **3.3 (Concorrência/Modelo de Memória) — ADIADA** (decisão 14/jun): a 4.2.1/4.2.2 remetem via `\ref{sec:dr-def}`, `\ref{sec:dr-vs-race}`, `\ref{cap:fundamentacao}` (mostram `??` até a 3.3 existir). Refs da 3.3: **Helmbold & McDowell 1996** (PDF em `refs/`), **Netzer & Miller 1992**, **C11 §5.1.2.4**.

## Próxima etapa — 4.2.3 (A Taxonomia)
- Entregável do obj 1: tabela consolidada dos **4 padrões** (linha ~61 do `.tex` ainda é placeholder "tabela P1-P7"). Roteiro em blocos no plano §4.2.3. Recebe o bastão da matriz (4.2.2 bloco 4): **povoar + podar** (inclusão 4.2.1 + equivalência por garantia) + distinções finas (P1×P3, P1×P4) + forward-pointer a 4.3/4.4. Claude não toca no `.tex` (Regras 1 e 3).

## Pendências (não bloqueiam)
- **Passada ortográfica da 4.2 inteira** (acentos acumulados: *concorrencia, consequencia, descriçao, independencia, inexprimíveis*, etc.) — fazer de uma vez, concentrado.
- Corrigir os **`\\` da tabela** `tab:eixos-dr` (compila) + legenda "possíveis".
- Confirmar/citar **ARMv6-M** (Cortex-M0 sem LDREX/STREX → seção crítica) — custo do P4.
- `refs/` tem o PDF do **Helmbold & McDowell** — formatar `.bib` quando ele pedir (bibliotecário, Regra 7); decidir se versiona PDFs ou gitignora `refs/`.
- `referencias.bib`: ~46 herdadas a limpar; validar 12 novas; autores de `sharma2024rust`.
- §4.2 cumpre o F7 — ver [[review-checklist-enforce]].

## Contexto de prazo
- Parede dura **31/ago/2026**. Semana 09–14 jun = fechar 4.2 — **faltou só a 4.2.3**. Ritmo ≈ 1 seção/semana. Ver `plan/roadmap_escrita.md`.
- Contagem 14/jun: cap. 4 ~**2150 palavras** (4.1≈540, 4.2.1≈597, 4.2.2≈1017); rascunho intro 1.2 ≈388.
