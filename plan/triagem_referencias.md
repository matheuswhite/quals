---
author: Claude (claude-opus-4-8)
created: 2026-07-20
co-authors:
  - Claude (claude-opus-4-8), 2026-08-01
  - Claude (claude-opus-4-8), 2026-08-02
  - Claude (claude-opus-5), 2026-08-10
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
| 3 | 2026-08-02 | (SEM keywords/busca ainda) — Matheus pediu candidatos para formar o prompt; propostos por Claude a partir do próprio conhecimento: (A) definição de race condition + distinção DR×RC (3.3.3 l.50/l.52); (B) origem do termo TOCTOU / check-then-act (l.52) | nenhuma (conhecimento prévio) | 7 candidatos | **Inversão do fluxo normal:** o passo 1 (keywords) foi substituído por "Claude sugere opções, Matheus escolhe". Guardrail preservado: Matheus dá o aval, `.bib` só depois. **Metadados NÃO confirmados em fonte primária ainda** — confirmar na escolha (o `#6 Helmbold&McDowell` pode nem existir com o ano indicado). |
| 4 | 2026-08-10 | (pedido do Matheus): **substituir `book:deadline-requirement` (Buttazzo) por um artigo** — ele não conseguiu acesso ao livro. Alvo duplo, porque a chave ancora duas frases diferentes: **(A)** §1.1 l.13 — perder deadline em controle ≠ travar GUI; risco de desestabilizar a planta (deadline como requisito, hard/soft/firm); **(B)** §3.1.1 l.21 — escalonador **preemptivo × cooperativo** | WebSearch + Semantic Scholar API (openAccessPdf) + testes de URL | 4 candidatos | **Critério extra imposto pelo caso:** o substituto tem de ser **acessível a ele** — o problema original foi acesso. Por isso o filtro incluiu OA. Achado relevante: **(B) não precisa de referência nova** — `book:lee-seshia`, já definitiva e já em mãos, cobre preempção/escalonamento no capítulo de Multitasking/Scheduling; a saída mais barata é repontar a `\citep` da l.21. Metadados dos candidatos confirmados em fonte primária apenas para o #12 (LIPIcs/Dagstuhl); os demais via DBLP/ACM/IEEE, **a confirmar** se avalizados. |

## Lista provisória (aguardando leitura + aval do Matheus)

