---
author: Claude (claude-opus-4-8)
created: 2026-06-04
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-11
  - Claude (claude-opus-4-8), 2026-06-13
  - Claude (claude-opus-4-8), 2026-06-14
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
| P5 | ISR↔tarefa | flag | leitor↔escritor | flag de emergência / watchdog | → variante de P1 (sub-bullet) |
| P6 | tarefa↔tarefa | buffer | produtor→consumidor | trajetória planejamento→low-level | → funde em P2 (variante de contexto) |
| P7 | core↔core | struct/escalar | leitor↔escritor | controlador↔supervisório (multi-core) | ✗ cortado — fora do escopo (Cortex-M0 single-core) → limitação declarada |

Critério de inclusão (obj 1): ocorre em controle real **e** é data race (≥2 contextos, ≥1 escrita, sem sincronização garantida). Critério de "vira caso": cobre combinação de eixos distinta + contraste C-vs-Rust didático.

### Nomenclatura fechada (2026-06-10) — 4 padrões

Nomes fixos — citar consistentemente em 4.3 / 4.4 / cap. 5. O **eixo que organiza a taxonomia é a garantia exigida no lado safe**: combinações de eixos que exigem a mesma garantia são o mesmo padrão (ou variante).

| # | Nome fixado | Eixo distintivo | Garantia no lado safe (→ 4.4) |
|---|---|---|---|
| P1 | **Tipo primitivo compartilhado** | leitor↔escritor de dado que cabe na palavra | atomic load/store + ordenação |
| P2 | **Produtor-consumidor** | transferência de itens via fila/buffer | fila SPSC / canal (transfere posse) |
| P3 | **Tipo composto compartilhado** | agregado > palavra + invariante entre campos | exclusão mútua do bloco **ou** snapshot/publicação |
| P4 | **Read-modify-write compartilhado** | atualização não-atômica do mesmo valor | RMW atômico **ou** seção crítica |

- **P5** (flag ISR↔tarefa) = **sub-bullet de P1** — mesma garantia (atomic load/store), muda só o par de contexto.
- **P6** (trajetória tarefa↔tarefa) = **nota em P2** — mesmo padrão produtor-consumidor, par de contexto diferente.
- **P7** (core↔core) = **limitação declarada** — fora do escopo de hardware (Cortex-M0 single-core); candidato a trabalho futuro.

**Distinção P1 × P3 (granularidade da atomicidade):** P1 = dado cabe na largura atômica → load/store atômico resolve (unidade de acesso = unidade de consistência). P3 = agregado multi-palavra com invariante entre campos → não há atomic desse tamanho → exclusão mútua ou publicação por troca de ponteiro (unidade de consistência > unidade de acesso).

**Distinção P1 × P4 (padrão de acesso):** P1/P5 = leitor↔escritor (um só lê, outro só escreve). P4 = RMW do mesmo valor (lost update); `c += 1` é load→add→store, não atômico. No Cortex-M0 (ARMv6-M) **não há LDREX/STREX** → sem RMW atômico em HW → cai em **seção crítica** (`critical-section`/`portable-atomic`): evidência direta do *custo* da segurança (conferir/citar o detalhe do ARMv6-M antes de afirmar).

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

**Blocos (ordem de escrita):**
1. **Enunciar os três eixos** — par de contextos · estrutura do dado · padrão de acesso. Definir "eixo" = dimensão descritiva independente de um DR.
2. **Necessidade de cada eixo** (por que importa p/ DR):
   - Eixo 1 — par de contextos: DR exige ≥2 contextos (def. 4.2.1); a natureza do par condiciona quais garantias são aplicáveis (ISR não bloqueia em mutex; DMA não executa código).
   - Eixo 2 — estrutura do dado: decide se há atômico de HW que cobre o dado inteiro (escalar→atomic; agregado multi-palavra c/ invariante→não há; buffer→posse). Granularidade consistência vs. acesso atômico (= distinção P1×P3).
   - Eixo 3 — padrão de acesso: fixados os outros 2, leitor↔escritor ≠ RMW (RMW exige atomicidade da sequência; lost update) (= distinção P1×P4, gancho ARMv6-M).
