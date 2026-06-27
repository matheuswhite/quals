---
author: Claude (claude-opus-4-8)
created: 2026-06-04
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-11
  - Claude (claude-opus-4-8), 2026-06-13
  - Claude (claude-opus-4-8), 2026-06-14
  - Claude (claude-opus-4-8), 2026-06-15
  - Claude (claude-opus-4-8), 2026-06-21
  - Claude (claude-opus-4-8), 2026-06-26
---

<!-- LTeX: enabled=false -->

# Esqueleto do Cap. 4 — Metodologia Proposta

Outline de planejamento (Regra 4): descreve **o que cada seção precisa responder** e **as decisões a tomar** — não contém prosa da tese. Companheiro de [`outline_geral.md`](outline_geral.md) (visão de todos os capítulos) e [`roadmap_escrita.md`](roadmap_escrita.md) (quando escrever).

## Por que reorganizar (contexto da decisão de 2026-06-04)

A estrutura herdada do `.tex` (Requisitos → Arquitetura → Implementação → Validação → Critérios) descreve *como construir a biblioteca* — coerente com o enquadramento antigo (Aule = objeto central). Sob o **título novo** (fronteira de segurança + custo de data races; Aule = veículo) e os **8 objetivos** da §1.2, os objetivos da qualificação (1–3) são de **caracterização/análise**, não de construção — e a estrutura herdada **não tem seção para eles**.

A reorganização mapeia **método ↔ objetivo (1-pra-1)** e separa qualificação (obj 1–3, em execução, detalhados) de pós-qualificação (obj 4–8, apresentados como protocolo/plano).

| Seção | Objetivo | Fase | Natureza |
|---|---|---|---|
| 4.1 Caracterização da pesquisa | — (enquadra) | — | meta |
| 4.2 Método: taxonomia de padrões de data race | 1 | **qualificação** | analítica |
| 4.3 Método: caracterização da fronteira safe/unsafe | 2 | **qualificação** | analítica / por construção |
| 4.4 Método: catalogação do espaço de design | 3 | **qualificação** | analítica |
| 4.5 A Aule como veículo de instanciação | 4 | pós-qual | construção (plano) |
| 4.6 Protocolo do experimento de custo | 5–7 | pós-qual | experimental (protocolo) |
| 4.7 Protocolo: verificação por tipos vs C+MISRA | 8 | pós-qual | qualitativo (protocolo) |

> O **ponto-de-virada** (forward/`Signal`) **migra** para 4.5 (decisão de design do veículo) — deixa de ancorar 4.1–4.3, como previa o roadmap antigo. A âncora da qualificação passa a ser a fronteira + o espaço de design.

### Decisão estrutural — a fase exploratória entrega os resultados DENTRO do cap. 4 (Arquitetura B, fechada 2026-06-11)

A fase exploratória (obj 1–3) **entrega seus resultados no próprio cap. 4**: a taxonomia (4.2.3), o mapa da fronteira (4.3) e o catálogo do espaço de design (4.4) são *resultados analíticos* apresentados **junto ao método que os produz** — porque, em pesquisa exploratória, a construção conceitual é inseparável do raciocínio que a gera. O **cap. 5** fica com os resultados *materiais*: casos demonstrativos (código compila/não-compila), estado da Aule, protocolo. **Linha de corte:** resultado conceitual (cap. 4) × resultado material/artefato (cap. 5). *(Alternativa descartada por ora — Arquitetura A: todos os entregáveis no cap. 5.)*

> **⚠️ LEMBRETE / TODO (Matheus) — ao redigir/revisar:**
> 1. **Ajustar o verbo da 4.1.** O trecho já escrito — *"a seção 4.2 aborda **como deve ser realizada** a taxonomia"* — fala só de **método**; precisa refletir que a 4.2 **realiza e entrega** a taxonomia (idem 4.3/4.4 entregam fronteira/catálogo). Hoje há leve incoerência método × resultado.
> 2. **Tornar explícito** (na 4.1 ou na abertura da 4.2) que, por ser pesquisa **exploratória**, o resultado analítico é apresentado no capítulo de método — isso **antecipa a objeção de banca** "por que um resultado está na metodologia?".
> 3. **Validar com o Icaro:** neste programa, construções conceituais (taxonomia/framework) vão em Metodologia ou em Resultados? Barato perguntar; caro descobrir na defesa.
>
> **Reversível:** se depois optar pela Arquitetura A, é *recortar e realocar* a 4.2.3 (e equivalentes) para o cap. 5 — **não** reescrever.

---

### Decisão (2026-06-15) — migração de plataforma: Cortex-M0/ARMv6-M → ESP32 Xtensa dual-core

**O quê:** o alvo de HW passa a ser **ESP32** (Xtensa LX6/LX7, dual-core). **Multi-core/SMP fica fora do escopo de toda a dissertação** por decisão deliberada (reduz complexidade).

**Multi-core = restrição declarada, não fato de HW.** Como o chip tem 2 núcleos, "não ocorre no HW" não cola mais. Tornar single-core uma **condição operacional real** (confinar o controle a 1 núcleo; o outro fica fora do escopo). Justificar o corte com: (1) regime de memória qualitativamente distinto (coerência de cache, ordenação) → pediria um eixo novo; (2) garantias dos 4 padrões teriam de ser re-derivadas sob paralelismo real; (3) custo single-core ≠ custo SMP; (4) escopo de qualificação → multi-core é cap. 6 (trabalho futuro).

**Custo (ponto crítico) — re-centrar do P4 para o P3.** O gancho ARMv6-M (sem LDREX/STREX → seção crítica) **enfraquece** no Xtensa (tem `S32C1I` → provável CAS atômico). Mover o peso do argumento de custo para o **P3** (agregado multi-palavra com invariante: nenhuma ISA tem atômico desse tamanho → exclusão mútua ou snapshot/publicação obrigatória → custo **ISA-independente**). Reframe geral: em safe Rust **não dá pra *não* sincronizar**; em C dá (e o bug nasce daí). O P4/ARMv6-M vira **ilustração** de uma classe de MCUs (ARMv6-M, RISC-V sem ext. A) — honesto que a placa-alvo provavelmente tem atômico. Efeito bom: o custo deixa de depender de um detalhe de um chip → menos atacável.

**Ripple (o que muda nos docs/`.tex`):** pergunta de pesquisa (obj 5 nomeia "Cortex-M0" → re-redigir; F12 reabre em [`banca_pergunta_pesquisa.md`](banca_pergunta_pesquisa.md)); 4.1 (alvo + restrição single-core); 4.2.2 (eixo 1 "Núcleo-Núcleo" mantido visível, cortado à vista); 4.2.3 (P7 = restrição declarada, não "fato de HW"); 4.4.2 (custo re-centrado no P3); 4.6 (plataforma + `CCOUNT` no lugar do DWT); 3.2 ([`cap_3_fundamentacao.md`](cap_3_fundamentacao.md): LL/SC genérico + Xtensa).

**Pendências a confirmar (não afirmar sem fonte):** atômicos do Xtensa na config do ESP32 (`S32C1I`; o que `core::sync::atomic`/`portable-atomic` cobrem nativo × fallback) — **decide quão fraco fica o P4**; registrador de ciclos do ESP32 (`CCOUNT`) p/ medir overhead; suporte de HAL da Aule a ESP32 (`../aule`).

**Off-ramp registrado:** uma variante **single-core sem extensão atômica** (ex.: ESP32-C3, RV32IMC) preservaria o gancho de custo **e** o single-core como fato de HW (menor disrupção) — não adotada por opção pela plataforma dual-core.

---

## 4.1 Caracterização da Pesquisa

**Perguntas que a seção responde:**
- Que tipo de pesquisa é (aplicada? básica?) e qual a abordagem?
- Quais são os **dois produtos** distintos da metodologia e como se separam: (a) caracterização analítica da fronteira + espaço de design (obj 1–3, qualificação); (b) avaliação experimental de custo + comparação de verificação (obj 4–8, pós-qual)?
- Que **natureza de evidência** cada produto gera? (por construção / "compila vs. não-compila" nos obj 1–3; numérica / ciclos e deadlines nos obj 5–8; qualitativa-comparativa no obj 8)
- Onde termina a qualificação e começa a pós-qualificação (linha obj 3 | obj 4)?

