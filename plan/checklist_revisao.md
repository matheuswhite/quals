---
author: Claude (claude-opus-4-8)
created: 2026-05-31
---

<!-- LTeX: enabled=false -->

# Checklist de revisão — requisitos de conteúdo a verificar no texto

Lista **forward-looking** do que precisa estar presente/correto no texto da qualificação.
Origem: exercício de banca antecipada (ver [`banca_pergunta_pesquisa.md`](banca_pergunta_pesquisa.md)).
Acumula a cada rodada de revisão. **Não é redação** — são itens a *verificar* (Regra 4).
Matheus consulta ao redigir; Claude (papel revisor/banca) consulta e **cobra** ao revisar.

## Pergunta de pesquisa / objetivos (§1.2 — `capitulos/introducao.tex`)

- [ ] **F7 — Taxonomia de padrões de concorrência (data races).** O texto precisa
  **definir/enumerar uma taxonomia de padrões** de estado compartilhado entre contextos
  (p.ex.: produtor/consumidor `ISR↔tarefa`; reader/writer de parâmetros/ganhos
  compartilhados) e **ancorar "os data races presentes" nessa taxonomia** — não num censo
  empírico exaustivo nem em "mais comuns/frequentes".
  - **Por quê:** sem isso a banca cobra *"como você sabe que cobriu todos os data
    races?"* (salto da amostra / pendência P2). A generalização se sustenta na garantia
    (`Send`/`Sync` cobre qualquer padrão) + demonstração **por construção** com padrões
    representativos — **não** na contagem.
  - **Ao revisar, verificar:** (1) a taxonomia está escrita e nomeada? (2) "presentes"
    está ligado a ela (não a "frequentes")? (3) está dito explicitamente que a cobertura
    é por construção + garantia da linguagem, não por exaustividade?

<!-- Itens futuros de revisão entram abaixo, um por bloco. -->
