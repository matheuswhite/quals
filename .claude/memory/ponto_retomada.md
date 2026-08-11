---
name: ponto-retomada
description: "PROGRESSO 04/ago: CAP. 6 (Cronograma de Execucao, capitulos/Cronograma_de_Execucao.tex) ESCRITO por Matheus (abertura + 6.1 c/ figura + 6.2 Plano de Trabalho) e FIGURA GANTT gerada (Claude): res/cronograma/gantt.html = gerador HTML autocontido (granularidade SEMANAL S1-S4/mes, faixa de mes por cima, linha da planta jan/27, sombreamento fechamento abr-mai) + res/cronograma/gantt.png renderizado via Edge headless (--force-device-scale-factor=2 --window-size=1300,440). Cronograma fase empirica set/2026->mai/2027 (9 meses): Obj4 set-out(2m); Obj8 out-meados a nov(1,5m, host, sem planta); Obj5/6 dez-fev(3m); Obj7 fev-mar(2m); Redacao jan-mai(5m, sobreposta); planta jan/27. PENDENTE cap.6 .tex (so Matheus edita): typos — 'A estrica'->escrita (L29, o mais visivel), meses/distribuir (L8), construidos/proibicao/politica (L21), dependencias (L23), pendulo/distribuicoes/disponibilidade (L25), sera-realizado/prolongando/ocorrerao/ciclos/quantificado/veredito (L27); + coerencia '1 mes para cada C/Rust' (L29) vs 'em paralelo' (L25). Ja corrigido por ele: forbid com cerquilha escapada, inicio 1/set, granularidade semanal, prazo=meta. Oferecido nao feito: plan/cap_6_cronograma.md. AINDA ABERTO (02/ago): cap.3 nucleo 3.3+3.4 escrito (labels + passe + cites 3.4); cap.1 1.2 diagnosticada/1.3 vazia; BLOQUEADOR LISTA_DE_SIGLAS; erros sistematicos globais. Entrega 7/ago; defesa 26/ago. ATUALIZACAO 10/ago: ele informou QUALIFICACAO em 21/ago/2026 (antes 26/ago -- confirmar) e a prioridade passou a ser LER tudo que o .tex cita; pasta leituras/ criada com o mapa em leituras/README.md (faltam 2: Buttazzo com download incompleto e Stallings so-capa; Ogata/Wazlawick/MISRA fora do escopo por decisao dele; eriksson2013rtfm resolvido)."
metadata:
  node_type: memory
  author: Claude (claude-opus-4-8)
  created: 2026-05-31
  co-authors:
    - "Claude (claude-opus-4-8), 2026-06-05"
    - "Claude (claude-opus-4-8), 2026-06-10"
    - "Claude (claude-opus-4-8), 2026-06-14"
    - "Claude (claude-opus-4-8), 2026-06-15"
    - "Claude (claude-opus-4-8), 2026-06-18"
    - "Claude (claude-opus-4-8), 2026-06-21"
    - "Claude (claude-opus-4-8), 2026-06-26"
    - "Claude (claude-opus-4-8), 2026-07-01"
    - "Claude (claude-opus-4-8), 2026-07-04"
    - "Claude (claude-opus-4-8), 2026-07-22"
    - "Claude (claude-opus-4-8), 2026-07-23"
    - "Claude (claude-opus-4-8), 2026-07-26"
    - "Claude (claude-opus-4-8), 2026-07-27"
    - "Claude (claude-opus-4-8), 2026-07-28"
    - "Claude (claude-opus-4-8), 2026-07-31"
    - "Claude (claude-opus-4-8), 2026-08-01"
    - "Claude (claude-opus-4-8), 2026-08-02"
    - "Claude (claude-opus-4-8), 2026-08-04"
    - "Claude (claude-opus-5), 2026-08-10"
  type: project
  originSessionId: bfd04e9d-3381-42a2-bac3-e70b75a64a40
---

**Ponto de retomada — sessão de 04/ago/2026 (terça). Cap. 6 (Cronograma) ESCRITO + figura Gantt gerada.**