**Decidido (2026-06-04; classificação REVISADA em 2026-06-05 — ver nota de correção abaixo):** na taxonomia de tipos de pesquisa em computação de Wazlawick (`wazlawick2009metodologia`, §2.6 — três tipos: formal / empírica / exploratória), a pesquisa é **exploratória-empírica**, em **sequenciamento** (não duas pesquisas disjuntas):
- **exploratória** na qualificação (obj 1–3) — taxonomia, fronteira, espaço de design: área emergente, organização conceitual, casos como instrumento de argumentação;
- **empírica + experimental** na dissertação (obj 5–8) — implementação/medição/comparação. Experimental no sentido do §3.4.2 (manipula a variável "implementação"); em vocabulário do §3.4.5: variável **independente** = implementação (Rust+RTIC vs. C+FreeRTOS+MISRA), **dependentes** = ciclos/iteração e perdas de deadline;
- **não é "formal"** — não há prova de teorema; a fronteira "compila/não-compila" toca numa propriedade formal do sistema de tipos, mas o método é observar o compilador, não demonstrar.

Explicitar que a **qualificação cobre a fase exploratória + o *desenho* da empírica** (o experimento ainda não roda). Substitui o "experimental e quantitativa" do `.tex` herdado.

> **Nota de correção (2026-06-05):** a classificação anterior ("aplicada / mista / exploratória-**descritiva** / bibliográfica + experimental") era da tradição do **Gil** (ciências sociais), **não** do Wazlawick — a única referência metodológica no `.bib`. Substituída pelo vocabulário do Wazlawick (CC). **Defesa-chave:** Wazlawick chama a pesquisa exploratória de a "mais arriscada" (aceitação não-universal), defensável só com **teoria boa + casos** → reforça ancorar a taxonomia (obj 1) no modelo de memória C11/Rust + literatura (cf. F7). Não é preciso adquirir Gil/Creswell: o Wazlawick cobre taxonomia (§2.6) + maquinário experimental (§3.4).

### Estado da redação da 4.1 (5/jun) — pendências e expansão

> Diagnóstico do 1º parágrafo já redigido no `.tex` (classificação exploratória-empírica, citando §2.6). Guia para a próxima passada de escrita. **Não é prosa para colar** — são tópicos a cobrir (Regra 4); a redação é do Matheus (Regra 1).

**Erros mecânicos a corrigir (Claude não toca no `.tex` — Regra 3; Matheus aplica):**
- `carater` → caráter.
- `e Empírico pois` → `Empírico, pois` (vírgula; mantém o paralelo com "Exploratório, pois").
- `incluíndo` → incluindo (sem acento).
- `(descrito em mais detalhes em 4.6)` → concordância: `descritos` (refere "objetivos") ou "o que é detalhado em 4.6".
- Dois `pois` colados ("Empírico pois… pois buscam") → reformular um deles.
- `Onde a fundamentação… em 4.2;` quebra o paralelismo Exploratório↔Empírico → tratar o forward-pointer do 4.2 como parêntese, igual ao 4.6 (ex.: "(aprofundada em 4.2)").
- `todas as fases` → "ambas as fases" (só há duas: exploratória e empírica).

**Expansão — cardápio priorizado (tamanho vem de substância, não de enchimento):**

| Prioridade | Tópico a adicionar | Onde vive o detalhe |
|---|---|---|
| Alta | Definir o que Wazlawick entende por **exploratória** (argumentação/convencimento; área emergente) e **empírica** (comparação por testes aceitos / métodos estatísticos) — §2.6. Hoje os rótulos são invocados sem definição. | aqui (4.1) |
| Alta | **Natureza da evidência** de cada fase: exploratória = "compila vs. não-compila" (o tipo recusa o data race); empírica = ciclos/deadlines medidos. | aqui (4.1) |
| Alta | **Parágrafo-mapa de fecho:** mapeamento método↔objetivo (4.2→obj 1; 4.3→obj 2; 4.4→obj 3; 4.5→obj 4; 4.6→obj 5–7; 4.7→obj 8). | aqui (4.1) |
| Média | **Objeto + instrumentos:** casos demonstrativos = instrumentos de evidência (não "estudo de caso" à la Yin); Aule = veículo. Só frase de enquadramento. | 1 frase aqui; grosso em 4.5 |

**Não colocar na 4.1 (senão duplica e fere o método-por-objetivo):**
- variáveis independente/dependente + métricas → 4.6;
- definição dos padrões de data race → 4.2;
- forward composition / política de `unsafe` → 4.5;
- limitações extensas → seção própria (Wazlawick §3.7 trata "Limitações" à parte).

**Estrutura-alvo (~3 parágrafos):** P1 classificação + sequenciamento + linha qualificação|dissertação (✓ feito) · P2 definição dos dois tipos + natureza da evidência · P3 mapa método↔objetivo.

---

## 4.2 Método: Taxonomia de Padrões de Data Race (obj 1)

**Perguntas que a seção responde:**
- O que delimita um "padrão de data race em controle concorrente"? (estado mutável compartilhado entre ≥ 2 contextos de execução de um algoritmo de controle)
- Quais os **contextos de execução** relevantes no domínio embarcado? (ISR ↔ tarefa; DMA ↔ tarefa; tarefas RTOS em prioridades distintas; núcleos distintos em multi-core)
- **De onde** os padrões são levantados? (fontes: literatura de controle embarcado; padrões canônicos de concorrência produtor-consumidor; os casos demonstrativos do cap. 5; a tabela "classe de bug × onde aparece em controle" de [`rust_memory_safety_em_controle.md`](rust_memory_safety_em_controle.md))
- Qual o **critério de inclusão/exclusão** de um padrão? (precisa: aparecer em algoritmo de controle real **e** ser data race especificamente — não outra classe de memory bug)
- Como a taxonomia é **estruturada**? **Decidido (2026-06-04):** três eixos a cruzar —
  - **par de contextos** (ISR↔tarefa; DMA↔tarefa; tarefa↔tarefa por prioridade; core↔core);
  - **estrutura do dado compartilhado** (escalar/flag — setpoint, modo; buffer/fila — amostras; struct coerente — `x̂`+`P` do estimador);
  - **padrão de acesso** (produtor→consumidor; leitor↔escritor; read-modify-write compartilhado).
  Cada célula relevante = um padrão; os casos do cap. 5 instanciam células específicas.

**Saída (entregável do obj 1):** a taxonomia em si (tabela/figura), pronta para alimentar 4.3.

**Gabarito da matriz (PODA FECHADA — 2026-06-10):** cada linha = um padrão candidato (cruzamento dos 3 eixos). Coluna "Status" = resultado da poda; ✦ = vira caso demonstrativo no cap. 5.

| # | Par de contextos | Estrutura do dado | Padrão de acesso | Exemplo em controle | Status |
|---|---|---|---|---|---|
| P1 | tarefa↔tarefa (comm↔loop) | escalar/flag | leitor↔escritor | setpoint / modo de operação | ✓ entra · ✦ didático |
| P2 | ISR/DMA↔tarefa | buffer/fila | produtor→consumidor | amostras de ADC → loop | ✓ entra · ✦ central |
| P3 | tarefa↔tarefa (estimador↔ctrl) | struct coerente (`x̂`+`P`) | leitor↔escritor / RMW | estado do observador | ✓ entra · ✦ composto |
| P4 | ISR↔tarefa | escalar | RMW (read-modify-write) | contador/acumulador de encoder | ✓ entra (4º padrão) |
| P5 | ISR↔tarefa | flag | leitor↔escritor | flag de emergência / watchdog | → variante de par de P1 — **não nomeada** (Opção A, 2026-06-15) |
| P6 | tarefa↔tarefa | buffer | produtor→consumidor | trajetória planejamento→low-level | → variante de par de P2 — **não nomeada** (Opção A, 2026-06-15) |
| P7 | core↔core | struct/escalar | leitor↔escritor | controlador↔supervisório (multi-core) | ✗ cortado — **restrição de escopo declarada** (SMP/multi-core fora de toda a dissertação; o ESP32 é dual-core → corte deliberado, não "fato de HW" — ver Decisão 2026-06-15) → trabalho futuro |

Critério de inclusão (obj 1): ocorre em controle real **e** é data race (≥2 contextos, ≥1 escrita, sem sincronização garantida). Critério de "vira caso": cobre combinação de eixos distinta + contraste C-vs-Rust didático.

### Nomenclatura fechada (2026-06-10) — 4 padrões

Nomes fixos — citar consistentemente em 4.3 / 4.4 / cap. 5. O **eixo que organiza a taxonomia é a garantia exigida no lado safe**: combinações de eixos que exigem a mesma garantia são o mesmo padrão (ou variante).

| # | Nome fixado | Eixo distintivo | Garantia no lado safe (→ 4.4) |
|---|---|---|---|
| P1 | **Tipo primitivo compartilhado** | leitor↔escritor de dado que cabe na palavra | atomic load/store + ordenação |
| P2 | **Produtor-consumidor** | transferência de itens via fila/buffer | fila SPSC / canal (transfere posse) |
| P3 | **Tipo composto compartilhado** | agregado > palavra + invariante entre campos | exclusão mútua do bloco **ou** snapshot/publicação |
| P4 | **Read-modify-write compartilhado** | atualização não-atômica do mesmo valor | RMW atômico **ou** seção crítica |

