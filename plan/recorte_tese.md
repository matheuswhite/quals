---
author: Claude (claude-opus-4-8)
created: 2026-05-30
modified:
  - 2026-05-30: Claude (claude-opus-4-8) — classe revisada para data race / aliasing concorrente (P3 fechada); refinado o recorte do ISR↔DMA (exemplo fora da Aule × bloco out-of-box); registrado o papel da Aule (herda e preserva, com ergonomia)
  - 2026-05-30: Claude (claude-opus-4-8) — registrada a frase-núcleo re-redigida pelo Matheus (classe data race; verbo "tornam inexprimíveis"; cortado "multi-thread")
  - 2026-05-30: Claude (claude-opus-4-8) — P2 fechada (baseline MISRA + estado-da-arte; critério por construção; falsificabilidade = sincronização forçada mais cara que C instabiliza); registrados os 2 casos de data race
---

<!-- LTeX: enabled=false -->

# Recorte da tese — registro do exercício de banca (bloco de arranque, sáb 30/mai/2026)

Registro do bloco de arranque do [`roadmap_escrita.md`](roadmap_escrita.md): exercício de banca antecipada sobre o **recorte** da pergunta de pesquisa, conduzido no chat (Claude no papel de banca; Matheus pensando em voz alta e redigindo). Este arquivo **registra decisões e o artefato que o Matheus redigiu** — não contém redação minha de tese (Regra 1).

## Frase-núcleo (provisória — redigida por Matheus T. dos Santos, 30/mai/2026)

> «Algoritmos de controle em sistemas embarcados, que compartilham estado entre múltiplos contextos, quando implementados em Rust, tornam bugs de data race inexprimíveis em tempo de compilação.»

Status: **núcleo de pé** (sujeito · contexto concorrente · verbo · classe · momento). Reflete a classe revisada — *data race / aliasing concorrente* — e o verbo honesto ("tornam inexprimíveis", não "eliminam"). **Não** é a redação final da §1.2 — é a espinha a partir da qual a pergunta de pesquisa e os objetivos serão redigidos pelo Matheus. (Versões anteriores e por que caíram: ver Trilha de iteração.)

## Decisões de recorte que a sustentam (fechadas no exercício)

- **Enquadramento:** *memory safety* (ausência de UB), **não** determinismo. Baseline da afirmação = **C**. O argumento determinismo / `Rc<RefCell>` (runtime × estático) é material do **cap. 4** (ponto-de-virada / composição forward), não da tese-núcleo.
- **Eixo A × B:** **B-dominante** — a frase está no nível do *fenômeno*; **não** cita a Aule (que é veículo/meio).
- **Sujeito:** *algoritmo de controle* (a computação), **não** *controlador* (malha completa). Mantém a fronteira `unsafe` (I/O de hardware) **fora** do sujeito da afirmação.
- **`unsafe`:** mora **fora** da Aule (HAL/PAC/crates de fronteira já existentes). A memory safety do *sistema* fica **condicionada** à soundness dessas camadas. O que se demonstra não é "ausência de `unsafe`" (trivial), mas `unsafe` **confinado** a uma superfície pequena/auditável × espalhado como em C (liga ao critério 4.6).
- **Domínio:** *sistemas embarcados* — amplo **por decisão deliberada** (inclui a parte da lib que usa `alloc`/nalgebra). Consequência assumida: enfraquece o vínculo causal "sem heap → garantia estática necessária".
- **Classe:** **data race / aliasing concorrente** — estado mutável compartilhado entre contextos (ISR ↔ tarefa); prevenido por `Send`/`Sync` + aliasing-XOR-mutabilidade, em compilação. *(Revisada de "lifetime de referência" em 30/mai — ver §"Por que a classe mudou".)*
- **Caso `ISR↔DMA`:** **exemplo demonstrativo fora da Aule** (Rust puro: RTIC / atomic / `Send`-`Sync`) entra **na qualificação** — é o único cenário do recorte onde a classe vira bug de memória real. O **bloco out-of-box da Aule** que trata isso ergonomicamente = **pós-qualificação** (proposto no cap. 6; anotado em `roadmap_escrita.md`).
- **Papel da Aule (memory safety):** a Aule **herda e preserva** a memory safety do Rust safe — estática, `no_std`, via forward — **com ergonomia**. Ela **não gera** memory safety (todo Rust safe já é memory-safe). Enunciar sempre como "herda e preserva", nunca "traz".

