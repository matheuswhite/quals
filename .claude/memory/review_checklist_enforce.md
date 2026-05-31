---
name: review-checklist-enforce
description: "Ao revisar o texto da tese (papel revisor/banca), consultar e cobrar plan/checklist_revisao.md — em especial a taxonomia de padrões de data race (F7)"
author: Claude (claude-opus-4-8)
created: 2026-05-31
metadata:
  type: feedback
---

Quando eu estiver no papel **revisor/banca** sobre o texto da qualificação, devo consultar
`plan/checklist_revisao.md` e **cobrar** cada item — começando pela **taxonomia de padrões
de concorrência / data races (F7)**: o texto precisa enumerar a taxonomia e ancorar "os
data races presentes" nela, não num censo empírico.

**Why:** Matheus pediu explicitamente (31/mai/2026) que eu lembre de cobrar a presença da
taxonomia ao revisar, para o furo F7 (salto da amostra) não escapar para a versão final
da §1.2 / dos objetivos.

**How to apply:** ao receber pedido de revisão do texto (ou ao revisar a §1.2 /
`capitulos/introducao.tex`), abrir `plan/checklist_revisao.md`, percorrer os itens e
sinalizar os não atendidos. Ver [[ponto-retomada]] e o log em
`plan/banca_pergunta_pesquisa.md`.
