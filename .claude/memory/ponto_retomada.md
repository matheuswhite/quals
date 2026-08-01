---
name: ponto-retomada
description: "PROGRESSO 01/ago (cap. Fundamentacao, fundamentacao.tex; renderiza cap. 2 no PDF, '% 3.x' legado): secao 3.3 PODADA 5->3 subsecoes. 3.3.1 contextos (label subsec:contexts) ESCRITA+4 cites; 3.3.2 modelo de memoria+def. data race (label subsec:dr-def) ESCRITA+4 cites, todos furos de revisao fechados; 3.3.3 data race x race condition (label subsec:data-race-x-race-condition) = ROTEIRO pronto, A ESCREVER. 3.4 Rust (2 subsecoes) NAO escrita. .bib +3: book:lee-seshia, book:stallings, doc:c11 (N1570). FALHA A CORRIGIR (ref invalida): labels criados nao batem com o nucleo -> renomear subsec:dr-def para sec:dr-def (4 refs cap4/5) e subsec:data-race-x-race-condition para sec:dr-vs-race (2 refs cap4); sec:prod-cons (2 refs em 4.2.3) e os labels do 3.4 (sec:send_sync/sec:unsafe/subsec:types_guarantee) ainda sem casa. Pendencia 3.3.3: refs Helmbold&McDowell 1996 + Netzer&Miller 1992 (Matheus traz, Regra 7). Cap.1 1.1 FECHADA (f4dc4c0); 1.2 diagnosticada; 1.3 vazia. BLOQUEADOR: LISTA_DE_SIGLAS de outro trabalho. Entrega 7/ago; defesa 26/ago."
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
  type: project
  originSessionId: bfd04e9d-3381-42a2-bac3-e70b75a64a40
---

**Ponto de retomada — sessão de 01/ago/2026 (sábado). Cap. Fundamentação em andamento.**

## ⏭️ PRÓXIMO PASSO — escrever a 3.3.3, depois a 3.4

Arquivo `capitulos/fundamentacao.tex` (renderiza **cap. 2** no PDF; `% 3.x` = legado). Escopo (replan 20/jul — não reabrir): só **3.3** + **3.4** no nível do núcleo; 3.1/3.2/3.5/3.6 = parágrafos curtos. 3.3/3.4 são intocáveis (a banca fura aqui).

### Progresso 01/ago — seção 3.3 (podada 5→3 subseções)
- **3.3.1 Contextos de execução concorrente** (`subsec:contexts`) — **ESCRITA + citada** (`book:lee-seshia` ISR, `book:stallings` DMA, `book:deadline-requirement` escalonador, `eriksson2013rtfm` região crítica). A commitar `docs:`.
- **3.3.2 Modelo de memória e a definição de data race** (`subsec:dr-def`) — **ESCRITA + citada**; absorveu happens-before+C11+Rust; furos de revisão fechados (happens-before definido+mecanismos, atomicidade, `enumerate`, "cláusulas 3 e 4" reformulado, C11=padrão, modelo Rust escopado a atômicos). Cites: `boehm2008foundations`+`adve2010memory`, `boehm2008foundations` (h-b), `doc:c11` (def.+UB), `article:rust-safe-soundness` (Rust). A commitar `docs:`.
- **3.3.3 Data race × race condition** (`subsec:data-race-x-race-condition`) — **ROTEIRO pronto, A ESCREVER.** Estrito×amplo; Rust elimina data race, NÃO race condition (eixo 4); caso crítico = race condition sem data race (check-then-act/TOCTOU atômico); fecha justificando o recorte de 4.2.1. **Pendência (Regra 7 — Matheus traz):** Helmbold & McDowell (1996) + Netzer & Miller (1992), fora do `.bib`. Cuidado: o fim da 3.3.2 diz DR "contido dentro de" RC — relação debatida; apoiar na **assimetria**.
- **3.4 Rust (tipos)** — 2 subseções (`Propriedade e emprestimo`; `safe e unsafe na troca de dados entre threads`) — **NÃO escritas.**

`.bib`: **+3** — `book:lee-seshia`, `book:stallings`, `doc:c11` (N1570 §5.1.2.4). Triagem em `plan/triagem_referencias.md` (rodadas 1–2, lista definitiva). Yiu (ARM) descartável (alvo = Xtensa).

### 🔑 FALHA ABERTA — labels criados NÃO batem com o que o núcleo referencia (sai `??`)

| Label que o núcleo espera | Referenciado em | Situação (verificado 01/ago) |
|---|---|---|
| `sec:dr-def` | Metodologia l.23, l.29 · Resultados l.144, l.223 | ⚠️ criado como **`subsec:dr-def`** (3.3.2 l.21) → **renomear** l.21 `\label` + l.17 `\ref` → `sec:dr-def` |
| `sec:dr-vs-race` | Metodologia l.23, l.29 | ⚠️ criado como **`subsec:data-race-x-race-condition`** (3.3.3 l.46) → **renomear** l.46 `\label` + l.42 `\ref` → `sec:dr-vs-race` |
| `sec:prod-cons` | Metodologia l.69, l.71 (poda das células, 4.2.3) | ❌ **sem casa** — decidir onde nasce em 3.3 (produtor-consumidor / P2) |
| `sec:send_sync` | §4.3.2 | 3.4 (a escrever) |
| `sec:unsafe` | §4.3 | 3.4 (a escrever) |
| `subsec:types_guarantee` | §4.3 (2×) | 3.4 (a escrever) |
| `sec:scope` | §4.2.3 (corte single-core) | **PENDENTE:** cap. 1 (delimitação) ou cap. 3 |

