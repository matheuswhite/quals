---
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-15
---

<!-- LTeX: enabled=false -->

# Log da banca antecipada — iteração da pergunta de pesquisa

> **ENCERRADO (1/jun/2026).** §1.2 (pergunta + objetivos) redigida e commitada, e o título
> reenquadrado para o nível do fenômeno (B-dominante, sem Aule). Este arquivo fica como
> **histórico** (rodadas 1–10, furos F1–F21). Próxima etapa do projeto: Cap. 4 — ver
> `roadmap_escrita.md`.

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

## Rodada 6 — banca dos objetivos (rascunho em `introducao.tex`, 31/mai)

Matheus redigiu os Objetivos (Gerais + Específicos) em `capitulos/introducao.tex`.
Banca atacou o rascunho — furos:

- **F11 — contribuição/artefato ausente dos objetivos.** Os objetivos descrevem
  *investigar* uma propriedade do Rust (que existe independentemente do trabalho) +
  *medir* overhead. A **Aule** (o artefato) não aparece. Risco: banca lê como **estudo
  de avaliação**, não tese com contribuição. Reconciliar com `recorte_tese.md` (Aule =
  veículo; bloco out-of-box = pós-qualificação): tornar **legível** o que É a
  contribuição (caracterização + protocolo + casos + espaço de design do obj. 3).
- **F12 — viabilidade do experimento físico (obj. 4,5,6).** "Sistemas embarcados físicos
  (não-simulados)": qual hardware? quantas plataformas? overhead é plataforma-dependente
  (M0/M4/M7, cache) — uma placa não generaliza. Produto cartesiano (padrões × primitivos
  × plataformas) explode o escopo.
- **F13 — obj. 6 funde duas comparações distintas.** Overhead de runtime (sincronização
  Rust × sincronização do C) ≠ garantia de segurança (tipo/compilação × MISRA +
  sanitizers + ISO). Sanitizers são ferramenta de *teste*, não custo de runtime — não
  entram na comparação de overhead. Separar o eixo 5 (qualitativo) do experimento de
  custo (quantitativo).
- **F14 — obj. 5 "perda de deadline" sem tarefa de controle nem regime.** Precisa de uma
  malha concreta (período de amostragem) e do regime onde a sincronização é fração
  relevante do orçamento (malha rápida / margem apertada — o cenário estreito de
  `recorte_tese.md`). Senão mede "zero perdas" trivialmente e não conclui nada.
- **F15 — inconsistência pergunta↔objetivo geral.** O Objetivo Geral diz "data races
  presentes em algoritmos de controle" e **perde** "que compartilham estado entre
  múltiplos contextos" (presente na pergunta e no objetivo específico 1).
- **F16 — verbo "investigar" não-mensurável + falta o corte de tempo.** Objetivo deve
  declarar o artefato que prova conclusão. E falta marcar quais objetivos são da
  **qualificação** (1,2,3 — qualitativos) × da **dissertação** (4,5,6 — experimento).
- **Ganho:** **F7 atendido no nível de objetivo** — o objetivo específico 1 É "descrever
  uma taxonomia de padrões". Falta o **corpo do texto entregar** a taxonomia (item F7 do
  `checklist_revisao.md` segue valendo para a revisão).

## Rodada 7 — banca dos objetivos (consolidação pós-edições, 1/jun)

Matheus iterou os Objetivos várias vezes (verbos → corte de tempo → separação
custo/garantia → inserção do Aulë). Estado atual em `capitulos/introducao.tex` (redação do
Matheus, Regra 1; reproduzido verbatim, com a grafia do rascunho, só para rastreabilidade):

Geral:
> «Para este trabalho, o objetivo inicial é a caracterização da fronteira entre safe e
> unsafe dos data races presentes em algorítmos de controle, que compartilham estado entre
> múltiplos contextos. Com esta fronteira definida, o objetivo seguinte é avaliar o custo
> para implementar a sincronização imposta pelo lado safe da fronteira; e comparar com o
> estado da arte atual para implementar algoritmos de controle em C usando MISRA e padrões
> de controle de qualidade (como ISOs e sanitazers).»

Corte: «Os objetivos 1, 2 e 3 serão desenvolvidos na qualificação, enquanto os objetivos
4, 5, 6 e 7 serão desenvolvidos na tese final.»