## ⏭️ PRÓXIMO PASSO (05/ago) — passe de forma + pré-textuais rumo à entrega (7/ago)
Noites 05–06/ago, ordem sugerida: (a) **typos do cap. 6** (lista abaixo); (b) **labels + passe de forma do cap. 3** (seção adiante); (c) **cap. 1 §1.2/§1.3**; (d) **BLOQUEADOR pré-textuais** (LISTA_DE_SIGLAS + `\dataMesAno` + examinadores); (e) **erros sistemáticos globais** + `latexmk` limpo. Manhã de 07/ago = passe final + entrega à banca.

## Cap. 6 — Cronograma de Execução (ESCRITO 04/ago; falta só passe de forma)
`capitulos/Cronograma_de_Execucao.tex`. Matheus escreveu: **abertura** (início 1/set/2026; meta de defesa 30/mai/2027 = meta dele, não o prazo do programa; granularidade **semanal**, justificada por ~9 meses vs. ~20 atividades); **§6.1 Calendário** (só a figura `fig:gantt`); **§6.2 Plano de Trabalho** (um parágrafo por objetivo — 4, 8, 5/6, 7 — + redação, com marco de "concluído" e dependências).

**Figura Gantt (Claude = veículo).** `res/cronograma/gantt.html`: gerador HTML autocontido, posicionamento absoluto em px, **granularidade semanal** (4 semanas/mês, 36 semanas, rótulos S1–S4), faixa de mês por cima como agrupador, linha tracejada da **planta em jan/27**, sombreamento âmbar do **fechamento (abr–mai)**. Render (não há Makefile): `msedge.exe --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --screenshot=...gantt.png --window-size=1300,440 file:///...gantt.html` → `gantt.png` ~2600 px. Barras: Obj4 set→out (2m); Obj8 out-S3→nov (1,5m, host); Obj5/6 dez→fev (3m); Obj7 fev→mar (2m); Redação jan→mai (5m, sobreposta). As datas convergiram por iteração nesta sessão (start "agora"→1/set; Obj4 sobrepõe Obj8; redação sobreposta; semanal com marcação de mês). Setas de dependência foram testadas e **removidas** (ficaram ruins) — decisão do Matheus.

**Pendências do cap. 6 `.tex` (só Matheus edita) — typos da revisão:**
- L8: `existe poucos messes`→existem poucos meses · `distribuír`→distribuir · "mais unidade/atividade"→plural.
- L21: `são construído`→construídos · `proíbição`→proibição · `da politica`→política.
- L23: `dependencias`→dependências · "tabela…preenchidas"→preenchida.
- L25: `pendulo`→pêndulo · `distribuíções`→distribuições · `dispobinilidade`→disponibilidade · `está previsto`→prevista.
- L27: `serão realizados o objetivo 7`→será realizado · `pronlongando`→prolongando · `ocorreram`→ocorrerão · `as distribuição`→as distribuições · `cliclos`→ciclos · `quatificado`→quantificado · `veridito`→veredito · `variáveis de confusões`→de confusão · "mês…no mês" repetido.
- L29: **`A estrica`→A escrita** (o mais visível de todos).
- **Coerência:** L29 "1 mês para cada implementação (C e Rust)" (sequencial) × L25 "em paralelo em simulação" — alinhar a redação.
- Já corrigido por ele nesta sessão: `\#` do `forbid` (build ok), início 1/set (some a contradição com agosto), granularidade semanal declarada, prazo como meta (bate com o fecho), frase do marco do Obj. 4 desembolada.

**Oferecido, NÃO feito:** registrar `plan/cap_6_cronograma.md` (datas + dependências + marcos das atividades) como andaime/rastro.

---

## Cap. 3 (Fundamentação) — núcleo 3.3+3.4 ESCRITO (labels + passe + cites pendentes) [02/ago]
Arquivo `capitulos/fundamentacao.tex` (renderiza **cap. 2** no PDF; `% 3.x` = legado). Escopo (replan 20/jul): só **3.3** + **3.4** no nível do núcleo; 3.1/3.2/3.5/3.6 = parágrafos curtos. **Núcleo 3.3+3.4 ESCRITO — conteúdo fechado em todas as subseções (cada uma passou por revisão de banca até fechar).** Falta: (1) labels, (2) passe de forma, (3) citações do 3.4.