Cuidado ao varrer: `cap:fundamentacao` e os `code:*` **não** são órfãos — `\mychapter`/`\coderust`/`\codec` criam o label (`ic.cls`).

### 4 bugs de `\ref` nos caps. 3 e 4 (independem do cap. 3 — consertar no passe)

- `cap:results` (§4.5.1) → o label do cap. Resultados é **`cap:experiment`**.
- `sec:cost-exp-proc` (§4.4.2) → provavelmente **`sec:experiment-proc`**.
- `sec:cost-exp` (§4.4.2) → não existe (a medição é da dissertação) → reescrever a frase.
- `list:eleven-cells` (§4.2.3) → a lista das 11 células é **texto plano** sem ambiente nem `\label`.

## Estado do cap. 1 (sessão de 30–31/jul)

### §1.1 Contextualização — FECHADA em argumento, commitada (`f4dc4c0`, `docs:`)
Escrita do zero a partir do roteiro (arco CARS de 5 blocos: território → concorrência imposta → C/MISRA/sanitizers e seu teto → Rust desloca a garantia + as duas incógnitas → perguntas). Passou por **6 rodadas de revisão em papel de banca**; todos os furos de conteúdo fecharam, incluindo:
- pergunta de pesquisa neutra (era enviesada), **com o objeto "data races" de volta** e com hierarquia declarada ("Respondida a pergunta anterior…"); conector de lacuna ("Com essas lacunas apontadas") em vez de "Portanto";
- erro conceitual MCU/SoC corrigido; "sanitizers não rodam em embarcado" qualificado para TSan; causalidade RISC suavizada; "alguns kilobytes" → centenas (contradizia o ESP32 do experimento);
- **contradição com a §5.2.1 fechada**: o veículo agora está amarrado só ao **custo**, não à investigação da fronteira (a fronteira do P1 foi sondada deliberadamente **sem** a Aule);
- **risco de enquadramento Tese A** resolvido: a nominalização "foi necessário a construção" virou "a biblioteca Aule foi construída" (sujeito = a lib, não o ato). *Discussão registrada: a reordenação do parágrafo (pôr a Aule antes) é impossível — a cadeia é necessidade → ausência → construção; e a l. 13 já retoma as lacunas antes das perguntas.*
- **lacuna de ferramenta** declarada + `\ref{sec:control-repos}` (responde "cadê os trabalhos relacionados?", já que o cap. 2 foi cortado). A Aule é apresentada na intro pela 1ª vez.

**Alavanca ainda NÃO aplicada (opcional, decisão do Matheus):** declarar o *status epistemológico* da Aule (instrumento, não objeto da avaliação) — é a resposta antecipada a "então sua contribuição é a biblioteca?". Padrão já existe no §5.2.1 e no §4.5.2.

### §1.2 Objetivos — DIAGNOSTICADA, texto intacto (segue o rascunho original)
**O furo principal (novo, criado pelo fecho da 1.1):** a §1.1 pergunta **2** coisas (fronteira; custo) e o objetivo geral promete **3** — inclui "comparar com o estado da arte em C+MISRA+sanitizers", que é o **obj. 8** e a **§4.7 inteira**, e não tem pergunta que o justifique. Distinção útil: o custo (quantitativo, §4.6) já está embutido na P2 porque custo é relativo a uma linha de base; o **regime de verificação** (qualitativo, §4.7 — momento/natureza/esforço/fronteira) é que está órfão. Decidir: a P2 se abre, ou a comparação de regimes deixa de ser objetivo próprio.

Outros pontos levantados: objetivo geral está em **fases** e não subsome (o obj. específico 2 o repete literalmente) — o verbo do título, "**mapear**", resolve; `\subsection` deveria ser singular; **obj. 7 = obj. 5 + obj. 6** (e o §4.1 mapeia os três a uma só seção); **obj. 5 é mais estreito que o protocolo** (§4.6.3 mede 4 dimensões — runtime, determinismo, footprint, ergonomia; footprint e ergonomia não aparecem em objetivo nenhum); **nenhum objetivo testa a hipótese** (que a §5.3 enuncia); **o levantamento de bibliotecas não corresponde a objetivo nenhum** apesar de ocupar uma seção do cap. Resultados; tempo verbal errado ("objetivos 1–3 **serão** desenvolvidos" — já foram); falta declarar o **critério** da divisão qualificação/pós-qual (é o exploratório→empírico do §4.1); a lista está em **texto plano** (precisa `enumerate` + `\label`; `enumitem` NÃO está carregado → `[resume]` exige adicioná-lo, ou usar `\setcounter{enumi}{3}`).