Específicos:
> 1. «Propor uma taxonomia de padrões de data races presentes em algorítmos de controle
>    que compartilham estado entre múltiplos contexto;»
> 2. «Caracterizar a fronteira entre safe e unsafe destes padrões de data races;»
> 3. «Catalogar os meios possíveis de implementar as garantias impostas para tornar os
>    data races, presentes no lado safe da fronteira, inexpremíveis;»
> 4. «Implementar, na biblioteca Aulë, os meios representativos das garantias impostas para
>    tornar os data races, presentes no lado safe da fronteira, inexpremíveis;»
> 5. «Avaliar a perda de deadlines destas implementações em controladores com realimentação
>    de estados, em controle um pendulo invertido, em placas com Cortex-M0;»
> 6. «Comparar a perda de dealines em Rust com a implementação do estado da arte de
>    controladores, que compartilham estado entre múltiplos contextos, em C.»
> 7. «Comparar a verificação em tipos e em tempo de compilação da implementação destes
>    algorítmos de controle, com a implementação do estado da arte em C, que usa MISRA e
>    padrões de controle de qualidade (como ISOs e sanitazers).»

Furos da rodada 6 — RESOLVIDOS:
- **F11** ✅ — Aulë entrou como artefato *bounded* ("meios representativos") no bloco da
  dissertação (obj. 4), com verbo "implementar" e citando a lib. Pergunta e geral seguem
  SEM citar o Aulë → claim central no nível do fenômeno: **B-dominante intacto**. A
  contribuição de conhecimento (obj. 1–3: propor/caracterizar/catalogar) segue legível.
- **F12** ✅ — plataforma nomeada (Cortex-M0). ⚠️ **REABERTO (2026-06-15):** plataforma migrada p/ **ESP32 Xtensa dual-core** (operada em núcleo único; multi-core fora do escopo). O obj 5 acima ainda diz "Cortex-M0" → **re-redigir** (Matheus, Regra 1). Decisão e ripple em [`cap_4_metodologia.md`](cap_4_metodologia.md) §"Decisão (2026-06-15)".
- **F13** ✅ — eixos separados: custo (obj. 5–6) × garantia qualitativa (obj. 7,
  tipo/compilação × MISRA+sanitizers). Sanitizers fora do objetivo de custo.
- **F14** ✅ em grande parte — tarefa (realimentação de estados) + planta (pêndulo
  invertido = rápida/instável, regime de margem apertada) + plataforma (M0). Resíduo
  body-level: declarar o período de amostragem.
- **F15** ✅ — geral ganhou "que compartilham estado entre múltiplos contextos".
- **F16** ✅ — verbos mensuráveis (propor/caracterizar/catalogar/implementar/avaliar/
  comparar) + corte qualificação (1–3) × dissertação (4–7) explícito.
- **Diferencial Rust × C** (furo da sub-rodada anterior) ✅ — obj. 6 trouxe a comparação
  quantitativa da perda de deadline (a falsificabilidade do `recorte_tese.md:53`).

Furos NOVOS (rodada 7):
- **F17 — custo (overhead) não é medido, só a consequência (deadline). [mais grave]** A
  pergunta pede "os custos são suficientemente baixos" = magnitude. obj. 5 e 6 medem só
  "perda de deadlines" (binário, dependente da margem escolhida). O delta de overhead
  (ciclos/µs) da sincronização forçada — que *explica* a perda e ancora `recorte:53` —
  sumiu (era o obj. "overhead de tempo de execução", largado numa fusão anterior). Risco:
  banca diz "você ajustou a margem pra dar miss". Medir o overhead; deadline = stress test
  derivado.
- **F18 — gap obj. 5 ↔ obj. 6.** obj. 6 compara perda de deadline Rust × C, mas nenhum
  objetivo mede o lado **C** (obj. 5 mede só o Rust). Ou obj. 5 cobre os dois lados, ou
  falta o passo de medir o C.
- **F19 — "meios representativos" (obj. 4) sem critério.** Representativos por qual regra?
  Precisa de critério de seleção (ex.: um por eixo do espaço de design do obj. 3 —
  lock-free safe × `Mutex`). Body-level, mas a banca pergunta.
- **F20 — reconciliar obj. 4 com `recorte_tese.md:30`.** "Implementar os meios
  representativos" (dissertação) é o mesmo que o "bloco out-of-box ergonômico" adiado para
  pós-qualificação (cap. 6)? Se sim, `recorte:30` mudou (entrou na dissertação) e precisa
  atualização. Se não (impl mínima p/ medir ≠ bloco polido), ok, mas registrar a distinção.

## Rodada 8 — banca dos objetivos (1/jun, pós-F17/F18)

Matheus reescreveu obj. 4–6 atacando F17/F18/F19/F20. Estado atual (redação do Matheus,
Regra 1; verbatim com a grafia do rascunho):