- **Variantes de par — NÃO nomear (Decisão 2026-06-15, "Opção A").** Variar **só o par de contexto** mantém a garantia (a garantia é função de estrutura × acesso; o par é transversal) → gera *variante dentro do mesmo padrão*, não padrão novo. Enunciar **uma vez como regra geral**; ilustrar com 1–2 cenários reconhecíveis (flag de emergência ISR↔tarefa → P1; hand-off de trajetória tarefa↔tarefa → P2) **sem** canonizá-los. **Por quê (anti-banca):** entre as células finais há **4** variantes só-de-par — ⟨ISR,Esc,LW⟩, ⟨T↔T,Buf,PC⟩, ⟨ISR,Str,LW⟩, ⟨T↔T,Esc,RMW⟩ — e nomear só 2 (os antigos "P5/P6", herdados da lista pré-matriz) era seleção arbitrária. A regra geral cobre as 4 sem *special pleading* e simplifica a conta (colapso → **4**, sem "+2 variantes").
- **P7** (core↔core) = **restrição de escopo declarada** — SMP/multi-core fora de toda a dissertação por decisão (não mais "fato de HW": o ESP32-alvo é dual-core — ver Decisão 2026-06-15). Tornar single-core uma *condição operacional* (confinar o controle a 1 núcleo); candidato a trabalho futuro (cap. 6).

**Distinção P1 × P3 (granularidade da atomicidade):** P1 = dado cabe na largura atômica → load/store atômico resolve (unidade de acesso = unidade de consistência). P3 = agregado multi-palavra com invariante entre campos → não há atomic desse tamanho → exclusão mútua ou publicação por troca de ponteiro (unidade de consistência > unidade de acesso).

**Distinção P1 × P4 (padrão de acesso):** P1 = leitor↔escritor (um só lê, outro só escreve). P4 = RMW do mesmo valor (lost update); `c += 1` é load→add→store, não atômico. *(O gancho de custo migrou — ver Decisão 2026-06-15: no ESP32 Xtensa o RMW atômico provavelmente existe (`S32C1I`), então o custo se re-centra no **P3** (ISA-independente); o caso "sem RMW atômico → seção crítica" vira ilustração de uma classe de MCUs (ARMv6-M, RISC-V sem ext. A). Pendência: confirmar atômicos do Xtensa.)*

**Alerta de coerência (defesa contra circularidade):** os 3 eixos (par de contexto · estrutura · acesso) são as **dimensões descritivas** (causa); a garantia é o que cada combinação **exige** (consequência, catalogada em 4.4). Direção = eixos → garantia. Tornar isso explícito na 4.2 evita a objeção "a taxonomia é dos eixos ou das soluções?".

**Nota de escopo (honestidade):** a taxonomia é só de **data race** — não cobre OOB, UAF, uninit. **Decidido (2026-06-04):** delay line (Caso 1, OOB/uninit) e MPC workspace (Caso 3, UAF) saem do núcleo — não são data race. Os casos do cap. 5 instanciam células de DR: setpoint escalar (didático/abertura), ISR/DMA→buffer (central), estado composto estimador↔controlador.

> **Formato das subseções 4.2.1–4.2.3 (convenção fixada 2026-06-11):** cada uma traz *Missão · Perguntas que responde · Blocos (em ordem de escrita) · Pontos de defesa · Fronteiras (não invadir) · Apoios/Micro-decisões*. "Blocos" = roteiro de redação na ordem em que escrever; **não é prosa** (Regra 4), a redação é do Matheus (Regra 1).

### 4.2.1 (Método de Levantamento) — estrutura de redação (blocos) (orientação 2026-06-11)

> Consolida a orientação que antes só vivia no ponto de retomada.

**Missão:** estabelecer *o que conta* como padrão de DR e *como* os padrões foram obtidos — **antes** de apresentá-los. Blinda a defensibilidade (a banca cobra "de onde vêm? não é da sua cabeça?").

**Perguntas que responde:** o que é DR (definição operacional); DR × race condition; como os padrões são levantados (método); de onde (fontes); critério de inclusão/exclusão.

> **Revisão (2026-06-14) — peso conceitual migra para o cap. 3.** Ao criar o lar do modelo de memória no cap. 3 (ver [`cap_3_fundamentacao.md`](cap_3_fundamentacao.md), seção 3.3), os blocos 1 e 2 mudam de *ensinar* para *adotar/invocar*. Princípio: **fundamentação explica; metodologia decide/aplica.** A definição formal de DR, happens-before, C11/Rust e a distinção DR×race condition (com Helmbold/Netzer) são **ensinadas em 3.3**; a 4.2.1 só as **usa** via `\ref`. Risco a evitar: se a frase na 4.2.1 começar a explicar happens-before, vazou pro cap. 3.

**Blocos (ordem de escrita):**
1. **Definição operacional de DR** — ~~definir do zero~~ → **adotar o critério**. As 4 cláusulas (≥2 acessos concorrentes ao mesmo endereço · ≥1 escrita · sem happens-before · ≥1 não-atômico) são *ensinadas* em 3.3; aqui faz **recall compacto (1 frase) + `\ref`** e adota como critério operacional de inclusão. A cláusula de atomicidade tem de aparecer no recall (sustenta P1/P4).
2. **DR × race condition** — ~~explicar a distinção~~ → **invocar a distinção pra justificar o recorte**. Movimento de escopo/defesa: a taxonomia é de DR estrito (Seção 3.3), **não** race condition em geral — o Rust mecaniza ausência de DR, não de toda corrida. As refs Helmbold & McDowell (1996) / Netzer & Miller (1992) e a nota histórica **migram para 3.3** (não citar aqui).
3. **Método de levantamento** — os padrões vêm de **dedução estruturada pelos 3 eixos** (4.2.2) + **poda por ocorrência em controle real** (4.2.3). Explicitar que **NÃO é revisão sistemática** da literatura — é dedução do espaço + filtro por domínio. "Representativo, não exaustivo" (coerente com a exploratória da 4.1).
4. **Fontes** — literatura de concorrência embedded/RTOS + modelo de memória C11/Rust + os casos do cap. 5 (+ a tabela "classe de bug × onde aparece em controle" de [`rust_memory_safety_em_controle.md`](rust_memory_safety_em_controle.md)). [Bibliotecário: a busca é sua, Regra 7.]
5. **Critério de inclusão/exclusão (explícito)** — inclui se: ocorre em controle real **E** é data race especificamente. Exclui: outras classes de memory bug (OOB/UAF/uninit — ver Nota de escopo).

> **Decisão (2026-06-13) — o bloco 4 NÃO é bloco autônomo.** Separar duas coisas que o rótulo "Fontes" mistura:
> - **(a) Citações que sustentam uma afirmação específica → diluídas *in situ*:** C11/modelo do Rust no bloco 1 (definição); Helmbold/Netzer no bloco 2 (DR × race); literatura embedded/RTOS dentro do bloco 3 (sustentando "ocorre em controle real"). Citação convence colada à frase que apoia; lista de fontes avulsa numa subseção curta vira corpo estranho.
> - **(b) Declaração de *proveniência da dedução* → fundida no bloco 3, não avulsa.** A defesa do bloco 3 ("dedução + poda, não revisão sistemática") *exige* nomear o material bruto, senão a objeção é "dedução a partir de quê?". "Fontes" aqui é **afirmação metodológica de proveniência** (categorias de fonte), não bibliografia antecipada.
> - **Casos do cap. 5 + tabela `rust_memory_safety…`** = *artefatos de análise próprios*, não literatura externa → mencionar como **entradas da dedução** ("padrões confrontados com os casos"), não como citação, pra não citar-se a si mesmo como autoridade.
> - **Efeito prático:** a 4.2.1 fica com **4 movimentos**, não 5 — definição (1) → distinção (2) → método+proveniência (3+4 fundidos) → critério (5).

**Pontos de defesa:** por que dedução e não revisão sistemática (área emergente + recorte específico de controle embarcado; a revisão sistemática responderia outra pergunta); cada eixo/padrão é rastreável a uma fonte (não "da cabeça").

**Fronteiras (não invadir):** não derivar os eixos em si (4.2.2); não nomear/listar os padrões (4.2.3).

### 4.2.2 (Os Três Eixos) — estrutura de redação (blocos) (orientação 2026-06-11)

> Expande o "Alerta de coerência" acima e formaliza *por que três eixos*.

