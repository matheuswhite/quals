---
author: Claude (claude-opus-4-8)
created: 2026-07-20
co-authors:
  - Claude (claude-opus-4-8), 2026-08-01
---

<!-- LTeX: enabled=false -->

# Triagem de referências — esteira de busca (Regra 7, a partir de 20/jul)

Esteira viva da busca bibliográfica sob a **Regra 7 reformulada** (ver `CLAUDE.md`). Não é prosa da tese; é registro de processo + trilha de auditoria para a banca.

## Fluxo

1. **Matheus dá as keywords** (opcional: bases/venues, recorte temporal, capítulo-alvo). A estratégia de busca é dele.
2. **Claude executa a busca** (ferramenta: WebSearch/WebFetch — web genérica, **não** base indexada; coleta de candidatos, não revisão sistemática) e joga os achados na **lista provisória**, classificados por relevância.
3. **Matheus lê** cada candidato provisório.
4. **Matheus dá o aval por item** → move para a **lista definitiva** ou a **descartada** (com motivo curto).
5. **Só depois de definitiva**, Claude adiciona/formata a entrada em `referencias.bib` (marcada `% added-by: Claude, AAAA-MM-DD`, metadados confirmados em fonte primária).

**Guardrails:** Claude não escreve no `.bib` sem aval "definitiva"; não decide relevância nem escolhe o que entra (a classificação só acelera a leitura). Para cap. 2 e obj. 1, documentar com rigor e estar pronto para reproduzir as queries numa base acadêmica.

**Legenda de relevância:** `Alta` = candidato forte, encaixa direto no argumento · `Média` = pertinente, mas periférico ou a confirmar · `Baixa` = tangencial, provável descarte.

## Log de buscas (auditoria)

| Rodada | Data | Keywords (dadas pelo Matheus) | Ferramenta | Nº resultados | Observações |
|---|---|---|---|---|---|
| 1 | 2026-08-01 | (derivadas do texto da 3.3.1): tratamento de interrupção/ISR; DMA / transferência sem a CPU; contexto de execução em sistema embarcado. Cap.-alvo: 3.3.1 | WebSearch | 3 candidatos | Buraco = alicerce para ISR e DMA (a antiga 3.2 Arquitetura foi cortada). Preempção / escalonamento preemptivo×cooperativo / ISR-não-bloqueia já cobertos por `book:deadline-requirement` (Buttazzo) + `eriksson2013rtfm` (SRP/RTIC) no `.bib`. WebSearch = web genérica, não base indexada → metadados a confirmar em fonte primária antes de virar definitiva. |
| 2 | 2026-08-01 | (dada pelo Matheus): norma C11 / UB em data race (§5.1.2.4) | WebSearch + WebFetch | 1 documento | Documento único e conhecido (não é garimpo). Redação e nº do parágrafo confirmados na fonte primária (WG14, N1570, versão HTML port70.net): §5.1.2.4 par. 25. Duas formas citáveis: N1570 (draft público, gratuito) × ISO/IEC 9899:2011 (oficial, pago). |

## Lista provisória (aguardando leitura + aval do Matheus)

| # | Relevância | Serve a (cap./obj.) | Referência (autor · título · venue · ano · tipo) | Gancho (1 linha) | Keyword | Aval |
|---|---|---|---|---|---|---|
| 1 | Alta | 3.3.1 (contexto de execução / ISR / concorrência) | Lee, E. A. & Seshia, S. A. · *Introduction to Embedded Systems: A Cyber-Physical Systems Approach* · MIT Press · 2ª ed., 2017 · livro (ISBN 978-0-262-53381-2; versão livre em ptolemy.berkeley.edu, CC BY-NC-ND) | Alicerce acadêmico de interrupção/ISR e de concorrência em embarcado — cobre o tema da subseção inteira | ISR / contexto de execução | **definitiva (2026-08-01)** → `book:lee-seshia` |
| 2 | Alta | 3.3.1 (DMA + I/O dirigido por interrupção) | Stallings, W. · *Computer Organization and Architecture* · Pearson · 10ª ed. 2016 (ISBN 978-0-13-410161-3) ou 11ª ed. 2019 · livro | Âncora clássica de DMA e I/O por interrupção no nível de arquitetura (ISA-neutro — casa com o enquadramento "custo ISA-independente") | DMA / transferência sem CPU | **definitiva (2026-08-01)** → `book:stallings` |
| 3 | Baixa | 3.3.1 (ISR/NVIC concreto) | Yiu, J. · *The Definitive Guide to ARM Cortex-M3 and Cortex-M4 Processors* · Newnes/Elsevier · 3ª ed., 2013 (ISBN 978-0-12-408082-9) · livro | ISR/NVIC no hardware concreto — **ressalva:** é ARM Cortex-M e o alvo migrou p/ ESP32 Xtensa (Decisão 2026-06-15) → citaria mecânica de outra ISA. Só se quiser exemplo concreto e assumir a ressalva | ISR concreto / NVIC | pendente |
| 4 | Alta | 3.3.2 (definição de data race + UB) | ISO/IEC JTC1/SC22/WG14 · *Programming Languages --- C* · WG14 · 2011 · norma (C11); §5.1.2.4 par. 25. Formas: **N1570** (draft público) ou **ISO/IEC 9899:2011** (oficial) | Fonte normativa que define data race (as 4 cláusulas) **e** declara o UB — ancora as linhas 31 e 40 da 3.3.2 | norma C11 / UB data race | **definitiva (2026-08-01, Opção A)** → `doc:c11` |

## Lista definitiva (avalizada → `.bib`)

| Referência | bibkey | No `.bib`? |
|---|---|---|
| Lee & Seshia, *Introduction to Embedded Systems*, 2ª ed., MIT Press, 2017 | `book:lee-seshia` | Sim (2026-08-01) |
| Stallings, *Computer Organization and Architecture*, 11ª ed., Pearson | `book:stallings` | Sim (2026-08-01) |
| ISO/IEC C11, draft N1570, §5.1.2.4 par. 25 (Opção A) | `doc:c11` | Sim (2026-08-01) |

## Lista descartada

| Referência | Motivo (curto) |
|---|---|
| *(vazia)* | — |