### Progresso — seções 3.3 e 3.4 (todas ESCRITAS, conteúdo fechado)
- **3.3.1 Contextos** (`subsec:contexts`) — ESCRITA + citada. Commitada.
- **3.3.2 Modelo de memória + def. data race** (`subsec:dr-def`) — ESCRITA + citada (`d6626a0`). Fecho ajustado nesta linha: "contido dentro de" → "se sobrepõe a" RC (topologia mais honesta).
- **3.3.3 Data race × race condition** (`subsec:data-race-x-race-condition`) — **ESCRITA**, conteúdo fechado (banca), commitada (`20cb41d`). Cites: `article:netzer-miller-races` (def. RC + assimetria), `article:bishop-dilger-toctou` (TOCTOU), `article:rust-safe-soundness` (Rust safe). Exemplo blindado = flag de emergência + PWM (RC sem DR: tudo atômico → cláusula 4 falha).
- **3.4.1 Propriedade e empréstimo** (`subsec:types_guarantee` — **CRIADO** ✅) — **ESCRITA**, conteúdo fechado. Regra única = exclusividade de mutabilidade (2 faces: ownership + borrow) + garantia temporal (lifetime); elimina UAF/dangling/double-free/iterator-invalidation em compile-time.
- **3.4.2 safe/unsafe + Send/Sync** (`subsec:send-sync-safe-unsafe`) — **ESCRITA**, conteúdo fechado. Send/Sync (marker/auto traits, contaminação para cima), Rc/copropriedade → interior mutability (Cell/RefCell), 4 combinações Send×Sync, 5 superpoderes do unsafe, confinamento + distinção hardware×sincronização.

**Citações do 3.4 — PENDENTES:** 3.4.1 e 3.4.2 estão **sem `\cite`** ainda. Recomendado: `article:rust-safe-soundness` (já no `.bib`) para a soundness. Send/Sync e os 5 superpoderes do unsafe: **Rustonomicon + Rust Reference** (Regra 7 — Matheus traz keywords, a triar).

`.bib`: **+2** — `article:netzer-miller-races`, `article:bishop-dilger-toctou` (metadados confirmados em fonte primária, commit `7a1d315`). Fichas em `plan/leitura_futura.md`. Triagem `plan/triagem_referencias.md` rodada 3: **A2 Helmbold & McDowell NÃO escolhido** (segue pendente); A3/A4/B2/B3 pendentes.

### 🔑 LABELS — o que falta (sai `??` até resolver)

| Label que o núcleo espera | Referenciado em | Situação (02/ago) |
|---|---|---|
| `sec:dr-def` | Metodologia l.23, l.29 · Resultados l.144, l.223 | ⚠️ existe como **`subsec:dr-def`** → renomear `\label` (3.3.2) + o `\ref` da 3.3.3 (l.64 usa `subsec:dr-def`) |
| `sec:dr-vs-race` | Metodologia l.23, l.29 | ⚠️ existe como **`subsec:data-race-x-race-condition`** → renomear + o `\ref` da 3.3.2 |
| `sec:send_sync` | §4.3.2 (l.141) | ❌ **CRIAR** na 3.4.2 (bloco Send/Sync, ~l.88) |
| `sec:unsafe` | §4.3 (l.119) | ❌ **CRIAR** na 3.4.2 (bloco unsafe, ~l.90) |
| `subsec:types_guarantee` | §4.3 (2×) | ✅ **CRIADO** (3.4.1 l.62) |
| `sec:prod-cons` | Metodologia l.69, l.71 (4.2.3) | ❌ **sem casa** — decidir onde nasce (produtor-consumidor / P2) |
| `sec:scope` | §4.2.3 (corte single-core) | **PENDENTE:** cap. 1 (delimitação) ou cap. 3 |

Também **na Metodologia:** a l.121 referencia `subsec:types_guarantee` para "UB confinável via unsafe" (conteúdo agora da 3.4.2) → **repontar para `sec:unsafe`**.

