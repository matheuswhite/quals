---
author: Claude (claude-opus-4-8)
created: 2026-07-20
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
| — | — | *(nenhuma busca executada ainda)* | — | — | — |

## Lista provisória (aguardando leitura + aval do Matheus)

| # | Relevância | Serve a (cap./obj.) | Referência (autor · título · venue · ano · tipo) | Gancho (1 linha) | Keyword | Aval |
|---|---|---|---|---|---|---|
| — | — | — | *(vazia — aguardando primeira rodada de busca)* | — | — | pendente |

## Lista definitiva (avalizada → `.bib`)

| Referência | bibkey | No `.bib`? |
|---|---|---|
| *(vazia)* | — | — |

## Lista descartada

| Referência | Motivo (curto) |
|---|---|
| *(vazia)* | — |