3. **Prova de ortogonalidade** (argumento mais forte) — fixar 2 eixos, variar 1, a garantia muda:
   - varia acesso: P1 atomic × P4 seção crítica → eixo 3 independente;
   - varia estrutura: P1 atomic × P3 mutex/snapshot → eixo 2 independente;
   - varia par: tarefa↔tarefa × ISR↔tarefa → eixo 1 condiciona o *mecanismo* **mesmo sem mudar a classe de garantia** → por isso **P5 é variante de P1, não padrão novo**. Converte a aparente fraqueza em rigor.
4. **Trava anti-circularidade** — os 3 eixos = causa/descrição (entrada); a garantia = consequência (catalogada em 4.4). Direção **eixos → garantia**. Corolário: *"mecanismo de sincronização"* **não pode ser um 4º eixo** (classificar pelas soluções → circular). Dizer explicitamente.
5. **Delimitação negativa** (banca cobra "por que não X?"):
   - *"tipo de bug de memória"* → recorte, não eixo (DR, 4.2.1);
   - *"prioridade/preempção"* → absorvido no eixo 1;
   - *"mecanismo de sincronização"* → consequência, não entrada (ver bloco 4).
6. **Geração da matriz** — produto cartesiano dos 3 eixos → células = padrões candidatos. Nem toda célula é povoada → aponta p/ critério de inclusão (4.2.1) e **passa o bastão à 4.2.3** (poda). A 4.2.2 mostra o *mecanismo de geração*; **não** lista os 4 padrões finais.

**Fronteiras (não invadir):** não re-derivar def. de DR/fontes (4.2.1); não nomear/podar padrões nem trazer a tabela final (4.2.3); não catalogar garantias (4.4).

**Apoios (sua escolha):** figura = cubo 3D dos eixos ou tabela por coluna (matriz *povoada* fica em 4.2.3); ordem dos eixos sugerida = par → estrutura → acesso (espelha P1→P4); manter a humildade da 4.1 (**representativo, não exaustivo**).

### 4.2.3 (A Taxonomia) — estrutura de redação (blocos) (orientação 2026-06-11)

> Seção-entregável do obj 1. Auto-suficiente (vai ser citada depois).

**Missão:** entregar os **4 padrões** como resultado de **povoar + podar** a matriz da 4.2.2, com a garantia exigida no safe como critério de individuação.

**Perguntas que responde:** quais os padrões; como se chega neles a partir da matriz; por que 4 e não 7; o que individua cada um; como alimenta 4.3/4.4.

**Blocos (ordem de escrita):**
1. **Transição matriz → padrões** (1 parágrafo) — a matriz (4.2.2) gera as células; aplica-se o critério de inclusão (4.2.1: ocorre em controle real **E** é DR) + o **critério de equivalência** (células que exigem a mesma garantia = mesmo padrão); resultam **4 padrões + 2 variantes + 1 limitação**. ⚠️ Trava anti-circularidade de novo: a garantia entra como *relação de equivalência sobre as células* (consequência), não como entrada.
2. **A tabela** (entregável) — tabela consolidada, ordem P1→P4, colunas: **# / Nome · (Par · Estrutura · Acesso) · Exemplo em controle · Garantia exigida no safe**. Transcrever da "Nomenclatura fechada" (não reinventar). A garantia aqui = *propriedade exigida* (critério); as **alternativas de implementação** ficam em 4.4.
3. **A poda explicada** (por que 4 e não 7) — P5→variante de P1 (mesma garantia, muda o par); P6→variante de P2 (mesmo produtor-consumidor, par diferente); P7→limitação declarada (core↔core fora do escopo Cortex-M0 single-core; trabalho futuro). É a aplicação concreta do critério de equivalência do bloco 1.
4. **As distinções finas** (defesa de que P1/P3/P4 são distintos):
   - **P1×P3** (granularidade da atomicidade): P1 dado cabe na palavra (acesso = consistência) × P3 agregado multi-palavra c/ invariante (consistência > acesso → mutex/publicação).
   - **P1×P4** (padrão de acesso): P1/P5 leitor↔escritor × P4 RMW do mesmo valor (lost update; `c += 1` = load→add→store).
5. **Forward-pointer** (1–2 frases) — alimenta 4.3 (fronteira por padrão) e 4.4 (espaço de design por padrão); comprometer-se a manter a ordem P1→P4 em 4.3/4.4/cap. 5.

**Pontos de defesa:** "organiza pelos eixos ou pela garantia?" → garantia = equivalência derivada dos eixos (bloco 1); "por que só 4?" → poda por inclusão + equivalência; **representativo, não exaustivo**; "P5/P6 não eram padrões?" → colapsam na mesma garantia (bloco 3); "e multi-core?" → P7 fora do escopo de HW (trabalho futuro).

