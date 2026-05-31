---
author: Claude (claude-opus-4-8)
created: 2026-05-31
---

<!-- LTeX: enabled=false -->

# Log da banca antecipada — iteração da pergunta de pesquisa

Registro **corrido** do exercício de banca antecipada sobre a redação da pergunta de
pesquisa (§1.2). Atualizado **a cada rodada** para sobreviver a travamento do PC: se a
sessão cair, este arquivo (em disco + versionado) é suficiente para retomar o fio.

**Autoria (Regras 1, 3, 5):** as formulações da pergunta entre « » são **redigidas por
Matheus T. dos Santos** — reproduzidas verbatim (com a grafia do rascunho) só para
rastreabilidade. Os furos/críticas em bullets são da **banca (Claude)**. Nenhuma
formulação da pergunta neste arquivo foi redigida por Claude.

Companion de [`recorte_tese.md`](recorte_tese.md) (decisões de recorte já fechadas) e
de [`roadmap_escrita.md`](roadmap_escrita.md).

## Âncoras do exercício (de `recorte_tese.md`)

- **Classe:** data race / aliasing concorrente (estado mutável compartilhado entre
  contextos: ISR ↔ tarefa). Enquadramento **B-dominante**; baseline = **C (MISRA +
  estado-da-arte)**, não C cru.
- **Falsificabilidade:** a tese cai se o Rust safe **forçar** sincronização mais cara
  que a do C (ex.: `Mutex` onde C usaria atomic/lock-free) **e** esse custo estourar o
  orçamento temporal da malha.
- **Dois tempos:** qualificação = cobertura qualitativa (os casos, por construção);
  dissertação = relevância + viabilidade com métricas (experimento C-vs-Rust).
- **Dois casos registrados** (caem em lados opostos da fronteira safe/`unsafe`):
  1. `ISR↔DMA` — exige `unsafe` (DMA é hardware) → **fora** do território coberto.
  2. Reconfiguração de parâmetros × uso (ganhos pela API da Aule) → território **safe**.
- **Frase-núcleo** (Matheus, 30/mai): registrada em `recorte_tese.md` §"Frase-núcleo".

## Rodada 1 — 31/mai (reconstrução pós-travamento, Matheus)

Formulação (Matheus):
> «Os data races mais comuns em algorítmos de controle embarcados, caem nas garatias da
> linguagem Rust de tornarem data races inexpremíveis, em tempo de compilação? Além
> disso, essas garantias impoem um custo suficientemente baixo para que a implementação
> destas garantias não tornem o algoritmo de controle instável?»

Furos da banca:
- **F1 — "mais comuns"** reabre a frequência/contagem (pendência P2 que já tínhamos
  desarmado: a generalização ancora na garantia `Send`/`Sync`, não na prevalência).
- **F2 — Q1 trivial** sem a fronteira `unsafe`: em código safe, a garantia vale por
  construção (infalsificável). A pergunta de pesquisa está na **localização** (safe ×
  fronteira `unsafe`), não em "a garantia funciona?".
- **F3 —** perdeu o qualificador "compartilham estado entre múltiplos contextos"
  (sem ele, sugere que todo algoritmo de controle tem concorrência).
- **F4 — "instável"** sem régua nem baseline.
- **Estrutural:** são duas RQs (cobertura + custo) que vivem em tempos diferentes.

## Rodada 2 — 31/mai (Matheus)

Formulação (Matheus):
> «Os data races relevantes em algorítmos de controle que compartilham estado entre
> múltiplos contextos, moram na fronteira safe de garantias de tornar data races
> inexpremíveis em tempo de compilação? Além disso, essas garantias impoem um custo
> suficientemente baixo para que a implementação destas garantias não façam o algoritmo
> de controle perder deadlines?»