**Missão:** provar que os 3 eixos são as dimensões **necessárias e independentes** que descrevem um DR no recorte, e que **cruzá-los gera o espaço** dos padrões (cobertura representativa, não exaustiva). Se a banca aceita a 4.2.2, a taxonomia fica de pé. Poda + tabela final = **4.2.3** (não invadir).

**Perguntas que responde:** por que *três* e por que *estes*; necessidade de cada eixo; ortogonalidade; por que não outros eixos; como geram a matriz.

**Blocos (ordem de escrita) — reordenado 2026-06-14 (fusões 1+2 e 3+4; agora 4 blocos):**
1. **Enunciar os três eixos + necessidade de cada um** *(fusão dos antigos blocos 1 e 2 — "enunciar" sozinho era só uma lista + 1 frase de definição, magro demais)*. Enunciar: par de contextos · estrutura do dado · padrão de acesso; definir "eixo" = dimensão descritiva independente de um DR; fixar a tese da seção (necessários, independentes, geram o espaço). Em seguida, a necessidade de cada um (por que importa p/ DR):
   - Eixo 1 — par de contextos: DR exige ≥2 contextos (def. 4.2.1); a natureza do par condiciona quais garantias são aplicáveis (ISR não bloqueia em mutex; DMA não executa código).
   - Eixo 2 — estrutura do dado: decide se há atômico de HW que cobre o dado inteiro (escalar→atomic; agregado multi-palavra c/ invariante→não há; buffer→posse). Granularidade consistência vs. acesso atômico (= distinção P1×P3).
   - Eixo 3 — padrão de acesso: fixados os outros 2, leitor↔escritor ≠ RMW (RMW exige atomicidade da sequência; lost update) (= distinção P1×P4; gancho de custo re-centrado no P3 — ver Decisão 2026-06-15).
   - *(opcional)* adiantar aqui a exclusão **autossuficiente** *"tipo de bug de memória = recorte (4.2.1), não eixo"* para definir por contraste — **só esta**; as outras exclusões dependem do bloco 2 + da trava de direção e ficam no bloco 3.
2. **Independência dos eixos** *(era "Prova de ortogonalidade"; reframe 2026-06-15 — Opção A)* — ⚠️ **separar duas afirmações que NÃO são a mesma** (conflá-las = furo de banca / special pleading):
   - **(a) Ortogonalidade descritiva** — os 3 eixos são coordenadas independentes (nenhuma derivável das outras; toda combinação é descrição válida e distinta). Argumentar **uniforme** para os três; o par é independente por **condicionar o mecanismo realizável** (ISR não bloqueia em mutex; DMA não executa código), **não** por mudar a garantia.
   - **(b) Organização por garantia** — a partição em padrões é mais grossa que a grade de células: a garantia é função de (estrutura × acesso), o par é **transversal** a ela. Ilustrar: varia acesso → P1 atomic × P4 seção crítica; varia estrutura → P1 atomic × P3 mutex/snapshot (a variação **cruza** a partição). Para o par, **não** cruza → variar só o par = variante dentro do padrão (regra geral, Opção A — não nomear).
   - ⚠️ **Não aplicar a régua "varia 1 → a garantia muda" aos três eixos.** Vale p/ estrutura e acesso; **falha** p/ o par (a garantia não muda). Usá-la uniformemente é *special pleading* ("por que o critério do eixo 1 é outro?"). A independência do par defende-se por (a) — não por (b).
3. **Trava de direção + delimitação negativa + completude** *(funde os antigos blocos 3 e 4 — o bloco 2 já cravou o anti-circularidade local ("garantia = testemunha, não critério"), então a trava sozinha ficou magra)*:
   - **Abre travando a direção** (anti-circularidade global): os 3 eixos = causa/descrição (**entrada**); a garantia = **consequência**, catalogada em 4.4. Direção **eixos → garantia**. Generaliza o "testemunha, não critério" do bloco 2 — de *local da prova* para *arquitetura da taxonomia* (classifica-se pelos eixos descritivos, nunca pela garantia).
   - **Delimitações negativas** (banca cobra "por que não X?"), agora todas de pé porque a direção foi travada acima:
     - *"mecanismo de sincronização"* → **consequência, não eixo** (corolário direto da direção — classificar pela solução = circular);
     - *"tipo de bug de memória"* → recorte (4.2.1), não eixo *(se não foi adiantada no bloco 1)*;
     - *"prioridade/preempção"* → absorvido no eixo 1 (bloco 1).
   - ⚠️ **Pergunta de banca a blindar (guardada 2026-06-14) — completude/suficiência dos eixos.** *"Como garantir que esses 3 eixos geram o espaço **completo**, e não só o que vocês imaginaram?"* Distinto de necessidade (bloco 1) e ortogonalidade (bloco 2). Surgiu ao explicar "modelo generativo" na 4.2.1 (a força do generativo depende de os eixos serem as dimensões certas). Linha de defesa: (a) cada eixo **deriva de uma cláusula da definição de DR** (≥2 contextos → eixo 1; granularidade da atomicidade → eixo 2; padrão de acesso → eixo 3) — vêm da definição, não da imaginação; (b) **representativo, não exaustivo** (humildade da 4.1); (c) o filtro de domínio + confronto com casos (4.2.1) são a rede que pega o que a dedução perdeu. **Não alegar completude absoluta** — só *relativa às dimensões da definição de DR*.
4. **Geração da matriz** *(era bloco 6)* — produto cartesiano dos 3 eixos → células = padrões candidatos. Nem toda célula é povoada → aponta p/ critério de inclusão (4.2.1) e **passa o bastão à 4.2.3** (poda). A 4.2.2 mostra o *mecanismo de geração*; **não** lista os 4 padrões finais.

**Fronteiras (não invadir):** não re-derivar def. de DR/fontes (4.2.1); não nomear/podar padrões nem trazer a tabela final (4.2.3); não catalogar garantias (4.4).

**Apoios (sua escolha):** figura = cubo 3D dos eixos ou tabela por coluna (matriz *povoada* fica em 4.2.3); ordem dos eixos sugerida = par → estrutura → acesso (espelha P1→P4); manter a humildade da 4.1 (**representativo, não exaustivo**).

### 4.2.3 (A Taxonomia) — estrutura de redação (blocos) (orientação 2026-06-11)

> Seção-entregável do obj 1. Auto-suficiente (vai ser citada depois).

**Missão:** entregar os **4 padrões (P1–P4)** como resultado de **reduzir** as 36 células da 4.2.2, com **cada descarte rastreável a um motivo nomeado** e a garantia no safe como **relação de equivalência** (consequência), nunca critério de entrada.

**Perguntas que responde:** quais os padrões; como se chega neles a partir das 36 células; por que 4 (e por que cada célula saiu); o que individua P1/P3/P4; como alimenta 4.3/4.4.

> **Roteiro refeito 2026-06-15** — poda em **3 motivos de descarte** (não 1); P7 = restrição declarada (migração ESP32); contagem corrigida (36→25→18→11→4).

**Três motivos de descarte (não confundir — é o que blinda a defesa):**
- **(i) inexpressibilidade** — a célula não pode existir (`PC⟹Buffer`: ⟨ε,Escalar,PC⟩=4 + ⟨ε,Struct,PC⟩=4; ⟨DMA,ε,RMW⟩=3 → **11 células**, 36→25).
- **(ii) fora de escopo declarado** — plano **Núcleo-Núcleo** (P7); multi-core fora de toda a dissertação por decisão (ESP32 dual-core → corte deliberado, ver Decisão 2026-06-15). 9 células, **menos 2 já contadas em (i)** → 7 novas, 25→18.
- **(iii) não-factível no domínio** — exprimível e single-core, mas não instancia em algoritmo de controle (lista abaixo) → 7 células, 18→11.
- depois, **colapso por equivalência de garantia** funde as 11 restantes nos **4 padrões** (Opção A — variar só o par = variante, enunciada como regra geral; **sem** nomear variantes).

**Células descartadas por domínio (iii) — candidatas (sua decisão, Regra 7):**
- **Buffer × Leitor-Escritor** (3: ISR/DMA/Tarefa) — buffer in-place como "último valor" não ocorre; em controle, buffer = fila (PC) ou snapshot de agregado. Se só importa o último, é escalar; se há buffer, querem-se os itens (PC).
- **Buffer × RMW** (2: ISR, Tarefa — DMA-Buf-RMW já é (i)) — "array de acumuladores/histograma" é padrão de instrumentação, não de malha (PID/realimentação/estimador não têm arrays acumuladores compartilhados). ⚠️ Descartar por domínio **não** enfraquece a não-redundância do eixo Estrutura — aquele argumento só exige que `Buffer×RMW` seja *exprimível*, não que ocorra.
- **DMA × {Escalar, Struct} × Leitor-Escritor** (2) — DMA transfere blocos com flag de conclusão; escalar único via DMA é atípico (vira leitura direta / PC de 1 item) e struct via DMA é transferência de bloco (padrão PC/flag), não o hazard de atualização parcial in-place que define P3.
- *(Borda — sua escolha domínio × colapso: DMA-Esc-LW pode ser visto como "colapsa em P1"; Struct-RMW colapsa em P3. Decida conscientemente.)*