Cuidado ao varrer: `cap:fundamentacao` e os `code:*` **não** são órfãos — `\mychapter`/`\coderust`/`\codec` criam o label (`ic.cls`).

### 4 bugs de `\ref` nos caps. 3 e 4 (independem do cap. 3 — consertar no passe)
- `cap:results` (§4.5.1) → o label do cap. Resultados é **`cap:experiment`**.
- `sec:cost-exp-proc` (§4.4.2) → provavelmente **`sec:experiment-proc`**.
- `sec:cost-exp` (§4.4.2) → não existe (a medição é da dissertação) → reescrever a frase.
- `list:eleven-cells` (§4.2.3) → a lista das 11 células é **texto plano** sem ambiente nem `\label`.

### Passe de forma do cap. 3 (Fundamentação) — PENDENTE (conteúdo veio primeiro)
3.3.3, 3.4.1 e 3.4.2 acumularam erros de ortografia/concordância. Recorrentes no 3.4: **`treads`→threads** (termo central), `referencia`→referência, `atomico`→atômico, "todos os tipos... **for**"→forem, `extender`→estender, `valida`→válida, `trais`→traits. + muletas "Note que/Perceba que". Nenhum aplicado.

## Estado do cap. 1 (sessão de 30–31/jul)

### §1.1 Contextualização — FECHADA em argumento, commitada (`f4dc4c0`, `docs:`)
Escrita do zero (arco CARS de 5 blocos). Passou por 6 rodadas de banca; todos os furos de conteúdo fecharam (pergunta de pesquisa neutra com "data races" de volta; MCU/SoC; TSan; contradição §5.2.1 resolvida — veículo amarrado só ao custo; enquadramento Tese A resolvido; lacuna de ferramenta com `\ref{sec:control-repos}`).

**Alavanca ainda NÃO aplicada (opcional):** declarar o *status epistemológico* da Aule (instrumento, não objeto da avaliação).

### §1.2 Objetivos — DIAGNOSTICADA, texto intacto
**Furo principal:** a §1.1 pergunta **2** coisas (fronteira; custo), o objetivo geral promete **3** (inclui "comparar com C+MISRA+sanitizers" = obj. 8/§4.7, sem pergunta que justifique). Decidir: a P2 se abre, ou a comparação de regimes deixa de ser objetivo. Outros: obj. geral em fases; obj. 7 = 5+6; obj. 5 mais estreito que o protocolo (4 dimensões); nenhum objetivo testa a hipótese; levantamento de bibliotecas sem objetivo; lista em texto plano (precisa `enumerate`; `enumitem` não carregado).

### §1.3 Visão Geral da Qualificação — vazia (título já corrigido de "da Dissertação")

## Bibliografia — 7 entradas (commits `698e5f0`, `51a22c9`) + 2 da linha do cap. 3
`book:ogata`, `book:deadline-requirement`, `doc:MISRA`, `doc:TSan`, `article:rust-safe-soundness`, `article:rust-critical`, `url:esp-rust-no-std-stable`; +`article:netzer-miller-races`, `article:bishop-dilger-toctou`.

**Ações pendentes no `.tex` (só o Matheus edita):**
1. `\cite{url:rust-safe-soundess}` → **`article:rust-safe-soundness`** (typo + prefixo). Única citação do cap. 1 que sai `[?]`.
2. **`\cite{article:rust-critical}` mal alocada** (ancora "baixa utilização de recursos", que o paper não sustenta) → mover para a passagem MISRA.

**Pendências bibliográficas:** confirmar edição do **Ogata** (5ª br./2010?) e **Buttazzo** (3ª/2011?); escolher versão do **MISRA**; **DOI do ISSREW** (Xplore 8990314). Não triada: *Rust for Embedded Systems* (CCS 2024). Ver [[citacoes-pendentes]].

## ⚠️ BLOQUEADOR aberto — lista de siglas de OUTRO trabalho
`pre-textuais/LISTA_DE_SIGLAS.tex` declara **11 siglas herdadas do template** (BCC, CCR, CRS, VRS, CVLI, DEA, DMUs, SSP, CISPs, NEAC, DETRAN). Incluída no `main.tex` (l. 55) → **vai impressa**. Nenhuma sigla do trabalho está lá (SoC, MCU, GPIO, UART, SPI, IHM, HAL, MISRA, TSan) e `\ac{}` não é usado. Correção trivial, impacto de vergonha alto.