| # | Relevância | Serve a (cap./obj.) | Referência (autor · título · venue · ano · tipo) | Gancho (1 linha) | Keyword | Aval |
|---|---|---|---|---|---|---|
| 1 | Alta | 3.3.1 (contexto de execução / ISR / concorrência) | Lee, E. A. & Seshia, S. A. · *Introduction to Embedded Systems: A Cyber-Physical Systems Approach* · MIT Press · 2ª ed., 2017 · livro (ISBN 978-0-262-53381-2; versão livre em ptolemy.berkeley.edu, CC BY-NC-ND) | Alicerce acadêmico de interrupção/ISR e de concorrência em embarcado — cobre o tema da subseção inteira | ISR / contexto de execução | **definitiva (2026-08-01)** → `book:lee-seshia` |
| 2 | Alta | 3.3.1 (DMA + I/O dirigido por interrupção) | Stallings, W. · *Computer Organization and Architecture* · Pearson · 10ª ed. 2016 (ISBN 978-0-13-410161-3) ou 11ª ed. 2019 · livro | Âncora clássica de DMA e I/O por interrupção no nível de arquitetura (ISA-neutro — casa com o enquadramento "custo ISA-independente") | DMA / transferência sem CPU | **definitiva (2026-08-01)** → `book:stallings` |
| 3 | Baixa | 3.3.1 (ISR/NVIC concreto) | Yiu, J. · *The Definitive Guide to ARM Cortex-M3 and Cortex-M4 Processors* · Newnes/Elsevier · 3ª ed., 2013 (ISBN 978-0-12-408082-9) · livro | ISR/NVIC no hardware concreto — **ressalva:** é ARM Cortex-M e o alvo migrou p/ ESP32 Xtensa (Decisão 2026-06-15) → citaria mecânica de outra ISA. Só se quiser exemplo concreto e assumir a ressalva | ISR concreto / NVIC | pendente |
| 4 | Alta | 3.3.2 (definição de data race + UB) | ISO/IEC JTC1/SC22/WG14 · *Programming Languages --- C* · WG14 · 2011 · norma (C11); §5.1.2.4 par. 25. Formas: **N1570** (draft público) ou **ISO/IEC 9899:2011** (oficial) | Fonte normativa que define data race (as 4 cláusulas) **e** declara o UB — ancora as linhas 31 e 40 da 3.3.2 | norma C11 / UB data race | **definitiva (2026-08-01, Opção A)** → `doc:c11` |
| 5 | Alta | 3.3.3 l.50 (def. race condition) + l.52 (assimetria DR×RC) | Netzer, R. H. B. & Miller, B. P. · *What are race conditions? Some issues and formalizations* · ACM LOPLAS 1(1):74–88 · 1992 · artigo (DOI 10.1145/130616.130623) | Paper canônico que formaliza *general race* (=race condition) × *data race*; ancora a definição (l.50) **e** a assimetria (l.52) de uma vez só | def. race condition / distinção DR-RC | **definitiva (2026-08-02, A1)** → `article:netzer-miller-races` |
| 6 | Média | 3.3.3 l.52 (reforço da distinção/taxonomia) | Helmbold, D. P. & McDowell, C. E. · título/ano **A CONFIRMAR** (indicado como "1996" no ponto de retomada) · detecção/modelagem de race conditions | Reforço a Netzer&Miller; **RESSALVA: metadado não confirmado — pode não existir com esse ano/autoria** | taxonomia race condition | pendente (metadado a confirmar) |
| 7 | Média | 3.3.3 l.50 (def. didática, alternativa a paper) | Ben-Ari, M. · *Principles of Concurrent and Distributed Programming* · Addison-Wesley · 2ª ed. 2006 · livro | Definição de race condition em livro-texto consagrado; alternativa se preferir livro a paper | race condition livro-texto | pendente |
| 8 | Baixa | 3.3.3 l.50 (não-determinismo) | Emrath, P. A. & Padua, D. A. · *Automatic detection of nondeterminacy in parallel programs* · PADD'88 · 1988 · artigo | Foca no não-determinismo (cerne da sua def.), mas anterior à terminologia DR/RC consolidada | não-determinismo programa paralelo | pendente |
| 9 | Alta | 3.3.3 l.52 (origem do termo TOCTOU) | Bishop, M. & Dilger, M. · *Checking for Race Conditions in File Accesses* · Computing Systems 9(2):131–152 · 1996 · artigo | Fonte canônica do termo TOCTOU; **RESSALVA: contexto = segurança de acesso a arquivos Unix, não controle** | TOCTOU origem | **definitiva (2026-08-02, B1)** → `article:bishop-dilger-toctou` |
| 10 | Média | 3.3.3 l.52 (nomenclatura TOCTOU, catálogo) | MITRE · *CWE-367: Time-of-check Time-of-use (TOCTOU) Race Condition* · cwe.mitre.org · techreport/URL | Catálogo padrão da indústria; define TOCTOU; citável como URL; **não peer-reviewed** | TOCTOU catálogo | pendente |
| 11 | Média | 3.3.3 l.52 (termo check-then-act) | Goetz, B. et al. · *Java Concurrency in Practice* · Addison-Wesley · 2006 · livro | Usa "check-then-act" como padrão de race condition (o outro nome no seu texto); **RESSALVA: Java, livro** | check-then-act | pendente |
| 12 | Alta | §1.1 l.13 (A: consequência de perder deadline em controle) | Maggio, M.; Hamann, A.; Mayer-John, E.; Ziegenbein, D. · *Control-System Stability Under Consecutive Deadline Misses Constraints* · ECRTS 2020, LIPIcs v. 165, pp. 21:1–21:24 · 2020 · artigo (DOI 10.4230/LIPIcs.ECRTS.2020.21) | **Acesso garantido** (LIPIcs, CC-BY, PDF baixado como `leituras/_CANDIDATO-substituto-buttazzo-maggio-2020-ecrts.pdf`). Trata exatamente do que a §1.1 afirma: o efeito de **deadline perdido sobre a estabilidade** do sistema de controle. **RESSALVA:** é sobre *tolerância* a misses (modelos weakly-hard) — sustenta "perder deadline ameaça a estabilidade", **não** a taxonomia hard/soft/firm; se a taxonomia importar no texto, precisa de par | substituto Buttazzo (A) | **descartado (2026-08-10)** — ver lista descartada |
| 13 | Alta | §1.1 l.13 (A: deadline como requisito, não velocidade) | Stankovic, J. A. · *Misconceptions About Real-Time Computing: A Serious Problem for Next-Generation Systems* · IEEE Computer 21(10):10–19 · 1988 · artigo (DOI 10.1109/2.7053) | O artigo canônico do argumento "tempo real **não** é 'rápido'; deadline é requisito de correção" — é a formulação mais próxima da sua frase. **RESSALVA: fechado (IEEE)** → CAPES/UFAL; se o acesso falhar de novo, não resolve o problema que motivou a troca | substituto Buttazzo (A) | **descartado (2026-08-10)** — ver lista descartada |
| 14 | Média | §1.1 l.13 (A) + §3.1.1 l.21 (B, parcial) | Liu, C. L. & Layland, J. W. · *Scheduling Algorithms for Multiprogramming in a Hard-Real-Time Environment* · JACM 20(1):46–61 · 1973 · artigo (DOI 10.1145/321738.321743) | Alicerce de *hard real-time* + escalonamento **preemptivo** por prioridade. **Acesso:** ACM bronze OA (abre no navegador, como o Netzer & Miller). **RESSALVAS:** não discute escalonamento **cooperativo** (metade de B fica descoberta) e não faz a taxonomia hard/soft/firm | substituto Buttazzo (A/B) | **definitiva (2026-08-10, opcao 2)** → `article:liu-layland-hard-real-time` |
| 15 | Média | §3.1.1 l.21 (B: preemptivo × cooperativo) | **Sem obra nova** — repontar a `\citep` para `book:lee-seshia` (já definitiva) | Capítulo de **Multitasking/Scheduling** cobre preempção e escalonador cooperativo; a obra **já está em mãos** (PDF livre v2.3) e já ancora a l.19 da mesma subseção. Custo zero de acesso e de `.bib` | substituto Buttazzo (B) | **definitiva (2026-08-10, opcao 1)** → repontar para `book:lee-seshia` (sem entrada nova) |