**Fronteiras (não invadir):** 4.2.2 (não re-derivar eixos); 4.3 (só *nomear* que há fronteira, não caracterizá-la); 4.4 (nomear a garantia *exigida*, não catalogar alternativas/trade-offs).

**Micro-decisões (suas) + pendência:**
- formato: tabela consolidada + parágrafo de poda + parágrafo de distinções (recomendado);
- figura: reusar o cubo/matriz da 4.2.2 com células povoadas destacadas e podadas riscadas (visual da poda);
- marcar com ✦ as células que viram caso no cap. 5 (P1, P2, P3; P1+P2 garantidos sob aperto, P3 pode ficar descritivo);
- ⚠️ **ARMv6-M:** o gancho de custo do P4 (Cortex-M0 sem LDREX/STREX → seção crítica) é argumento de **custo** — manter fora da 4.2.3 (descritiva); usar em 4.3/4.4. **Confirmar/citar o detalhe do ARMv6-M antes de afirmar** (pendência aberta).

---

## 4.3 Método: Caracterização da Fronteira safe/unsafe (obj 2)

> **A tríade 4.2 → 4.3 → 4.4** (fio que liga as três seções; cada uma faz uma pergunta sobre o mesmo padrão P1–P4):
> - **4.2** — *qual* garantia o padrão **exige**? (propriedade abstrata)
> - **4.3** — até *onde* o Rust **safe codifica** essa garantia no tipo, e onde escapa para `unsafe`? → a **fronteira**
> - **4.4** — *quais* as opções de entregá-la no lado safe, e **a que custo**? → o **espaço de design**
>
> É o título da tese desmontado: **4.3 = a fronteira · 4.4 = o custo**. Consequências: o argumento de **custo** mora na 4.4 (não aqui); e a 4.4 é onde a trava anti-circularidade da 4.2.2 se fecha (a 4.2 *nomeia* a garantia; a 4.4 *cataloga* as soluções).

**Missão da seção:** para cada padrão P1–P4, localizar e caracterizar a fronteira — o que o Rust safe codifica no tipo (recusa o DR em compilação) e onde a garantia escapa do compilador (força `unsafe`). Materializa o **eixo transversal 4** (o que Rust *não* garante) — o que protege a tese de soar exagerada. **Saída (entregável do obj 2):** o mapa da fronteira por padrão (consolidado na 4.3.3).

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

### 4.4.1 Dimensões de Design — estrutura de redação (blocos)  *(hoje rotulada "Eixos de Design" no `.tex` — renomear)*

**Missão:** definir o espaço e **catalogar as alternativas** de garantia para cada padrão safe — o "o que existe", antes do "a que custo" (4.4.2).

**Perguntas que responde:** o que é o espaço de design e o que é uma "dimensão"; quais as alternativas concretas de codificar a garantia; quais se aplicam a quais padrões; por que essas e não outras.

**Blocos (ordem de escrita):**
1. **Definição + a renomeação** — espaço = formas de codificar a garantia de um padrão safe; dimensão = escolha independente (cópia vs. compartilhamento; bloqueante vs. lock-free; estático vs. heap). **Fixar a renomeação** "eixos→dimensões" e justificar: "eixos" já nomeia as dimensões do *problema* (4.2.2); reusar a palavra para a *solução* induz a banca a erro.
2. **O catálogo** — atomics/lock-free; `Mutex`/critical-section; message-passing (`heapless` SPSC/canal); recursos do RTIC (priority-ceiling); `Arc`/refcount; cópia *owned*. Cada uma em uma linha (o que garante, como).
3. **Mapeamento padrão → alternativas** — P1 → atomic puro / cópia owned / RTIC resource; P2 → SPSC / RTIC; P3 → `Mutex` do bloco / publicação por troca de ponteiro; P4 → RMW atômico (onde houver) / critical-section.
4. **Ancoragem** — são as construções idiomáticas do ecossistema Rust embedded, não invenção (fonte = literatura/ecossistema; busca é sua, Regra 7).

**Pontos de defesa:** *"isto não é a taxonomia de novo?"* → não: taxonomia = *problemas*, espaço de design = *soluções*; fecha a direção eixos→garantia. *"é exaustivo?"* → representativo (humildade da 4.1).

