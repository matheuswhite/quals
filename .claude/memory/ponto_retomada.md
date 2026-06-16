---
name: ponto-retomada
description: "Cap. 4: 4.2.3 REDIGIDA e em revisao de banca (B1-B4 fechados; faltam A3 refs/lista, B1-residuo linha 106, E ortografia; B5 e da 4.2.2). ESP32 + Opcao A (sem variantes) registrados. Conta 36->25->18->11->4."
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-14
  - Claude (claude-opus-4-8), 2026-06-15
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 15/jun/2026.**

## Estado do Cap. 4 (15/jun)
- **4.1, 4.2.1, 4.2.2 — REDIGIDAS e revisadas (banca).**
- **4.2.3 (A Taxonomia) — REDIGIDA (draft no `.tex`) e em REVISÃO DE BANCA.** Entrega a tabela dos 4 padrões (P1–P4) pela redução **36→25→18→11→4** (conta verificada célula a célula e fechada). Poda em 3 motivos (inexpressibilidade / fora de escopo Núcleo-Núcleo / não-factível no domínio) + colapso por garantia.
- **Migração de plataforma → ESP32 Xtensa dual-core (15/jun):** single-core como **restrição declarada** (não "fato de HW"); custo re-centrado no **P3** (ISA-independente); P4/ARMv6-M vira ilustração. Em `plan/cap_4_metodologia.md` (Decisão 2026-06-15).
- **Opção A (sem variantes nomeadas) — DECIDIDA (15/jun):** não nomear P5/P6; "variar só o par = variante" como **regra geral**. Registrada no plano (8 edições) + tabela de verificação 11→4.

## Revisão de banca da 4.2.3
- **FECHADOS:** A1 (tabela 3≠5 colunas), A2 (`\text`), **B1** (garantia = **propriedade exigida**, não mecanismo; mecanismos vão p/ 4.4 — P3 deixou de citar "mutex"), **B2** (reconciliação Buffer×RMW: exprimibilidade ≠ ocorrência, não-redundância do eixo Estrutura), **B3** (critério de equivalência único = garantia; saíram "categoria de data race" e "modelos de concorrência"), **B4** (removido o cross-ref "experimento de ortogonalidade"), C1–C3, D1–D3.
- **FALTAM na 4.2.3:**
  - **A3** — `list:eleven-cells` não é `\begin{enumerate}` (vira parágrafo corrido, `\ref`=`??`); `sec:border`/`sec:cost` (seções 4.3/4.4) sem `\label`; `sec:prod-cons`/`sec:scope` conferir (provável 3.3 adiada → `??` intencional).
  - **B1-resíduo** — linha 106 ainda diz "garantia atomic load/store de P1" (inconsistente com "acesso indivisível e ordenado").
  - **E** — passada ortográfica (inexpremíveis, posisão, Esturua, atacado de acentos) + typos novos (do do, algorítmos, Produtor-Consomidor, intrisicamente, compatilhamento); ponto final na linha 88. Fazer de uma vez, no fim.
- **B5 (item da 4.2.2, NÃO da 4.2.3):** a prova de ortogonalidade da 4.2.2 usa critério forte demais ("variar acesso → muda garantia", válido só no escalar) que conflita com o colapso (Struct-LW + Struct-RMW → P3). Trazer a decoplagem do plano (ortogonalidade descritiva × organização por garantia) para o `.tex` da 4.2.2.

## Próxima etapa
- Fechar **A3** (enumerate + labels `sec:border`/`sec:cost`) → **B1-resíduo** (linha 106) → **E** (ortografia). Depois **B5** na 4.2.2.

## Pendências (não bloqueiam)
- Confirmar atômicos do Xtensa (`S32C1I`) — afeta 4.4 (custo do P4), não a 4.2.3.
- `refs/` (PDF Helmbold & McDowell) ainda não versionado — decidir versionar × gitignore.
- `referencias.bib`: ~46 herdadas a limpar; validar 12; autores de `sharma2024rust`.
- §4.2 cumpre o F7 — ver [[review-checklist-enforce]].

## Prazo
- Parede dura **31/ago/2026**. Ritmo ≈ 1 seção/semana; 4.2 fechando.