**Tabela de verificação — as 11 restantes → 4 padrões** (apoio à "conta explícita" escolhida pelo Matheus; andaime de planejamento, **não** entra inteira no texto — Regra 4):

| Célula ⟨Par · Estrutura · Acesso⟩ | Garantia exigida no safe | Padrão |
|---|---|---|
| ⟨T↔T, Escalar, LW⟩ | atomic load/store | P1 |
| ⟨ISR, Escalar, LW⟩ | atomic load/store | P1 *(variante de par)* |
| ⟨ISR, Buffer, PC⟩ | fila SPSC / canal | P2 |
| ⟨DMA, Buffer, PC⟩ | fila SPSC / canal | P2 |
| ⟨T↔T, Buffer, PC⟩ | fila SPSC / canal | P2 *(variante de par)* |
| ⟨T↔T, Struct, LW⟩ | mutex do bloco / snapshot | P3 |
| ⟨T↔T, Struct, RMW⟩ | mutex do bloco / snapshot | P3 |
| ⟨ISR, Struct, LW⟩ | mutex do bloco / snapshot | P3 |
| ⟨ISR, Struct, RMW⟩ | mutex do bloco / snapshot | P3 |
| ⟨ISR, Escalar, RMW⟩ | RMW atômico / seção crítica | P4 |
| ⟨T↔T, Escalar, RMW⟩ | RMW atômico / seção crítica | P4 |

11 células → **4 classes de garantia**. "*(variante de par)*" = mesma garantia, par diferente → não nomeada (Opção A). Distribuição: P1=2, P2=3, P3=4, P4=2. As 4 variantes só-de-par estão visíveis aqui (2 com rótulo herdado, 2 sem) — justifica a regra geral única.

**Blocos (ordem de escrita):**
1. **Transição + os 3 motivos de descarte** — retoma as 36 células e anuncia (i)/(ii)/(iii) + o colapso por equivalência. Re-trava anti-circularidade: garantia = relação de equivalência (consequência).
2. **Filtro de possibilidade (inexprimíveis)** *(já no seu draft — ajustar a conta p/ 25)* — `PC⟹Buffer` (unifica os dois) + `DMA×RMW`; manter a nota de não-redundância (`Buffer×RMW` exprimível) **aqui** (4.2.3), não na 4.2.2.
3. **Corte de escopo declarado (Núcleo-Núcleo / P7)** — restrição deliberada (não "fato de HW"); single-core como condição operacional (confinar a 1 núcleo); multi-core → cap. 6. ⚠️ não contar 2× (2 das 9 já caíram em (i)).
4. **Não-factível no domínio + colapso por equivalência** — remove as 7 de domínio (acima); colapso por garantia → sobram **4 padrões**. Enunciar **uma vez** a regra *variar só o par = variante dentro do padrão* (Opção A, 2026-06-15 — sem nomear P5/P6); ilustrar com 1–2 cenários (flag de emergência → P1; hand-off de trajetória → P2) sem canonizá-los.
5. **A tabela** (entregável) — ordem P1→P4; colunas: **# / Nome · ⟨Par · Estrutura · Acesso⟩ · Exemplo em controle · Garantia exigida no safe**. Transcrever da "Nomenclatura fechada" (não reinventar). Garantia = *propriedade exigida*; alternativas ficam em 4.4. *(Corrigir o `tabela P1-P7` do esqueleto.)*
6. **As distinções finas** — **P1×P3** (granularidade: cabe na palavra, acesso = consistência × agregado c/ invariante, consistência > acesso → mutex/publicação); **P1×P4** (acesso: P1 leitor↔escritor × P4 RMW do mesmo valor, lost update; `c += 1` = load→add→store).
7. **Forward-pointer** (1–2 frases) — alimenta 4.3 (fronteira por padrão) e 4.4 (espaço de design por padrão); manter a ordem P1→P4 em 4.3/4.4/cap. 5.

**Pontos de defesa:** "cadê as 32?" → cada uma sai por motivo nomeado (i/ii/iii) ou colapsa; conta fecha 36→25→18→11→4. "Multi-core não acontece? o chip tem 2 núcleos" → restrição declarada (regime distinto; cap. 6). "`PC⟹Buffer` acopla os eixos?" → gera células vazias (inexpressibilidade ≠ não-ortogonalidade); `Buffer×RMW` exprimível → eixo Estrutura não-redundante. "por que só 4?" → 3 filtros + equivalência; **representativo, não exaustivo**.

**Fronteiras (não invadir):** 4.2.2 (não re-derivar eixos); 4.3 (só *nomear* a fronteira, não caracterizá-la); 4.4 (nomear a garantia *exigida*, não alternativas/trade-offs). ⚠️ **Custo** re-centrado no P3 — fica em 4.3/4.4, **fora** da 4.2.3 (descritiva).

**Micro-decisões (suas) + pendências:**
- formato: filtro (impossível + escopo + domínio) → colapso → tabela → distinções (recomendado);
- contagem: `⟨ε,Esc,PC⟩`=4 + `⟨ε,Struct,PC⟩`=4 + `⟨DMA,ε,RMW⟩`=3 = **11** → 25; Núcleo **7 novas** → 18; domínio **7** → 11; equivalência → 4. Exiba a conta ou só descreva, mas seja consistente;
- figura: cubo da 4.2.2 com povoadas destacadas, **impossíveis riscadas**, **plano Núcleo sombreado "fora de escopo"** (3 motivos visuais); ✦ nas que viram caso no cap. 5 (P1, P2, P3);
- LaTeX (você corrige): `\subsection{...}\label{subsec:three-axis}` (não 2º argumento); tuplas em math → `\langle\rangle` + `\text{...}`; definir `\label{sec:prod-cons}`;
- pendência: confirmar atômicos do Xtensa (afeta 4.4, não esta).

---

## 4.3 Método: Caracterização da Fronteira safe/unsafe (obj 2)

> **A tríade 4.2 → 4.3 → 4.4** (fio que liga as três seções; cada uma faz uma pergunta sobre o mesmo padrão P1–P4):
> - **4.2** — *qual* garantia o padrão **exige**? (propriedade abstrata)
> - **4.3** — até *onde* o Rust **safe codifica** essa garantia no tipo, e onde escapa para `unsafe`? → a **fronteira**
> - **4.4** — *quais* as opções de entregá-la no lado safe, e **a que custo**? → o **espaço de design**
>
> É o título da tese desmontado: **4.3 = a fronteira · 4.4 = o custo**. Consequências: o argumento de **custo** mora na 4.4 (não aqui); e a 4.4 é onde a trava anti-circularidade da 4.2.2 se fecha (a 4.2 *nomeia* a garantia; a 4.4 *cataloga* as soluções).

**Missão da seção:** para cada padrão P1–P4, localizar e caracterizar a fronteira — o que o Rust safe codifica no tipo (recusa o DR em compilação) e onde a garantia escapa do compilador (força `unsafe`). Materializa o **eixo transversal 4** (o que Rust *não* garante) — o que protege a tese de soar exagerada. **Saída (entregável do obj 2):** o mapa da fronteira por padrão (consolidado na 4.3.3).

> **Pendência de registro (Regra 6, anotada 2026-06-21):** os roteiros de 4.3.1/4.3.2/4.3.3 abaixo **antecedem** os refinamentos que entraram no `.tex` durante a redação (18/jun) e a revisão (21/jun). A incorporar aqui quando houver tempo: na **abertura**, o vocabulário safe/unsafe + a honestidade (UB confinável via bloco `unsafe`); na **4.3.1**, os 3 desfechos nomeados (A inteiramente safe · B fronteira interna · C inteiramente unsafe) + registro construção/veredito/fronteira; na **4.3.2**, os 3 pilares + os 2 grupos de erro + o critério dos 2 requisitos + soundness; na **4.3.3**, o **critério contrafactual** `unsafe`-sincronização × `unsafe`-hardware, o escopo "data races da taxonomia" (não universal) e a defesa par-transversal × par-decide-a-fronteira. O `.tex` é a fonte atual; este plano está atrás.

### 4.3.1 Procedimento — estrutura de redação (blocos)

**Missão:** descrever *como se investiga* a fronteira em cada padrão — o protocolo, não as conclusões.