> 4. «Implementar, na biblioteca Aulë, um subconjunto das garantias impostas para tornar
>    os data races, presentes no lado safe da fronteira, inexpremíveis;»
> 5. «Avaliar o overhead de tempo de execução destas implementações (em Rust) e em
>    implementações em C, em controladores com realimentação de estados, em controle de um
>    pendulo invertido, em placas com Cortex-M0;»
> 6. «Comparar o overhead de tempo de execução entre a implementação em Rust e em C de
>    controladores que compartilham estado entre múltiplos contextos;»

(corte agora diz "pós-qualificação" para 4–7, não mais "tese final".)

RESOLVIDOS:
- **F17** ✅ — obj. 5 mede "overhead de tempo de execução" (magnitude), não mais perda de
  deadline. O furo de validade mais grave caiu.
- **F18** ✅ — obj. 5 mede Rust **e** C; obj. 6 só compara. Cadeia medir→comparar limpa.
- **F20** ✅ em grande parte — "pós-qualificação" alinha obj. 4–7 com `recorte:30`. Resíduo
  só terminológico (pós-qualificação ≡ dissertação ≡ tese final = mesma fase).

AMACIADO:
- **F19** ~ — "meios representativos" → "um subconjunto" (largou a afirmação de
  representatividade). Ainda falta o **critério de seleção** do subconjunto (ex.: um por
  eixo do espaço de design do obj. 3).

NOVO:
- **F21 — o deadline (régua da Q2) sumiu dos objetivos.** A pergunta termina em "…para que
  não percam deadlines?", mas obj. 5/6 agora medem só overhead (delta sem critério de
  aprovação). "Suficientemente baixo" precisa do **orçamento de deadline** como limiar — a
  falsificabilidade do `recorte:53` é o overhead *cruzando* o orçamento. Não é desfazer
  F17: o ideal é overhead (✅) **julgado contra o deadline** (pode ser análise de
  escalonabilidade, não miss empírico). Desalinhamento pergunta↔objetivo na Q2 (gêmeo do F15).
- **Minor (precisão):** obj. 4 "subconjunto **das garantias**" → conceitualmente é
  subconjunto **dos meios** (obj. 3 cataloga meios; garantia não se implementa, os meios
  que a satisfazem é que se implementam). Redação do Matheus.

## Rodada 9 — banca dos objetivos (1/jun): deadline de volta + obj. 4 → qualificação

Matheus (1/jun): re-adicionou o deadline e **moveu o obj. 4 para a qualificação**. Agora são
8 objetivos; corte: **1–4 = qualificação, 5–8 = pós-qualificação**. Verbatim (redação do
Matheus, Regra 1; com a grafia do rascunho):

> 4. «Implementar, na biblioteca Aulë, um subconjunto das garantias impostas para tornar os
>    data races, presentes no lado safe da fronteira, inexpremíveis;»  ← agora na qualificação
> 5. «Avaliar o overhead de tempo de execução destas implementações (em Rust) e em
>    implementações em C, em controladores com realimentação de estados, em controle de um
>    pendulo invertido, em placas com Cortex-M0;»
> 6. «Avaliar a perda de deadlines nos algoritmos de controle implementados em Rust e em C;»
> 7. «Comparar o overhead de tempo de execução e a perda de deadlines entre a implementação
>    em Rust e em C de controladores que compartilham estado entre múltiplos contextos;»
> 8. «Comparar a verificação em tipos e em tempo de compilação … (MISRA + sanitizers).»

RESOLVIDO:
- **F21** ✅ — o deadline voltou: obj. 6 mede a perda de deadline (Rust e C); obj. 7 compara
  overhead **e** deadline (Rust × C). Magnitude (overhead) + régua (deadline) presentes; a
  Q2 fecha ponta a ponta.

CONFLITO NOVO (mais sério que furo de redação — é de planejamento):
- **obj. 4 na qualificação × decisões já fechadas.** Mover "implementar na Aulë" para a
  qualificação **contradiz** três registros:
  1. `roadmap_escrita.md:81` — "o bloco reutilizável da Aule … é trabalho **pós-qualificação**
     … ter o **esboço do mecanismo** pronto para a defesa, **mesmo sem implementar**".
  2. `recorte_tese.md:30` — bloco out-of-box = pós-qualificação.
  3. `roadmap:57-67` "Definição de pronto" — pede *caso demonstrativo* + *estado da Aule
     documentado*, **não** implementar novos meios na lib.
  - **Risco de cronograma:** roadmap apertado (8 semanas parciais, ~10–12 h/sem; risco nº 1
    = estouro de escopo; estratégia = núcleo primeiro, cortar periferia). As 8 semanas já
    estão lotadas (caps 4→5→3→2→1→6→7→revisão). Sem slot para implementar meios de
    sincronização na Aulë sem deslocar o núcleo ou comer o buffer.
  - **Decisão pendente do Matheus** (recorte:30 / roadmap:81 NÃO reescritos): a impl da
    qualificação É o bloco out-of-box (revoga a postergação, assume o risco) ou um
    subconjunto mínimo distinto que cabe no cronograma? Registrado nas pendências do
    `recorte_tese.md`.

