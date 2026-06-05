---
author: Claude (claude-opus-4-8)
created: 2026-06-04
---

<!-- LTeX: enabled=false -->

# Registro do levantamento bibliográfico — referências do cap. 4 (04/jun/2026)

**O que é este documento:** registro factual e auditável de **como** as 12 referências adicionadas ao `referencias.bib` em 04/jun/2026 foram levantadas — para responder à banca se perguntada. **Não** é texto para a dissertação, e **não** descreve o método de levantamento da tese (esse é trabalho do autor — ver §"Ressalvas").

## Quem conduziu e como

- As buscas foram executadas pela **ferramenta de busca web do assistente de IA (Claude, modelo `claude-opus-4-8`)** nesta sessão de trabalho, sob direção do autor (Matheus).
- Houve uma primeira tentativa por um subagente que **não obteve acesso à rede** (todas as ferramentas de rede negadas); o levantamento efetivo foi feito na sessão principal.
- Natureza: **levantamento dirigido a obras canônicas** (*purposive / by-reference*), não busca sistemática. Ponto de partida = lista de tópicos derivada do escopo da tese; para cada tópico, busca da referência seminal/de maior autoridade.

## Fontes (domínios) usadas para confirmar metadados

A ferramenta de busca é um **motor de busca web genérico** (não uma base acadêmica indexada). Os metadados (autores, ano, páginas, DOI, ISBN) foram confirmados preferencialmente em **fonte primária**:

- **ACM Digital Library** (`dl.acm.org`) — Boehm&Adve'08, Boehm'05, Adve&Boehm'10, RustBelt'18, ThreadSanitizer'09, Liu&Layland'73, Sharma'24.
- **IEEE Xplore** (`ieeexplore.ieee.org`) — Eriksson'13 (SIES).
- **USENIX** (`usenix.org`) — AddressSanitizer'12.
- **CACM** (`cacm.acm.org`) — Adve&Boehm'10.
- **DBLP** (mirror em `sigmod.org`) — Liu&Layland'73.
- **MISRA** (`misra.org.uk`) — MISRA C:2012.
- **Princeton University Press** (`press.princeton.edu`) — Åström&Murray.
- **Pearson / MathWorks** — Ogata (5ª ed.).
- **arXiv** (`arxiv.org`) — Sharma'24 (versão estendida).
- Corroboração secundária: `semanticscholar.org`, `research.google`, `researchgate.net`, páginas dos autores (`hboehm.info`, `mpi-sws.org`).

## Palavras-chave (queries exatas executadas)

14 buscas, na ordem. Cada uma combinou autor(es) + título (entre aspas quando preciso) + venue + ano + campos a confirmar (DOI/páginas/ISBN).

| # | Query | Referência produzida |
|---|---|---|
| 1 | `Boehm Adve Foundations of the C++ Concurrency Memory Model PLDI 2008 DOI pages` | boehm2008foundations |
| 2 | `Boehm "Threads Cannot Be Implemented As a Library" PLDI 2005 DOI pages` | boehm2005threads |
| 3 | `Adve Boehm "Memory Models: A Case for Rethinking Parallel Languages and Hardware" Communications ACM 2010 DOI` | adve2010memory |
| 4 | `RustBelt Securing the Foundations of the Rust Programming Language POPL 2018 Jung DOI pages` | jung2018rustbelt |
| 5 | `RTIC RTFM Real-Time For the Masses interrupt-driven concurrency Rust Lindgren paper DOI` | eriksson2013rtfm |
| 6 | `ThreadSanitizer data race detection in practice Serebryany Iskhodzhanov 2009 WBIA DOI` | serebryany2009threadsanitizer |
| 7 | `AddressSanitizer fast address sanity checker Serebryany USENIX ATC 2012 DOI pages` | serebryany2012addresssanitizer |
| 8 | `MISRA C:2012 Guidelines for the use of the C language in critical systems citation publisher year` | misra2012 |
| 9 | `Åström Murray "Feedback Systems: An Introduction for Scientists and Engineers" Princeton edition year` | astrom2008feedback |
| 10 | `Liu Layland "Scheduling algorithms for multiprogramming in a hard-real-time environment" JACM 1973 DOI pages volume` | liu1973scheduling |
| 11 | `Eriksson "Real-time for the masses step 1" SIES 2013 IEEE DOI pages` | eriksson2013rtfm (DOI) |
| 12 | `Ogata "Modern Control Engineering" 5th edition Prentice Hall year ISBN` | ogata2010modern |
| 13 | `academic paper Rust for embedded systems no_std safety survey OR "The Embedded Rust Book" reference` | sharma2024rust |
| 14 | `"Threads cannot be implemented as a library" Boehm PLDI 2005 pages 261` | boehm2005threads (páginas) |

## Critério de seleção

Para uma referência entrar, satisfez **todos**:

1. **Pertinência ao tópico** — cada tópico deriva diretamente do escopo do cap. 4 (modelo de memória / definição de data race; segurança de tipos do Rust; concorrência em embarcado/RTIC; sanitizers; MISRA; controle por realimentação / pêndulo; garantias de deadline; Rust em `no_std`).
2. **Autoridade / canonicidade** — obra **seminal** ou de referência do tópico (ex.: Boehm&Adve para o modelo de memória C++; RustBelt para a base formal do Rust; Liu&Layland para escalonamento de tempo real).
3. **Veículo confiável** — periódico/anais **revisados por pares** de prestígio (PLDI, POPL, CACM, JACM, USENIX ATC, ACM CCS, IEEE SIES), **norma** reconhecida (MISRA C:2012) ou **livro-texto** consagrado (Ogata; Åström&Murray).
4. **Metadados confirmados em fonte primária** (editora/venue), não só de snippet de busca.

**Não houve** critério de exclusão por triagem (não foi screening de N resultados): o levantamento mira a obra esperada por tópico, não varre um corpus.

## Ressalvas (honestidade para a banca)

1. **Não é revisão sistemática.** Sem protocolo (PRISMA), sem strings de busca em bases acadêmicas dedicadas (Scopus, Web of Science, Google Scholar exaustivo), sem critérios de inclusão/exclusão aplicados a um conjunto amplo. É um atalho pragmático para as referências **fundacionais** do cap. 4 — não cobre o estado da arte do cap. 2.
2. **Motor de busca genérico** (US-only), não base indexada — pode haver viés de cobertura.
3. **Levantamento assistido por IA** — precisa de **apropriação pelo autor**: ler cada trabalho, confirmar pertinência e citá-lo só onde sustenta o argumento. A banca tende a desconfiar de "uma IA achou"; a defesa é o autor ter lido e validado.
4. **Pendências conhecidas:** `sharma2024rust` está com `author = {Sharma, Ayushi and others}` (lista completa a confirmar); `serebryany2012addresssanitizer` é USENIX (sem DOI — id da ACM DL na nota).

## Recomendação

- **Para o cap. 4 (estas 12):** validar cada uma (ler/confirmar pertinência) antes de citar; completar os metadados pendentes.
- **Para o cap. 2 (Relacionados) e o obj. 1 (taxonomia):** lá o **método de levantamento é parte da contribuição** e precisa ser **conduzido e documentado pelo autor** — com bases acadêmicas, strings de busca registradas e critérios de inclusão/exclusão explícitos. Este registro **não** substitui aquele método; serve de modelo de rastreabilidade.