**Perguntas que responde:** como, operacionalmente, se localiza a fronteira; o que conta como "tentar exprimir em safe"; como manter o método uniforme nos 4 padrões; o que se registra de cada tentativa.

**Blocos (ordem de escrita):**
1. **O roteiro em 3 passos** — para cada P1→P4: (a) exprimir o padrão em Rust safe idiomático; (b) compilar e observar a reação; (c) localizar o ponto onde o DR vira inexprimível **ou** o compilador exige `unsafe`.
2. **Definição de "tentativa idiomática"** — o que um dev Rust competente escreveria (`heapless`, `Mutex` de `critical-section`, atomics), não um espantalho fácil de derrubar nem `unsafe` gratuito. Blinda contra "você plantou o resultado".
3. **Protocolo uniforme + registro** — mesma sonda nos 4 padrões; registrar a construção safe tentada, o veredito (compila/recusa) e o ponto de fronteira. A uniformidade é o que torna o mapa (4.3.3) comparável.
4. **Natureza da evidência** — compilar *é* o experimento (liga à 4.1); é reproduzível (a banca pode rodar).

**Pontos de defesa:** *"não é só tentar até dar certo?"* → sonda fixa de 3 passos, aplicada igual; o veredito é determinístico, não tateio. *"você escolheu a versão safe que convém?"* → o critério de "idiomática" + o registro tornam a escolha auditável.

**Fronteiras (não invadir):** **4.3.2** decide *o que* é safe×unsafe e o que prova — aqui é só *como se olha*; **4.3.3** traz os resultados/mapa — aqui, nenhum; **cap. 5** tem o caso completo — aqui, no máximo snippets mínimos.

**Apoios:** `rustc` (verificador), inspeção de `Send`/`Sync`, `miri` (UB em testes do que recair em `unsafe`); fora de escopo: `cargo-call-stack` (outra classe).

### 4.3.2 Critério — estrutura de redação (blocos)

**Missão:** fixar as definições que tornam a fronteira *decidível* — o que é estar de cada lado e o que **prova** cada veredito. Sem isto, "fronteira" é metáfora.

**Perguntas que responde:** o que define operacionalmente safe e unsafe; qual a evidência primária e as secundárias; por qual *mecanismo* o DR fica inexprimível; como distinguir "não compila por DR" de "não compila por outro motivo".

**Blocos (ordem de escrita):**
1. **Definição operacional dos dois lados** — *safe*: sem `unsafe`, garantia no tipo (`AtomicU32`, `Mutex`, o `Producer`/`Consumer` do split da `heapless::spsc`); *unsafe*: bloco `unsafe`, FFI, registrador de periférico, `static mut`.
2. **Hierarquia de evidência** — primária: compila vs. não-compila; secundária: a mensagem específica (`E0277` para `Send`/`Sync` ausente, borrow, lifetime) — é a mensagem que **identifica a causa**.
3. **O mecanismo** — `Send` + `Sync` + borrow checking: nenhum valor não-`Sync` cruza de contexto sem sincronização que o torne `Sync`. É o **eixo transversal 5** (convenção em C → obrigação de tipo em Rust).
4. **Critério de atribuição de causa** — só conta como evidência de fronteira se a recusa for atribuível ao DR: amarrar a mensagem (bloco 2) à definição operacional de DR da 4.2.1.

**Pontos de defesa:** *"compila/não-compila é evidência?"* → evidência por construção da exploratória (4.1, Wazlawick): tipo = especificação, compilador = verificador determinístico. *"e se não compilar por outro motivo?"* → o critério de atribuição de causa resolve.

**Fronteiras (não invadir):** **4.3.1** é *como se olha* (roteiro), aqui é *o que se decide*; **4.3.3** aplica o critério aos padrões que cruzam; **4.4** trata o leque dentro do safe — aqui o critério é binário.

**Apoios:** lista dos códigos de erro (`E0277` etc.) como âncora; cross-ref à definição de DR (4.2.1).

### 4.3.3 Padrões que Cruzam a Fronteira — estrutura de redação (blocos)

**Missão:** entregar o resultado mais honesto do obj 2 — a fronteira **atravessa** padrões em vez de classificá-los inteiros — e consolidar o mapa.

**Perguntas que responde:** a fronteira separa padrões inteiros ou passa por dentro; qual o exemplo mais claro; o que isso significa para a honestidade da tese (eixo 4); como fica o mapa consolidado.

**Blocos (ordem de escrita):**
1. **O fenômeno** — a fronteira não particiona "padrões safe × padrões unsafe"; corta *dentro* de um mesmo padrão (parte em safe, parte — borda de hardware — em `unsafe`).
2. **Exemplo canônico (P2)** — a fila SPSC é safe e o split garante posse exclusiva (DR no buffer inexprimível); **mas** configurar DMA / ler registrador do ADC é `unsafe` na HAL. Um padrão, dois lados.
3. **Os outros padrões à luz disso** — verificar P1/P3/P4: quais ficam inteiramente em safe (ex.: P1 com `AtomicU32` puro) e quais reintroduzem `unsafe` na borda. Classificar: fronteira interna vs. inteiramente safe.
4. **Implicação para a tese (eixo 4)** — é onde o Rust *não* cobre por construção; o `unsafe` é *declarado*, isolável e **mensurável** (LoC) — gancho para 4.4 (custo) e 4.6 (medição).
5. **O mapa consolidado (entregável)** — tabela P1→P4: onde a fronteira passa, o que fica safe, o que força unsafe, evidência. Consolida 4.3.1–4.3.3 e fecha a seção.

**Pontos de defesa:** *"então Rust não resolve?"* → resolve a parte expressável em safe (a maior parte do código de controle); o `unsafe` residual é pequeno, confinado e auditável — vs. C, onde *todo* o código carrega o risco não-marcado. O ponto é *deslocar e confinar* o risco, não eliminá-lo 100%. *"fronteira da linguagem ou da Aule?"* → da linguagem; a Aule instancia; sua contribuição é mapeá-la em controle.

**Fronteiras (não invadir):** **4.3.1/4.3.2** — aplicar, não reexplicar; **4.4** — o que fazer com a parte safe é lá; **cap. 5** — o caso ISR/DMA *completo* é resultado material, aqui só como exemplo.

**Apoios:** a tabela mapa-da-fronteira; o P2 como fio condutor; ligação explícita ao eixo transversal 4.

---

## 4.4 Método: Catalogação do Espaço de Design das Garantias (obj 3)

> **Renomeação fixada (2026-06-11):** a subseção antes chamada "Eixos de Design" passa a **"Dimensões de Design"**. "Eixos" fica reservado às dimensões do *problema* (a taxonomia, 4.2.2); usar a mesma palavra para a *solução* induz a banca a confundir taxonomia com espaço de design. Reflexo no esqueleto `.tex` fino (adiante) já aplicado.

**Missão da seção:** para os padrões do lado safe, catalogar as **alternativas** de implementar a garantia que torna o DR inexprimível, com os **trade-offs** em `no_std`. É **onde o "custo" do título da tese é argumentado** e materializa o **eixo transversal 3** (garantia por tipos × runtime). **Saída (entregável do obj 3):** o catálogo do espaço de design. **Fecha a parte da qualificação.**

> **Consolidação do roteiro (2026-06-21):** a tríade 4.2→4.3→4.4 **fecha aqui** — a 4.2 *nomeou* a garantia exigida, a 4.3 *localizou* a fronteira, a 4.4 *cataloga as soluções e seu custo* (completa a trava anti-circularidade: classifica-se pelos eixos do problema; a garantia é consequência, catalogada aqui). **Escopo herdado da 4.3:** a 4.4 trata **só do lado safe** — o `unsafe` da borda de HW (P2) não é escolha de design, não entra; seu custo é medição (4.6).

### 4.4.1 Dimensões de Design — estrutura de redação (blocos)  *(hoje rotulada "Eixos de Design" no `.tex` — renomear)*

**Missão:** definir o espaço e **catalogar as alternativas** de garantia para cada padrão safe — o "o que existe", antes do "a que custo" (4.4.2).

**Perguntas que responde:** o que é o espaço de design e o que é uma "dimensão"; quais as alternativas concretas de codificar a garantia; quais se aplicam a quais padrões; por que essas e não outras.

