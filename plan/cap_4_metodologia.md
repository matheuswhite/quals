---
author: Claude (claude-opus-4-8)
created: 2026-06-04
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-11
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

### 4.2.2 (Os Três Eixos) — estrutura argumentativa (orientação 2026-06-11)

> Outline da subseção (Regra 4): o **argumento que ela carrega**, não prosa. Redação é do Matheus (Regra 1). Expande o "Alerta de coerência" acima e formaliza *por que três eixos*.

**Missão de convencimento:** provar que os 3 eixos são as dimensões **necessárias, independentes e suficientes (no recorte)** para descrever um DR, e que **cruzá-los gera o espaço** dos padrões. Se a banca aceita a 4.2.2, a taxonomia fica de pé. Poda + tabela final = **4.2.3** (não invadir).

**Perguntas que responde:** por que *três* e por que *estes*; necessidade de cada eixo; ortogonalidade; por que não outros eixos; como geram a matriz.

**Por eixo — necessidade (por que importa p/ DR) + independência (contraexemplo):**
- **Eixo 1 — par de contextos:** DR exige ≥2 contextos (def. 4.2.1); a *natureza* do par condiciona quais garantias são sequer aplicáveis (ISR não bloqueia em mutex; DMA não executa código). Filtra o conjunto de soluções viáveis — não é decorativo.
- **Eixo 2 — estrutura do dado:** decide se há **atômico de HW que cobre o dado inteiro** (escalar na palavra → load/store atômico; agregado multi-palavra c/ invariante → não há; buffer/fila → posse). É o eixo da *granularidade da consistência vs. granularidade do acesso atômico* (= distinção P1×P3).
- **Eixo 3 — padrão de acesso:** fixados os outros 2, **leitor↔escritor ≠ RMW** (RMW exige atomicidade da *sequência*; lost update) (= distinção P1×P4, gancho ARMv6-M).

**Prova de ortogonalidade (argumento mais forte) — fixar 2 eixos, variar 1, a garantia muda:**
- varia **acesso**: P1 atomic × P4 seção crítica → eixo 3 independente;
- varia **estrutura**: P1 atomic × P3 mutex/snapshot → eixo 2 independente;
- varia **par**: tarefa↔tarefa × ISR↔tarefa → eixo 1 condiciona o *mecanismo* **mesmo quando não muda a classe de garantia** → é por isso que **P5 é variante de P1, não padrão novo**. Explicitar isto converte a aparente fraqueza ("então o eixo 1 às vezes não importa?") em evidência de rigor.

**Trava anti-circularidade (a objeção que derruba a taxonomia):** os 3 eixos = **causa/descrição (entrada)**; a garantia exigida = **consequência (catalogada em 4.4)**. Direção **eixos → garantia**, nunca o contrário. Corolário: *"mecanismo de sincronização"* **não pode ser um 4º eixo** — seria classificar pelas próprias soluções e concluir qual solução (circular). Dizer explicitamente.

**Delimitação negativa (a banca cobra "por que não X?"):**
- *"tipo de bug de memória"* → não é eixo, é o **recorte** (DR, fixado em 4.2.1);
- *"prioridade/preempção"* → **absorvido** no eixo 1 (par de contextos);
- *"mecanismo de sincronização"* → **consequência**, não dimensão de entrada (ver trava acima).

**Geração da matriz:** **produto cartesiano** dos 3 eixos → células = padrões candidatos. Nem toda célula é povoada (não ocorre em controle real **ou** não é DR) → aponta p/ critério de inclusão (4.2.1) e **passa o bastão à 4.2.3** (poda). A 4.2.2 mostra o *mecanismo de geração*; **não** lista os 4 padrões finais.

**Fronteiras (não invadir):** não re-derivar def. de DR / fontes (4.2.1); não nomear/podar padrões nem trazer a tabela final (4.2.3); não catalogar garantias (4.4).

**Apoios (escolha do Matheus):** figura = eixos como cubo 3D **ou** tabela por coluna (matriz *povoada* fica em 4.2.3); ordem dos eixos sugerida = par → estrutura → acesso (espelha P1→P4); manter a humildade da 4.1 (cobre DR de estado compartilhado em controle concorrente embarcado — **representativo, não exaustivo**).

---

## 4.3 Método: Caracterização da Fronteira safe/unsafe (obj 2)

**Perguntas que a seção responde:**
- Para cada padrão da taxonomia (4.2), qual o **procedimento** para localizar a fronteira? (tentar exprimir o padrão em Rust *safe*; registrar o que o compilador recusa — `Send`/`Sync`/borrow — e onde força `unsafe`)
- O que define o **lado safe** vs. o **lado unsafe** de um padrão? (safe = exprimível sem `unsafe`, garantia codificada no tipo; unsafe = exige bloco `unsafe` / FFI / acesso direto a registrador / `static mut`)
- Qual o **critério de evidência** da fronteira? (compila vs. não-compila; mensagem do borrow checker; obrigação de `Send`+`Sync`)
- Como tratar padrões que caem **dos dois lados**? (ex.: ISR↔DMA — a fila SPSC é safe, mas o acesso ao registrador do periférico é `unsafe` dentro da HAL; a fronteira passa *dentro* do padrão)
- Que **ferramentas** apoiam a caracterização? (`rustc`; inspeção de `Send`/`Sync`; `miri` para UB em testes; `cargo-call-stack` fica fora — é outra classe)

**Saída (entregável do obj 2):** o mapa da fronteira por padrão.

---

## 4.4 Método: Catalogação do Espaço de Design das Garantias (obj 3)

**Perguntas que a seção responde:**
- Para os padrões do **lado safe**, quais as **alternativas** de implementar a sincronização que torna o data race inexprimível? Candidatos a eixos: atomics / lock-free; `Mutex` / critical-section; message-passing (SPSC `heapless::Queue`); recursos do RTIC (priority-ceiling); `Arc` / refcount; cópia *owned* (sem compartilhar ponteiro).
- O que é um **"eixo"** do espaço de design? (dimensão de escolha independente — ex.: cópia vs. compartilhamento; bloqueante vs. lock-free; estático/`no_std` vs. heap)
- Qual o **critério** para considerar o espaço "catalogado"? (cada padrão safe mapeado às opções viáveis em `no_std`, com trade-offs anotados: custo de runtime, ergonomia, footprint, determinismo)
- Como o catálogo **alimenta o obj 4**? (cada eixo → um candidato a implementar na Aule — "um por eixo")

**Saída (entregável do obj 3):** o catálogo do espaço de design. **Fecha a parte da qualificação.**

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
  - `\subsection` eixos de design (atomics · lock/critical-section · message-passing · RTIC resources · owned-copy)
  - `\subsection` trade-offs em `no_std` (runtime · ergonomia · footprint · determinismo)
  - *(sem subseção)* **frase de fecho** do 4.4 (decisão 4/jun): ponte para o obj 4 — critério "um por eixo" + rastreabilidade. Não vira subseção própria.

Lembrete LaTeX: o capítulo já abre com `\mychapter{Metodologia Proposta}{...}`; dentro use `\section`/`\subsection` normais — **nunca** `\mychapter` de novo (ver `CLAUDE.md` → convenções da classe).