## Estado das pendências (30/mai — bloco de arranque encerrado)

- ~~**P3 — recorte da classe.**~~ **RESOLVIDA:** *data race / aliasing concorrente*.
- ~~**P2 — salto da amostra.**~~ **RESOLVIDA:** dois casos de padrões distintos; generalização ancorada na garantia da linguagem (`Send`/`Sync` cobre qualquer padrão), não na contagem.
- ~~**P2 — critério, baseline, falsificabilidade.**~~ **RESOLVIDA:** ver §"P2 — o que conta como demonstrado".
- **Aberta (Matheus, Regra 1):** redigir a §1.2 (pergunta de pesquisa + objetivos) a partir desta espinha.
- **Aberta (cosmético):** agente da ação — "algoritmos … tornam" × "o sistema de tipos torna".

## Casos de data race (qualificação)

1. **`ISR↔DMA`** — produtor/consumidor de dados (buffer de amostras); **fora da Aule**; exemplo demonstrativo.
2. **Reconfiguração de parâmetros × uso** — reader/writer de estado (ganhos); **toca a API da Aule**; forte se os parâmetros forem um conjunto que precisa de consistência (matriz K), fraco se escalar atômico.

Padrões distintos → sustentam a generalização; a garantia (`Send`/`Sync`) generaliza além dos casos.

## P2 — o que conta como demonstrado (fechada 30/mai)

- **Não é provar o teorema.** "Rust torna data race inexprimível em código safe" é soundness de `Send`/`Sync` — provado, infalsificável. A tese-de-pesquisa mora na **relevância** (os data races relevantes caem no safe — coberto — ou na fronteira `unsafe` — não-coberto?) e na **viabilidade** (custo aceitável?).
- **Critério (por construção):** mesmo padrão nos dois lados; em **C** o data race compila/roda e o **TSan pega em runtime**; em **Rust** não compila sem sincronização. Trio por caso: { snippet C · erro de compilação Rust · diagnóstico do sanitizer }.
- **Baseline em C:** **MISRA + estado-da-arte** (análise estática — Polyspace/Coverity — + sanitizers em teste); não MISRA cru. Contraste central (eixo 5): garantia parcial/externa/posterior × total/no-tipo/em-compilação.
- **Falsificabilidade:** a tese cai **se o Rust safe forçar sincronização mais cara que a do C** (ex.: `Mutex` onde o C usaria atomics/lock-free) **e** o custo adicional consumir ciclos suficientes para instabilizar a malha. Testa a hipótese de paridade de performance (4.6) e aponta para o design da Aule (expor lock-free safe × só `Mutex`). *(Cenário estreito — malhas rápidas / margem apertada; caracterizar quando.)*
- **Dois tempos:** qualificação = cobertura por construção, qualitativa (os casos); dissertação = relevância + viabilidade com métricas (experimento C-vs-Rust + sanitizers; fronteira `unsafe`, boilerplate, performance).

## Por que a classe mudou para data race / aliasing concorrente (30/mai)

"Lifetime de referência" não sobreviveu ao teste dos cenários concretos. Em `no_std` sem heap e em **single-context** (sem concorrência), o borrow checker barra padrões que em C **não são UB** — sobra *staleness* (erro de lógica) ou conservadorismo, não bug de memória. Aliasing/lifetime só vira **bug de memória** com **concorrência** (data race) ou **realocação** (dangling), e o recorte exclui realocação (`no_std` sem `alloc`). Logo, o único lugar com memory safety **não-trivial** no recorte é a **concorrência** → classe = *data race / aliasing concorrente*, ancorada no `ISR↔DMA`.

## Trilha de iteração (rastreabilidade do recorte — por que cada versão anterior caiu)

- verbo de *capacidade* ("é capaz de prevenir") → infalsificável e trivial;
- classe larga/imprecisa ("bugs de memória" / "relacionados a ponteiros") → inclui bounds (runtime) e território `unsafe`;
- âncora de domínio por **exemplar** (Cortex-M) → exemplar no lugar da classe/regime;
- adjetivo de marketing ("mais seguros") + inversão tese↔justificativa;
- sujeito "controlador" (malha completa) → reabre a fronteira `unsafe` do HAL;
- classe "lifetime de referência" → em `no_std` single-context não há UB a eliminar; migrou para *data race / aliasing concorrente* (ver acima).