**Blocos (ordem de escrita):**
1. **Definição + a renomeação** — espaço = formas de codificar a garantia de um padrão safe; dimensão = escolha independente (cópia vs. compartilhamento; bloqueante vs. lock-free; estático vs. heap). **Fixar a renomeação** "eixos→dimensões" e justificar: "eixos" já nomeia as dimensões do *problema* (4.2.2); reusar a palavra para a *solução* induz a banca a erro.
2. **O catálogo** — atomics/lock-free; `Mutex`/critical-section; message-passing (`heapless` SPSC/canal); `Arc`/refcount (⚠️ **exige `alloc`** — fora do core `no_std` da Aule; entra como *condição de aplicabilidade*, não como custo — o custo é 4.4.2; e **só muta com `Mutex`/atomic dentro** — `Arc<T>` puro é compartilhamento imutável, não cobre DR de escrita); cópia *owned*; **snapshot/publicação por troca de ponteiro** (double-buffer + `AtomicPtr`, ou `arc-swap` c/ `alloc`) — a alternativa **lock-free** do P3. Cada uma em uma linha (o que garante, como).
   - **Critério de inclusão do catálogo (decisão 2026-06-26):** só construções **gerais da linguagem/ecossistema**, não presas a um framework. → **RTIC fica de fora** (priority-ceiling é específico do RTOS RTIC; quem usa Embassy ou bare-metal não tem). `critical-section`/`heapless`/atomics/`Arc` passam (genéricos). No máximo, mencionar que frameworks (RTIC) oferecem mecanismos equivalentes — sem catalogá-los como linha.
   - [pendência: confirmar a config `no_std`/`alloc` da Aule em `../aule`.]
3. **Mapeamento padrão → alternativas** — P1 → atomic puro / cópia owned; P2 → SPSC; P3 → `Mutex` do bloco / snapshot-publicação por troca de ponteiro (lock-free) / cópia da struct; P4 → RMW atômico (onde houver) / critical-section. *(RTIC removido — ver critério no bloco 2.)*
4. **Ancoragem** — são as construções idiomáticas do ecossistema Rust embedded, não invenção (fonte = literatura/ecossistema; busca é sua, Regra 7).

**Pontos de defesa:** *"isto não é a taxonomia de novo?"* → não: taxonomia = *problemas*, espaço de design = *soluções*; fecha a direção eixos→garantia. *"é exaustivo?"* → representativo (humildade da 4.1). *"cópia owned não resolve tudo barato?"* → para escalar (P1) é barato; para agregado (P3) é snapshot com custo de RAM/banda → vira trade-off (4.4.2), não bala de prata.

**Fronteiras (não invadir):** **4.2** — a garantia *exigida* é lá, as *alternativas* aqui; **4.3** — o espaço é só do lado **safe** (o `unsafe` da borda de HW não entra — não é escolha de design); **4.4.2** — aqui se *lista/mapeia*, os *trade-offs* são lá; **4.5** — *catalogar* aqui, *escolher* o que vai à Aule é lá.

**Apoios:** tabela alternativa → (o que garante · como); a renomeação documentada.

### 4.4.2 Trade-offs em `no_std` — estrutura de redação (blocos)

**Missão:** comparar as alternativas pelas dimensões de custo — **é aqui que o "custo" do título da tese é argumentado**. Transforma o catálogo (4.4.1) de "lista" em "opções com consequências".

**Perguntas que responde:** por quais dimensões as alternativas diferem em custo; qual o custo específico em controle (determinismo); como o alvo (**ESP32 Xtensa** — ver Decisão 2026-06-15) muda os trade-offs; o que é "catalogado"; o custo é medido ou argumentado.

**Blocos (ordem de escrita):**
1. **As dimensões de trade-off** — runtime (ciclos, bloqueio), ergonomia (boilerplate, legibilidade), footprint (RAM/flash), **determinismo** (jitter, *priority inversion*) — a mais crítica em controle e a mais subestimada.
2. **O gancho de custo — re-centrado no P3 (ISA-independente)** *(reframe 2026-06-15, ver Decisão)* — nenhuma arquitetura tem atômico que cubra um agregado multi-palavra com invariante entre campos → o lado safe é **obrigado** a exclusão mútua (seção crítica/`Mutex`) ou snapshot/publicação (double-buffer + troca de ponteiro) → custo de latência/jitter/RAM. Esse custo **não depende da ISA**. Reframe geral: em safe Rust **não dá pra *não* sincronizar**; em C dá (e o bug nasce daí). **Ilustração secundária (P4):** há uma classe de MCUs (ARMv6-M sem LDREX/STREX; RISC-V sem ext. A) onde até o escalar paga seção crítica (`critical-section`/`portable-atomic`) — honesto que o ESP32 Xtensa provavelmente tem atômico (`S32C1I`). ⚠️ **Confirmar atômicos do Xtensa** (pendência). **Enquadramento (2026-06-21):** custo = **preço da garantia forçada, não deficiência do Rust** — liga ao "desloca e confina o risco" da 4.3.3; o custo aparece só onde C estaria *errado* (sem sincronizar).
3. **A matriz** — padrão (P1–P4) × alternativa × dimensões de trade-off; o entregável da 4.4. Células = anotação qualitativa (não número).
4. **Critério de "catalogado"** — cada padrão safe mapeado às opções viáveis com trade-offs anotados; representativo, não exaustivo.

**Pontos de defesa:** *"o custo é medido?"* → **não** na qualificação; é **argumentado** aqui (qualitativo) e **medido** em 4.6 (pós-qual). *"os trade-offs são opinião?"* → ancorados em propriedades arquiteturais (no P3 nenhuma ISA tem atômico do tamanho do agregado → exclusão mútua é obrigatória e serializa/desabilita IRQ = fato independente de chip) e na literatura de RTOS. *"por que determinismo pesa mais?"* → o domínio tem deadlines; jitter de lock pode violar o período de controle (conecta custo-de-garantia a viabilidade-no-domínio). *"se o custo só é medido na dissertação, isto não é especulação?"* → não: a qualificação entrega o **catálogo + o argumento arquitetural + o desenho do experimento (4.6)** — é a **hipótese que o experimento testa**, não chute. *"então Rust é só mais lento?"* → o custo aparece **só onde C estaria errado** (sem sincronizar); comparar custo só faz sentido contra um C **também correto** — e isso é 4.6/4.7.

**Fronteiras (não invadir):** **4.4.1** — aqui se *compara/custeia*, o catálogo é lá; **4.6** — *argumentar* ≠ *medir* (registrador de ciclos — `CCOUNT` no ESP32); **4.2** — não reabrir a individuação dos padrões; **4.3** — só o lado safe (o `unsafe` de HW não entra); **4.7 ⚠️** — a **comparação estruturada Rust × C+MISRA+sanitizers é lá**; aqui C entra **só como contraste conceitual** (por que existe custo: C não sincroniza → bug) e o custo catalogado é **intra-Rust** (entre as alternativas safe). É a linha que a 4.3.3 quase cruzou (correção 2026-06-21).

**Apoios:** a matriz padrão × alternativa × trade-off; pendência = atômicos do Xtensa no ESP32 (ver Decisão 2026-06-15).

> **Frase de fecho da 4.4** (sem subseção — decisão do plano): ponte ao obj 4 — cada dimensão → um candidato a instanciar na Aule ("um por dimensão") + rastreabilidade. Fecha a fase exploratória/qualificação inteira.

---

## 4.5 A Aule como Veículo de Instanciação (obj 4 — pós-qual, apresentar como plano)

> Aqui condensam, **reposicionadas como veículo** (não contribuição), as antigas seções "Requisitos / Arquitetura / Implementação".

**Perguntas que a seção responde:**
- Por que a Aule é o **veículo** adequado? (dá realismo aos casos vs. exemplos de brinquedo; `no_std`/embedded; já madura — ver [`aule_roadmap.md`](aule_roadmap.md))
- **Ponto-de-virada** (composição *forward* + `Signal`/monoid): por que é decisão de **memory safety** e não só de arquitetura? (mantém garantias estáticas, `no_std` sem heap — evita o `Rc<RefCell>`/arena/`unsafe` a que o grafo *backward* empurraria em Rust)
- Como traduzir o **catálogo (4.4)** em implementação? (critério "um por eixo do espaço de design")
- **Política de `unsafe`:** quando aceitar, como isolar (HAL/FFI), como **medir** o tamanho da fronteira.
- Requisitos do veículo herdados: `no_std`, `alloc` opcional, portabilidade host ↔ embedded.

**Notas de honestidade (a banca cutuca):**
- Forward é **enabler, não prova** — viabiliza, não demonstra a eliminação (a prova são os casos + experimento).
- O encadeamento via operador `*` usa `&mut dyn Block` (**dispatch dinâmico**) → **não** alegar "zero-custo" sem ressalva (o caminho monomorfizado é a chamada direta `.output()`).
- Custo do *backward* é argumento técnico + literatura (não foi implementado/medido) — ver `outline_geral.md` §ponto-de-virada.

---

## 4.6 Protocolo do Experimento de Custo (obj 5–7 — pós-qual, protocolo)