## Lista definitiva (avalizada → `.bib`)

| Referência | bibkey | No `.bib`? |
|---|---|---|
| Lee & Seshia, *Introduction to Embedded Systems*, 2ª ed., MIT Press, 2017 | `book:lee-seshia` | Sim (2026-08-01) |
| Stallings, *Computer Organization and Architecture*, 11ª ed., Pearson | `book:stallings` | Sim (2026-08-01) |
| ISO/IEC C11, draft N1570, §5.1.2.4 par. 25 (Opção A) | `doc:c11` | Sim (2026-08-01) |
| Netzer & Miller, *What are race conditions?*, ACM LOPLAS 1(1):74–88, 1992 | `article:netzer-miller-races` | Sim (2026-08-02) |
| Bishop & Dilger, *Checking for Race Conditions in File Accesses*, Computing Systems 9(2):131–152, 1996 | `article:bishop-dilger-toctou` | Sim (2026-08-02) |
| Liu & Layland, *Scheduling Algorithms for Multiprogramming in a Hard-Real-Time Environment*, J. ACM 20(1):46–61, 1973 | `article:liu-layland-hard-real-time` | Sim (2026-08-10) |

## Lista descartada

| Referência | Motivo (curto) |
|---|---|
| Maggio et al., *Control-System Stability Under Consecutive Deadline Misses Constraints*, ECRTS 2020 (#12) | 2026-08-10: não escolhido na substituição do Buttazzo. É sobre *tolerância* a misses (weakly-hard) — abriria flanco na banca contra a frase da §1.1 |
| Stankovic, *Misconceptions About Real-Time Computing*, IEEE Computer 1988 (#13) | 2026-08-10: fechado (IEEE) — recairia no mesmo problema de acesso que motivou a troca |