### §1.3 Visão Geral da Qualificação — vazia (título já corrigido de "da Dissertação")

## Bibliografia — 7 entradas novas (commits `698e5f0`, `51a22c9`)
`book:ogata`, `book:deadline-requirement` (Buttazzo), `doc:MISRA`, `doc:TSan`, `article:rust-safe-soundness` (Jung et al., CACM 2021), `article:rust-critical` (Pinho et al., ISSREW 2019), `url:esp-rust-no-std-stable` (Mabin, esp-hal 1.0.0-beta, fev/2025). Metadados confirmados em fonte primária; fichas de leitura em `plan/leitura_futura.md` (seção nova).

**Ações pendentes no `.tex` (só o Matheus edita):**
1. `\cite{url:rust-safe-soundess}` → **`article:rust-safe-soundness`** (typo + prefixo errado). É a única citação do cap. 1 que ainda sai `[?]`.
2. **`\cite{article:rust-critical}` está mal alocada**: ancora "baixa utilização de recursos", que o paper não sustenta (ele mapeia guidelines MISRA que o Rust dispensa). Mover para a passagem sobre MISRA; para a alegação de recursos, buscar outra fonte.

**Pendências bibliográficas:** confirmar edição consultada do **Ogata** (assumi 5ª br./2010) e do **Buttazzo** (assumi 3ª/2011); escolher a **versão do MISRA** (C:2012 · Third Ed. First Revision 2019 · C:2023) e ver se alguma regra trata de concorrência; pegar o **DOI do ISSREW** (Xplore doc. 8990314). Sugestão não triada: *Rust for Embedded Systems: Current State and Open Problems* (CCS 2024), para dar peso peer-reviewed ao "por que agora".

## ⚠️ BLOQUEADOR aberto — lista de siglas de OUTRO trabalho
`pre-textuais/LISTA_DE_SIGLAS.tex` declara **11 siglas herdadas do template** (BCC, CCR, CRS, VRS, **CVLI** = Crime Violento Letal Intencional, **DEA** = Análise Envoltória de Dados, DMUs, **SSP** = Secretaria de Segurança Pública, CISPs, NEAC, **DETRAN**). Está incluída no `main.tex` (l. 55) → **vai impressa na entrega**. Nenhuma sigla do trabalho está lá (SoC, MCU, GPIO, UART, SPI, IHM, HAL, MISRA, TSan) e `\ac{}` não é usado em nenhum capítulo. Correção trivial, impacto de vergonha alto.

**Outro item de 1 minuto:** `pre-textuais/preambulo.tex` tem `\dataMesAno{Julho}{2026}` (entrega é 7/ago) e os examinadores ainda são `Dr. Examinador 1` / `Examinador 2`.

## Erros sistemáticos — busca-e-substitui global (~35 correções, minutos)
| Errado | Certo | Ocorrências |
|---|---|---|
| `expremí…` / `inexpremí…` | exprimível / inexprimível | **14** (termo central da tese!) |
| `ecosistema` | ecossistema | 6 |
| `algorítmo` | algoritmo | 6 |
| `fonteira` | fronteira | 3 |
| `reune` | reúne | 3 |
| `sanitazers` | sanitizers | 2 |
| `despresí…` | desprezível | 1 |

Além disso, a §1.1 tem ~35 itens de forma listados na sessão (acentos, vírgulas separando sujeito de verbo, "É nesta linguagem, cujos HALs" agramatical, aspas retas + `\textbf` onde devia ser itálico, "utilizar ela", "da esp32" vs "do ESP32", muleta "Note que/Perceba que"). **Nenhum aplicado ainda** — a escolha foi correta: conteúdo primeiro.

## Caps. 3 (Metodologia) e 4 (Resultados) — COMPLETOS
Só passe de forma. Cap. 3: 6 `\cite{}` vazios (5 na 4.4.1 + 1 na 4.6.3 firmware) + **tabela TODO na §4.3.3** (lacuna de conteúdo, não de forma). Cap. 4: pendências de ortografia da §4.1 já listadas. Enviar caps. 3 e 4 ao Icaro — a "ação urgente" do roadmap segue **sem confirmação de que foi feita**.

## Prazo
**Entrega à banca: sex 7/ago/2026** (autoimposta; regimento 11/ago). **Defesa: qua 26/ago.** Restam: **sáb 01/ago (cap. 3) + noites 03–06/ago (cap. 1.2/1.3, cap. 5 Cronograma, pré-textuais, revisão) + manhã de 07/ago.** Cap. 2 e cap. 7 cortados.

## Workflow desta linha (manter)
Roteiro por seção (skill `roteiro-academico`: imagem + 6 campos) → Matheus escreve → "verifique" (banca, sem mercê) → aponta furos → aplica → "verifique novamente" até fechar → commit. Papel bibliotecário para buscas (Regra 7: ele dá as keywords, Claude busca e classifica, ele decide). Ver [[review-checklist-enforce]] e [[roteiro-explicacao-didatica]]. Ao discordar de um apontamento, ele contesta — conceder o que é dele e manter o que se sustenta (aconteceu hoje nas "alavancas" de enquadramento).