AINDA ABERTO:
- **F19** — obj. 4 sem critério de seleção do subconjunto; "garantias" deveria ser "meios"
  (encadear com obj. 3).

## Rodada 10 — fechamento do rascunho dos objetivos (1/jun)

Matheus: (a) reverteu o obj. 4 para **pós-qualificação** → o conflito de cronograma some e a
postergação do bloco out-of-box volta a valer; (b) adotou "**espaço de design**" no obj. 3;
(c) deu o critério de seleção no obj. 4 — "**um por eixo do espaço de design**".

Estado final (corte: **1–3 qualificação, 4–8 pós-qualificação**):
- 1 propor taxonomia · 2 caracterizar fronteira · 3 catalogar o espaço de design.
- 4 implementar subconjunto na Aulë (um por eixo) · 5 overhead Rust+C (pêndulo invertido,
  Cortex-M0) · 6 perda de deadline Rust+C · 7 comparar overhead+deadline Rust×C · 8 comparar
  garantia (tipo/compilação × MISRA+sanitizers).

RESOLVIDOS:
- **Conflito (obj. 4 na qualificação)** ✅ — revertido para pós-qualif; realinhado a
  `recorte:30` / `roadmap:81`.
- **F19** ✅ — critério de seleção explícito ("um por eixo do espaço de design").

Resíduos NÃO-graves (não bloqueiam o rascunho):
- Cosmético: obj. 4 "subconjunto das garantias" → conceitualmente "dos meios" (o parêntese
  "um por eixo do espaço de design" já aponta pro espaço de meios; mitigado).
- Body-level: período de amostragem do regime (resíduo do F14); ortografia (inexpremíveis →
  inexprimíveis, garatias, algorítmos, sanitazers, "contexto" no obj. 1) — revisão do Matheus.
- LaTeX (forma): a lista "1. 2. 3." não renderiza como `enumerate` em LaTeX cru.

**Veredito da banca: rascunho dos objetivos estruturalmente fechado.** Sem furos de validade
abertos; o que resta é redação/forma do Matheus.

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
- [~] **F7** — promovido a objetivo específico 1; falta o **corpo entregar** a taxonomia
      (segue no `checklist_revisao.md`).
- [x] ~~**F11**~~ — Aulë legível como artefato bounded no bloco da dissertação (obj. 4);
      B-dominante preservado (pergunta/geral sem citar a lib). (rodada 7)
- [x] ~~**F12**~~ — plataforma nomeada (Cortex-M0). (rodada 7)
- [x] ~~**F13**~~ — custo (obj. 5–6) separado de garantia qualitativa (obj. 7). (rodada 7)
- [x] ~~**F14**~~ — tarefa + planta (pêndulo invertido) + plataforma. Resíduo body-level:
      período de amostragem. (rodada 7)
- [x] ~~**F15**~~ — geral alinhado ao escopo da pergunta (estado compartilhado). (rodada 7)
- [x] ~~**F16**~~ — verbos mensuráveis + corte qualificação × dissertação. (rodada 7)
- [x] ~~**F17**~~ — obj. 5 passou a medir overhead (magnitude). (rodada 8)
- [x] ~~**F18**~~ — obj. 5 mede Rust e C; obj. 6 compara. (rodada 8)
- [~] **F20** (moot — reaberto na rodada 9, ver Conflito) — "pós-qualificação" alinhava obj. 4–7 com `recorte:30` (resíduo
      terminológico). (rodada 8)
- [x] ~~**F21**~~ — deadline de volta (obj. 6 mede, obj. 7 compara overhead+deadline). (rodada 9)
- [x] ~~**Conflito (1/jun)**~~ — obj. 4 revertido para pós-qualificação; conflito com
      `recorte:30`/`roadmap:81` e cronograma resolvido. (rodada 10)
- [x] ~~**F19**~~ — critério de seleção explícito no obj. 4 ("um por eixo do espaço de
      design"). (rodada 10)
- [~] **Minor/cosmético** — obj. 4 "subconjunto das garantias" → "dos meios" (mitigado pelo
      parêntese "um por eixo do espaço de design"); body-level, não bloqueia. (rodada 10)