**Fronteiras (não invadir):** **4.2** — a garantia *exigida* é lá, as *alternativas* aqui; **4.3** — o espaço é só do lado safe; **4.4.2** — aqui se *lista/mapeia*, os *trade-offs* são lá; **4.5** — *catalogar* aqui, *escolher* o que vai à Aule é lá.

**Apoios:** tabela alternativa → (o que garante · como); a renomeação documentada.

### 4.4.2 Trade-offs em `no_std` — estrutura de redação (blocos)

**Missão:** comparar as alternativas pelas dimensões de custo — **é aqui que o "custo" do título da tese é argumentado**. Transforma o catálogo (4.4.1) de "lista" em "opções com consequências".

**Perguntas que responde:** por quais dimensões as alternativas diferem em custo; qual o custo específico em controle (determinismo); como o alvo (Cortex-M0/ARMv6-M) muda os trade-offs; o que é "catalogado"; o custo é medido ou argumentado.

**Blocos (ordem de escrita):**
1. **As dimensões de trade-off** — runtime (ciclos, bloqueio), ergonomia (boilerplate, legibilidade), footprint (RAM/flash), **determinismo** (jitter, *priority inversion*) — a mais crítica em controle e a mais subestimada.
2. **O gancho ARMv6-M (P4)** — Cortex-M0 sem LDREX/STREX → sem RMW atômico em HW → cai em seção crítica (`critical-section`/`portable-atomic`), que desabilita interrupções → custo de latência/determinismo. Evidência mais direta de que a segurança no safe **tem preço**. ⚠️ **Confirmar/citar o ARMv6-M antes de afirmar** (pendência aberta).
3. **A matriz** — padrão (P1–P4) × alternativa × dimensões de trade-off; o entregável da 4.4. Células = anotação qualitativa (não número).
4. **Critério de "catalogado"** — cada padrão safe mapeado às opções viáveis com trade-offs anotados; representativo, não exaustivo.

**Pontos de defesa:** *"o custo é medido?"* → **não** na qualificação; é **argumentado** aqui (qualitativo) e **medido** em 4.6 (pós-qual). *"os trade-offs são opinião?"* → ancorados em propriedades arquiteturais (seção crítica desabilita IRQ = fato do ARMv6-M) e na literatura de RTOS — daí citar o ARMv6-M. *"por que determinismo pesa mais?"* → o domínio tem deadlines; jitter de lock pode violar o período de controle (conecta custo-de-garantia a viabilidade-no-domínio).

**Fronteiras (não invadir):** **4.4.1** — aqui se *compara/custeia*, o catálogo é lá; **4.6** — *argumentar* ≠ *medir* (DWT cycle counter); **4.2** — não reabrir a individuação dos padrões.

**Apoios:** a matriz padrão × alternativa × trade-off; a pendência ARMv6-M.

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
- **Plataforma:** Cortex-M0 (dos objetivos). Placa específica indefinida — plano: simulação host + HIL via `probe-rs` (já na Aule). Decidir se fecha agora ou na execução.
- **Implementações comparadas:** C + FreeRTOS + MISRA (estado da arte) vs. Rust + `heapless` + RTIC.
- **Métricas:** overhead de tempo de execução — ciclos/iteração (obj 5); perda de deadlines (obj 6); comparação dos dois entre Rust e C (obj 7).
- **Como medir** overhead/deadlines em Cortex-M0? (DWT cycle counter; instrumentação via `probe-rs`)
- **Controle de variáveis:** mesmo algoritmo, mesma plataforma, mesmas condições de carga.
- Hipótese a refutar: "Rust é mais lento" — esperado empate; como evidenciar.

**Nota:** apresentado como **protocolo** — o experimento é conceito hoje, nada implementado.

**Critérios — o que fecha na qualificação (DECIDIDO 2026-06-04):**
- **Fecha agora:** critério qualitativo central completo (data race no lado safe → o código que o produziria **não compila** / é forçado à forma segura = sucesso); eixos quantitativos com **operacionalização** (overhead via DWT cycle counter; "deadline perdido" = estourar o período de controle; fronteira `unsafe` = LoC em blocos `unsafe`; boilerplate de segurança eliminado).
- **Adia p/ dissertação:** thresholds numéricos (ex.: "empate" = Δ < X%), placa Cortex-M0 específica, escala (nº de cenários e repetições).
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