**Item de 1 minuto:** `preambulo.tex` tem `\dataMesAno{Julho}{2026}` (entrega 7/ago) e examinadores ainda `Dr. Examinador 1`/`Examinador 2`.

## Erros sistemáticos — busca-e-substitui global
| Errado | Certo | Ocorrências |
|---|---|---|
| `expremí…` / `inexpremí…` | exprimível / inexprimível | **14** (termo central!) |
| `ecosistema` | ecossistema | 6 |
| `algorítmo` | algoritmo | 6 |
| `fonteira` | fronteira | 3 |
| `reune` | reúne | 3 |
| `sanitazers` | sanitizers | 2 |
| `despresí…` | desprezível | 1 |

A §1.1 tem ~35 itens de forma listados (acentos, vírgulas sujeito-verbo, aspas retas + `\textbf`, "utilizar ela", "da esp32" vs "do ESP32", muleta "Note que/Perceba que"). **Nenhum aplicado.**

## Caps. 3 (Metodologia) e 4 (Resultados) — COMPLETOS
Só passe de forma. Cap. 3: 6 `\cite{}` vazios (5 na 4.4.1 + 1 na 4.6.3) + **tabela TODO na §4.3.3**. `\cite{rust-safe-soundness}` (4.3.2 l.143) sem prefixo `article:` → verificar. Enviar caps. 3 e 4 ao Icaro — segue sem confirmação.

## Prazo
**Entrega à banca: sex 7/ago/2026** (autoimposta; regimento 11/ago). **Defesa: qua 26/ago.** Restam (após 04/ago): **noites 05–06/ago (typos cap. 6 + labels/passe cap. 3 + cap. 1.2/1.3 + pré-textuais + revisão) + manhã de 07/ago (passe final + entrega).** Cap. 2 e cap. 7 cortados.

**⚠️ ATUALIZAÇÃO 10/ago:** ele informou a **qualificação em 21/ago/2026** (antes constava defesa 26/ago — provável remarcação; **confirmar**). Restam ~11 dias, e a prioridade declarada nesta data é **ler tudo o que o `.tex` cita** antes da banca.

## Leituras para a banca (10/ago)
Pasta `leituras/` criada (não versionada; `.gitignore` deixa passar só `leituras/README.md`, que é o mapa: 32 chaves citadas × cópia local × onde cada obra é citada, com a numeração real do `.tex`). Estado ao fim de 10/ago: **faltam 2** — **Buttazzo** (download incompleto) e **Stallings** (o PDF baixado é só a capa, 8ª ed.). **Ogata, Wazlawick e MISRA C:2012 ficaram FORA do escopo por decisão dele** (lê depois da banca). `eriksson2013rtfm` resolvido (ele baixou). `furuta-plant` é repo privado — nada a ler. **Pendência de `.bib`:** as cópias de Buttazzo/Stallings parecem ser edições **antigas** (Buttazzo scan PDF 1.3; Stallings 8ª ed.) ≠ 3ª/2011 e 11ª/2021 do `.bib` — conferir ao ler.

## Git — atenção
Verificar se o local está atrás de `origin/main` (`git pull`/fast-forward) **antes** de novos commits, para não divergir. `refs/` aparece untracked (ruído do ambiente — fora dos commits). `res/cronograma/` **não** está no `.git/info/exclude` (ao contrário de `res/intro/`) → o `gantt.png` é versionável.

## Workflow desta linha (manter)
Roteiro por seção (skill `roteiro-academico`: imagem + 6 campos) → Matheus escreve → "verifique" (banca, sem mercê) → aponta furos → aplica → "verifique novamente" até fechar → commit. Bibliotecário para buscas (Regra 7: ele dá keywords, Claude busca/classifica, ele decide). Ver [[review-checklist-enforce]] e [[roteiro-explicacao-didatica]]. Ao discordar de um apontamento, ele contesta — conceder o que é dele e manter o que se sustenta.