Melhorou: F1 resolvido (caiu "mais comuns"); F3 resolvido (voltou "compartilham
estado"); F4 melhorou ("perder deadlines" = mecanismo concreto).

Furos restantes:
- **F5 — "moram na fronteira safe" se autodestrói.** (a) Terminológico: "fronteira" é
  onde a garantia *acaba* (borda safe/`unsafe`) — ambíguo sobre o lado. (b) Estrutural:
  a pergunta é binária (sim/não), mas os **dois casos registrados respondem um de cada
  lado** → resposta honesta = "uns de cada lado" → não é sim/não, é **partição**.
  **Bifurcação para Matheus decidir:** (a) reformular como *caracterização* (mapear a
  fronteira); (b) tese forte "predominantemente no safe" — mas "predominantemente"
  reabre a frequência (F1).
- **F6 — Q2 perdeu o baseline e confunde os custos.** (a) "Custo baixo" comparado a
  quê? Sem o **baseline C**, vira engenharia ("Rust é rápido?"), não a falsificabilidade
  comparativa. (b) `Send`/`Sync` é compilação → custo de runtime **zero**; o custo vem
  do **primitivo de sincronização que a garantia exige** (`Mutex` × atomic/lock-free).

## Rodada 3 — 31/mai (Matheus) — ATUAL

Formulação (Matheus):
> «Os data races relevantes em algorítmos de controle que compatilham estado entre
> múltiplos contextos, moram em que lado da fronteira entre garantir ou não que data
> races se tornem inexpremíveis, em tempo de compilação, fornecidos pela linguagem
> Rust? Além disso, os custos necessários para implementar a sincronização dessas
> garantias são suficientemente baixos para que os algoritmos de controle não percam
> deadlines?»

Melhorou:
- **F5 resolvido (tomou a bifurcação (a)):** "moram **em que lado** da fronteira" — virou
  pergunta de *caracterização/partição* (wh-question), não mais sim/não. Não se
  autodestrói mais.
- **F6(b) resolvido:** "os custos necessários para implementar a **sincronização** dessas
  garantias" — moveu o custo para o mecanismo certo (não mais "a garantia impõe custo").

Furos restantes (banca):
- **F6(a) AINDA ABERTO — baseline C ausente em Q2.** "Suficientemente baixos para não
  perder deadlines" continua **absoluto**. A falsificabilidade registrada é
  **comparativa** (delta vs. C MISRA+estado-da-arte). Sem o C dentro da pergunta, Q2 é
  pergunta de engenharia, não de pesquisa. **← furo mais grave em aberto.**
- **F7 — "em que lado" pressupõe agrupamento; "relevante" esconde um critério.** Se os
  dois casos caem em lados opostos, "em que lado moram [os relevantes]?" ainda sugere
  que eles se agrupam num lado. E "relevante" precisa de definição (relevante = toca o
  estado de controle compartilhado? — senão "relevante" vira "frequente" disfarçado, e
  F1 volta pela janela).
- **Estrutural (lembrete):** Q1 (cobertura qualitativa) é respondível **na
  qualificação**; Q2 (custo vs. C, com métricas) é **experimento da dissertação**.
  Decidir se viram RQ1+RQ2 explícitas e marcar qual responde *quando*.

## Rodada 4 — 31/mai (Matheus)

Formulação (Matheus):
> «A linguagem Rust fornece garantias de tornar inexpremíveis, em tempo de compilação,
> data races. Com isso, qual a partição dos data races presentes em algorítmos de
> controle que compartilham estado entre múltiplos contextos, que moram do lado safe da
> fronteira? Além disso, os custos necessários para implementar a sincronização das
> garatias são suficientemente baixos, em comparação com as implementações em
> C+MISRA+estado da arte, para que os algorítmos de controle não percam deadlines?»

Melhorou:
- **F6(a) resolvido:** Q2 agora traz "em comparação com as implementações em
  C+MISRA+estado da arte" — o baseline entrou; Q2 ficou comparativa (falsificável).
- **F7 atacado:** virou "qual a **partição**" (caracterização), não mais "em que lado".

Furos restantes (banca):
- **F8 — o filtro "que moram do lado safe" anula/desvia a partição.** Uma partição é a
  divisão {safe × `unsafe`}; pré-filtrar para "os que moram do lado safe" ou (a) torna a
  partição vazia (você já escolheu um lado), ou (b) ilumina o lado **coberto por
  construção** (trivial) e esconde o lado `unsafe` — que é onde mora a contribuição
  (superfície que escapa, seu tamanho/auditabilidade; eixo da honestidade; critério
  4.6). A partição precisa nomear os **dois** lados, com peso no lado `unsafe`.
- **F9 — a premissa de abertura sobreafirma.** "Rust torna data races inexprimíveis"
  precisa de "**em código safe**". Sem isso, soa como "Rust elimina todo data race"
  (falso — `unsafe`/FFI) e contradiz a própria *fronteira* que a Q1 invoca logo depois.
- **Afinação Q2:** "sincronização das garantias" → conceito já acordado é "a
  sincronização que a garantia *força/exige*" (redação é do Matheus, Regra 1). E a
  falsificação precisa é o caso **diferencial**: *C cumpre o deadline e o Rust não*,
  porque o safe o empurrou para um primitivo mais caro.

## Rodada 5 — 31/mai (Matheus)

Formulação (Matheus) — também colada em `capitulos/introducao.tex` linha 4 por ele:
> «A linguagem Rust fornece garantias de tornar inexpremíveis, em tempo de compilação e
> em código safe, data races. Com isso, onde mora a fronteira entre safe e unsafe para
> os data races presentes em algorítmos de controle que compartilham estado entre
> múltiplos contextos? Além disso, os custos impostos para implementar a sincronização
> das garatias são suficientemente baixos, em comparação com as implementações em
> C+MISRA+estado da arte, para que os algorítmos de controle não percam deadlines?»

Melhorou:
- **F9 resolvido:** premissa agora diz "em código safe".
- **F8 resolvido:** caiu o filtro "que moram do lado safe"; Q1 virou "onde mora a
  fronteira entre safe e `unsafe`" — nomeia os dois lados, caracterização honesta.

Avaliação da banca: **estruturalmente defensável.** Os furos que tornavam a pergunta
trivial/infalsificável/auto-contraditória foram todos fechados. O que resta é
enquadramento, não furo de validade.

Furos/resíduos restantes:
- **F7 (resíduo, único substantivo) — "os data races presentes" precisa de fonte.**
  *Presentes* segundo qual enumeração? Se não ancorar numa **taxonomia de padrões de
  concorrência** em controle embarcado (produtor/consumidor ISR↔tarefa; reader/writer de
  parâmetros compartilhados; etc.), a banca pergunta "como sabe que cobriu os data races
  presentes — listou todos?" (é a P2/salto-da-amostra de novo). Resolução já registrada:
  generalização ancora na garantia (`Send`/`Sync` cobre qualquer padrão) + demonstração
  por construção com padrões representativos; "presentes" = a taxonomia, não censo
  empírico exaustivo.
- **Coerência Q1↔Q2 (observação, não furo):** o "custo da sincronização forçada" da Q2
  só incide sobre os data races do **lado safe** (onde a garantia obriga a sincronizar);
  no lado `unsafe` (DMA) já se está em `unsafe`. Logo a Q2 escopa o subconjunto
  safe que a Q1 mapeia — as duas perguntas se encadeiam (Q1: o que é coberto; Q2: cobrir
  custa barato?). Bom para a narrativa; vale ele ter consciência disso ao redigir.
- **Afinação Q2 (mantida):** falsificação fina = caso diferencial (*C cumpre o deadline,
  Rust não*, por ser empurrado a primitivo mais caro). Redação é do Matheus (Regra 1).

## Pendências vivas (atualizar a cada rodada)

- [x] ~~**F6(a)**~~ — baseline C entrou na Q2 (rodada 4).
- [x] ~~**F8**~~ — filtro "lado safe" removido; Q1 nomeia safe × `unsafe` (rodada 5).
- [x] ~~**F9**~~ — premissa escopada para "código safe" (rodada 5).
- [ ] **F7 (resíduo)** — ancorar "os data races presentes" numa **taxonomia de padrões
      de concorrência** (não censo); é o único furo substantivo aberto.
- [ ] **Coerência Q1↔Q2** — ter consciência de que Q2 escopa o subconjunto safe da Q1.
- [ ] **Estrutural** — RQ1+RQ2 explícitas? marcar qualificação (Q1) × dissertação (Q2).
- [ ] **Matheus (Regra 1):** redigir a §1.2 a partir desta espinha — Claude não redige.
      (Já começou a colar em `capitulos/introducao.tex`.)
- [ ] **Cosmético (de `recorte_tese.md`):** agente da ação ("algoritmos … tornam" × "o
      sistema de tipos torna").