**Perguntas que a seção responde:**
- **Planta-alvo (DECIDIDO 2026-06-04):** pêndulo invertido + realimentação de estados (state feedback). Kalman/observador entra como opção (estado estimado compartilhado → célula "struct coerente" da taxonomia). Smith Predictor e MPC aposentados.
- **Plataforma:** **ESP32 (Xtensa dual-core), operado em núcleo único** (multi-core fora do escopo — ver Decisão 2026-06-15). *(Antes: Cortex-M0; o obj 5 ainda diz "Cortex-M0" → re-redigir, ver F12.)* Placa específica indefinida — plano: simulação host + HIL via `probe-rs` (já na Aule). Decidir se fecha agora ou na execução.
- **Implementações comparadas:** C + FreeRTOS + MISRA (estado da arte) vs. Rust + `heapless` + RTIC.
- **Métricas:** overhead de tempo de execução — ciclos/iteração (obj 5); perda de deadlines (obj 6); comparação dos dois entre Rust e C (obj 7).
- **Como medir** overhead/deadlines no ESP32? (registrador de ciclos `CCOUNT` no lugar do DWT do Cortex-M; instrumentação via `probe-rs`) ⚠️ confirmar `CCOUNT`.
- **Controle de variáveis:** mesmo algoritmo, mesma plataforma, mesmas condições de carga.
- Hipótese a refutar: "Rust é mais lento" — esperado empate; como evidenciar.

**Nota:** apresentado como **protocolo** — o experimento é conceito hoje, nada implementado.

**Critérios — o que fecha na qualificação (DECIDIDO 2026-06-04):**
- **Fecha agora:** critério qualitativo central completo (data race no lado safe → o código que o produziria **não compila** / é forçado à forma segura = sucesso); eixos quantitativos com **operacionalização** (overhead via registrador de ciclos — `CCOUNT` no ESP32; "deadline perdido" = estourar o período de controle; fronteira `unsafe` = LoC em blocos `unsafe`; boilerplate de segurança eliminado).
- **Adia p/ dissertação:** thresholds numéricos (ex.: "empate" = Δ < X%), placa ESP32 específica, escala (nº de cenários e repetições).
- Regra: fechar *o que* medir e *como*; adiar *quanto*.

---

## 4.7 Protocolo: Verificação por Tipos vs. C+MISRA+Sanitizers (obj 8 — pós-qual, protocolo qualitativo)

**Perguntas que a seção responde:**
- Como **comparar** a verificação por tipos/compilação (Rust safe) com o estado da arte em C (MISRA + ASan/TSan/UBSan + padrões ISO)?
- **Artefato central:** para cada bug, o **trio** {snippet C que o produz; erro de compilação Rust que o impede; diagnóstico do sanitizer correspondente}.
- **Métricas qualitativas:** bugs que o sanitizer detecta em C e que **não compilam** em Rust; boilerplate de segurança eliminado (locks manuais, bounds checks, verificação de init); tamanho da fronteira `unsafe`.
- **Onde o sanitizer NÃO pega** (eixo de honestidade — ver Caso 3: UAF sob mutex que o TSan não vê porque o acesso *está* sincronizado; o problema é a vida do ponteiro).
- **Deslocamento da verificação** (eixo transversal 5): de revisão humana + ferramenta externa em runtime → para o sistema de tipos em compilação.

---

## Decisões em aberto / divergências a reconciliar

1. ~~Quais casos sob o título "data races"?~~ **RESOLVIDO (2026-06-04):** estreitar para data race puro. Caso 1 (delay line, OOB/uninit) e Caso 3 (MPC workspace, UAF) **aposentados do núcleo**. Taxonomia construída sobre padrões reais de DR (ver 4.2); casos do cap. 5 = setpoint escalar (didático) + ISR/DMA→buffer (central) + estado composto estimador↔controlador.
2. ~~Planta do experimento.~~ **RESOLVIDO (2026-06-04):** pêndulo invertido + realimentação de estados (ver 4.6). Smith Predictor + Kalman + MPC aposentados; Kalman pode reaparecer como observador.
3. ~~`no_std` vs. `std` no Caso 3.~~ **RESOLVIDO por tabela-rasa:** com o MPC fora, a questão do `Arc`/`arc_swap` em Cortex-M0 deixa de existir. Pêndulo + state feedback é `no_std`-friendly.
4. ~~Natureza da pesquisa (4.1).~~ **RESOLVIDO (2026-06-04); RE-CLASSIFICADO (2026-06-05):** pesquisa **exploratória-empírica** na taxonomia de Wazlawick (§2.6) — exploratória (qualificação) + empírica/experimental (dissertação). A classificação Gil de 4/jun ("aplicada/mista/exploratória-descritiva") foi descartada. Ver 4.1 + nota de correção.
5. ~~Fechar critérios agora ou na dissertação?~~ **RESOLVIDO (2026-06-04):** qualitativo central 100% + eixos quantitativos operacionalizados fecham agora; thresholds/placa/escala na dissertação. Ver 4.6.

## Pendência de manutenção do roadmap

`roadmap_escrita.md` já foi realinhado (semana 1 = 4.1–4.4; forward/`Signal` migrou para 4.5) em 2026-06-04. ✓

---

## Preparação para a redação (4/jun)

### Micro-decisões a fixar (recomendações — confirme/ajuste)
1. **Granularidade da taxonomia: FECHADO (2026-06-10):** 4 padrões (P1–P4) + 2 variantes (P5 em P1, P6 em P2) + P7 como limitação. Não o produto cartesiano. Ver "Nomenclatura fechada" em §4.2.
2. **Nomenclatura dos padrões: FECHADA (2026-06-10):** P1 Tipo primitivo compartilhado · P2 Produtor-consumidor · P3 Tipo composto compartilhado · P4 Read-modify-write compartilhado. Tabela completa (com garantia exigida) em §4.2 → "Nomenclatura fechada". Citar consistentemente em 4.3/4.4 e no cap. 5.
3. **Quantos casos viram código completo (C + Rust):** os 3 decididos (P1, P2, P3). Sob aperto de prazo, garantir P1+P2; P3 pode ficar descritivo. Demais células: só na taxonomia (texto).
4. **Ordem dentro de 4.2:** crescente em complexidade (P1 primitivo → P2 produtor-consumidor → P3 composto → P4 RMW; ou reordenar por complexidade da garantia — sua escolha). Espelhar a mesma sequência em 4.3 e 4.4 (leitura fácil). *(multi-core/P7 saiu do escopo.)*
5. **Ancoragem da taxonomia:** literatura de concorrência embedded/RTOS + modelo de memória C11/Rust, com os casos como instâncias — não "da cabeça" (a banca cobra fonte; a bibliografia em levantamento cobre isso).

### Esqueleto `.tex` fino de 4.1–4.4 (rótulos sugeridos — transcreva você; sem prosa aqui)
- `\section{Caracterização da Pesquisa}` (4.1) — natureza (aplicada) · abordagem (mista) · objetivos (exploratória-descritiva) · procedimentos (bibliográfica + experimental); nota: qualificação = fase quali + *desenho* da quanti.
- `\section{...}` (4.2 — sugiro rotular "Taxonomia de padrões de data race…")
  - `\subsection` método de levantamento (fontes + critério de inclusão)
  - `\subsection` os três eixos (par de contextos · estrutura do dado · padrão de acesso)
  - `\subsection` a taxonomia — tabela P1–P7 ← **entregável obj 1**
- `\section{...}` (4.3 — "Fronteira safe/unsafe dos padrões")
  - `\subsection` procedimento (exprimir em safe; observar a recusa do compilador)
  - `\subsection` critério (compila/não-compila · `Send`/`Sync` · borrow)
  - `\subsection` padrões que cruzam a fronteira (fila safe + registrador `unsafe`)
- `\section{...}` (4.4 — "Espaço de design das garantias")
  - `\subsection` **dimensões de design** (atomics · lock/critical-section · message-passing · RTIC resources · owned-copy) — *renomeado de "eixos de design" (2026-06-11): "eixos" fica reservado à taxonomia (4.2.2); aqui é "dimensões" (a solução)*
  - `\subsection` trade-offs em `no_std` (runtime · ergonomia · footprint · determinismo)
  - *(sem subseção)* **frase de fecho** do 4.4 (decisão 4/jun): ponte para o obj 4 — critério "um por eixo" + rastreabilidade. Não vira subseção própria.

Lembrete LaTeX: o capítulo já abre com `\mychapter{Metodologia Proposta}{...}`; dentro use `\section`/`\subsection` normais — **nunca** `\mychapter` de novo (ver `CLAUDE.md` → convenções da classe).
