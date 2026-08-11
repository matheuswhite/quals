<!-- ---
author: Claude (claude-opus-5)
created: 2026-08-10
modified:
  - 2026-08-10: Claude (claude-opus-5) — mapa inicial das copias baixadas + cruzamento com as 32 chaves citadas no .tex
  - 2026-08-10: Claude (claude-opus-5) — removidas as obras SEM \cite; entradas novas organizadas (Buttazzo incompleto e Stallings so-capa sinalizados com _PROBLEMA-)
  - 2026-08-10: Claude (claude-opus-5) — reescrito como GUIA DE LEITURA a pedido do Matheus: por obra, apenas o recorte que ele tem de ler antes da qualificacao (21/ago)
  - 2026-08-10: Claude (claude-opus-5) — Buttazzo substituido (Liu & Layland + Lee & Seshia, aval do Matheus); Liu & Layland entra na lista com o recorte; arquivos obsoletos (parcial do Buttazzo, candidato Maggio) removidos
  - 2026-08-10: Claude (claude-opus-5) — Liu & Layland conferido (JACM 20(1):46-61, 16 p) e movido para 05-contextualizacao-cap1/; recorte refinado apos ler a 1a pagina; Stallings segue faltando (md5 confirma que o arquivo e a mesma capa renomeada); registrada a alternativa de reduzir a l.19 a book:lee-seshia
  - 2026-08-10: Claude (claude-opus-5) — troca de citacao aplicada no .tex (autorizada); numeros de linha do cap. 1 e 3 atualizados (+4)
--- -->

<!-- LTeX: enabled=false -->

# O que ler de cada obra — qualificação 21/ago/2026

Pasta não versionada (só este `README.md` entra no git). Cada linha é **uma obra citada no
`.tex`** e o **recorte mínimo** que sustenta a sua frase. Recorte confirmado onde há número de
seção; onde diz "localizar", o ponto exato se acha pelo sumário na hora da leitura.

Seções pela numeração real do `.tex` (1 introdução · 3 fundamentação · 4 metodologia ·
5 resultados). Os `plan/*.md` usam a numeração antiga do outline.

**Números de linha (10/ago, pós-troca de citação):** `introducao.tex` e `fundamentacao.tex` ganharam
4 linhas de cabeçalho cada — as citações desses dois arquivos desceram 4 linhas (ex.: a de deadline
era l.13, hoje é **l.17**; a de escalonador era l.21, hoje é **l.25**). Os outros capítulos não
mudaram.

## Cap. 1 — Contextualização

| Obra | Arquivo | O que ler |
|---|---|---|
| **Liu & Layland (1973)** — *Scheduling Algorithms for Multiprogramming in a Hard-Real-Time Environment* (16 p) | `05-.../liu-layland-1973-scheduling-hard-real-time.pdf` | **Abstract + §1 Introdução** — é onde está o que a sua frase precisa: o paper se motiva em **controle e monitoramento de processos industriais**, define o cenário de funções que exigem *guaranteed service* e trata deadline como restrição a garantir (não meta). Os teoremas de escalonabilidade (prioridade fixa ótima, limite de ~70% de utilização, *deadline driven*) são contexto — só se quiser citar o mecanismo. **Entrou em 10/ago substituindo o Buttazzo** (`article:liu-layland-hard-real-time`) |
| **Jung et al. (2021)** — *Safe Systems Programming in Rust* (12 p) | `05-.../jung-2021-...pdf` | "Key Insights" (p. 1) + a seção de **ownership/borrowing** (proibição estática de mutar estado compartilhado) + a de **`unsafe` encapsulado em APIs safe**. Cobre as 4 citações desta obra (§1.1, §3.1.2, §3.1.3, §4.3.2) — é curto, ler inteiro rende |
| **Serebryany & Iskhodzhanov (2009)** — *ThreadSanitizer* (10 p) | `05-.../serebryany-2009-...pdf` | §1 Introdução · §2 Related Work (estático × on-the-fly × postmortem) · a seção do **algoritmo híbrido** (happens-before + lockset) · a de limitações/uso prático. **Alvo:** confirmar no texto o limite de **cobertura dinâmica** (só pega o que é exercitado) que a §1.1 e a §4.7.3 afirmam |
| **Pinho et al. (2019)** — *Towards Rust for Critical Systems* (6 p) | `05-.../pinho-2019-...pdf` | Inteiro, com foco na parte que mapeia **quais guidelines MISRA o Rust dispensa por construção**. É essa passagem que a citação deveria ancorar (hoje ela está na frase de recursos — realocar) |
| **Mabin (2025)** — anúncio do esp-hal 1.0.0-beta | `05-.../blog/2025/02/rust-esp-hal-beta/index.html` | O parágrafo do **primeiro SDK Rust com apoio do fabricante** e o do foco exclusivo em `no_std`. Já lido/verificado (data: 24/fev/2025) |

## Cap. 3 — Fundamentação

| Obra | Arquivo | O que ler |
|---|---|---|
| **Lee & Seshia (2017)** — *Introduction to Embedded Systems* (livro, 30 MB) | `09-.../lee-seshia-...-v2_3.pdf` | **Dois capítulos, não o livro:** o de **Input and Output** (interrupções/ISR e DMA) e o de **Multitasking/Scheduling** (preempção; escalonador cooperativo). Localizar pelo sumário |
| **Eriksson et al. (2013)** — *RTFM, Step 1* (4 p) | `09-.../eriksson-2013-rtfm-step1-sies.pdf` | Inteiro (4 páginas). Ancora ISR/tarefa em §3.1.1 e a alternativa de sincronização em §4.4.1 |
| **Boehm & Adve (2008)** — *Foundations of the C++ Concurrency Memory Model* (11 p) | `07-.../boehm-adve-2008-...pdf` | A seção que **define data race** e a que estabelece o **happens-before** como a ordenação dada pelo modelo de memória — é o que as l. 35 e 37 afirmam |
| **Adve & Boehm (2010)** — *Memory Models: A Case for Rethinking…* (9 p) | `07-.../adve-boehm-2010-...pdf` | Introdução + a seção sobre **o que é um modelo de memória** / data-race-free. Papel de contexto, ao lado do de 2008 |
| **WG14 N1570 (C11)** — draft (701 p) | `07-.../wg14-n1570-c11-draft.pdf` | **Só §5.1.2.4, parágrafo 25** (+ as definições vizinhas da §5.1.2.4). É de lá que saem as **4 cláusulas** do data race e o UB. Nada mais do documento |
| **Netzer & Miller (1992)** — *What Are Race Conditions?* (15 p) | `06-.../netzer-miller-1992-...pdf` | As definições de **general race** e **data race** e, principalmente, a seção que **relaciona os dois**. **Alvo:** decidir se o paper afirma continência (DR ⊂ RC) ou interseção — disso depende a redação da §3.1.2 e a assimetria da §3.1.3. É o furo mais provável da banca aqui |
| **Bishop & Dilger (1996)** — *Checking for Race Conditions in File Accesses* (22 p) | `06-.../bishop-dilger-1996-...pdf` | Só o trecho inicial onde **definem TOCTOU** (janela entre *check* e *use*). O resto é ferramenta para arquivos Unix. **Alvo:** ter pronta a resposta de por que o conceito transfere para ISR × tarefa |

## Cap. 4 — Metodologia

| Obra | Arquivo | O que ler |
|---|---|---|
| **Bos (2023)** — *Rust Atomics and Locks* | `03-.../bos-atomics-and-locks/inspiration.html` | O capítulo **Ideas and Inspiration** → seção **Seqlock**. **Alvo:** confirmar que ela sustenta "snapshot e publicação" como a §4.4.1 descreve. Base opcional: o capítulo de *memory ordering* |
| **Docs oficiais do Rust** | `08-docs-oficiais-rust/` | Só as visões gerais de `std::sync::atomic`, `Mutex` e `mpsc` (os 3 slots da §4.4.1) e, no **Error Index**, apenas os códigos citados na §4.3.2: **E0277** (Send/Sync) e **E0499, E0502, E0505, E0382, E0373, E0597** (borrow/ownership) |

## Cap. 5 — Resultados Parciais

| Obra | Arquivo | O que ler |
|---|---|---|
| **Fowler (2005)** — *Inversion of Control* | `04-.../bliki/InversionOfControl.html` | Inteiro (é curto): "quem chama quem", Hollywood Principle, biblioteca × framework |
| **Johnson & Foote (1988)** — *Designing Reusable Classes* | `04-.../drc/drc.html` | Só a parte sobre **frameworks** — a observação de que os métodos definidos pelo usuário são chamados **de dentro** do framework (origem do IoC). Não o artigo todo |

## Ainda falta o arquivo — **1 obra**

| Obra | O que ler | Situação |
|---|---|---|
| **Stallings** — *Computer Organization and Architecture* | O **capítulo de I/O**: seções de **I/O dirigido por interrupção** e de **DMA** | O arquivo `William Stallings - Computer Organization and Architecture D.pdf` **não é o livro**: 2 páginas, é a **capa** da 8ª ed. Verificado por md5 em 10/ago às 22:37 — é o mesmo arquivo de 22:14, apenas renomeado |

⚠️ **Conferir edição ao ler**: o `.bib` assume Stallings **11ª ed./2021**; a capa que veio é da
**8ª**. Se a cópia lida for a 8ª, `edition`/`year`/`publisher`/`isbn` mudam.

**Alternativa, se o livro não vier:** a §3.1.1 cita Stallings junto com `book:lee-seshia` na mesma
linha (l.23), e o capítulo de **Input and Output** do Lee & Seshia — que **está** na pasta — cobre
interrupções e DMA. Reduzir a l.23 a `book:lee-seshia` é uma saída análoga à que resolveu o
Buttazzo. Custo: perde-se a âncora de arquitetura no nível de organização de computadores.

### Buttazzo — fora da lista (substituído em 10/ago)

Sem acesso ao livro, o Matheus aprovou a **opção 1 + 2** da rodada 4 de
`plan/triagem_referencias.md`: a frase de deadline (§1.1) passa a citar **Liu & Layland** e a de
escalonador preemptivo × cooperativo (§3.1.1) passa a citar **Lee & Seshia**, que já está aqui.
**Aplicado no `.tex` em 10/ago** (troca autorizada por ele, suspensão pontual da Regra 3):
`introducao.tex:17` → `article:liu-layland-hard-real-time` e `fundamentacao.tex:25` →
`book:lee-seshia`. `book:deadline-requirement` é hoje a **única entrada órfã** do `.bib` e, sem
`\nocite{*}`, não é impressa. **Nada do Buttazzo precisa ser lido.**

⚠️ **Ressalva confirmada na leitura da 1ª página (10/ago):** o paper **ajuda mais do que se
supunha** — abre motivando em *"computers for control and monitoring of industrial processes"* e
fala de funções que exigem *guaranteed service*, o que ancora bem "deadline como requisito" em
contexto de controle. Mas ele **não** faz a taxonomia hard/soft/firm nem a consequência **física**
de perder deadline (planta instável, marca-passo em arritmia). Como a `\citep` da §1.1 está hoje no
fim da frase da consequência física, considerar movê-la para a frase anterior (período fixo +
definição de deadline), que é o que a fonte sustenta.

## Não vai ler agora — decisão dele (10/ago)

Citadas, mas fora do escopo da qualificação. Ficam para depois; não estão na pasta.

| Obra | O que seria preciso ler | Risco assumido |
|---|---|---|
| **Ogata** — *Engenharia de Controle Moderno* | capítulos de malha fechada/referência + o de controle digital (§1.1 l.17) | baixo: teoria de controle consolidada |
| **Wazlawick** — *Metodologia de pesquisa para CC* | **seção 2.6** (as 3 classes de pesquisa) — a própria `\citep` já diz | baixo: a classificação está declarada na citação |
| **MISRA C:2012** | as regras que tratam de concorrência/acesso compartilhado, se existirem (§1.1 l.21) | baixo: a afirmação relevante tem `article:rust-critical` como interlocutor, e esse **está** na pasta |

## Outras ressalvas de conferência

- **Jung et al.** é a versão de autor (*"The Promise and the Challenge"*), não o PDF da CACM:
  paginação difere das pp. 144–152 do `.bib`.
- **Lee & Seshia**: o PDF gratuito é a release **v2.3** da 2ª edição; numeração de seções pode
  diferir da impressa.
- **N1570** é draft público com redação idêntica à ISO/IEC 9899:2011 — já registrado assim no `.bib`.
- Toda cópia foi conferida por contagem de páginas contra a paginação do `.bib` (Netzer & Miller
  15 p · Pinho 6 p · Eriksson 4 p · TSan 10 p · Boehm & Adve 11 p · Adve & Boehm 9 p · N1570 701 p).
- `furuta-plant` (§4.6.1) é repositório privado — nada a ler; o `.bib` já o cita apenas como
  origem do valor de 2 ms.
- Obras **sem `\cite`** foram removidas da pasta em 10/ago (Herlihy & Shavit, QOC/MacLean, tese
  TR-1039 do Netzer, *Too Many Linked Lists*, Rust Book cap. 15, Matsakis, `slotmap`,
  `generational-arena`, RTIC book). São leitura de apoio a objetivos 3/4, para depois da banca —
  todas recuperáveis pelas URLs registradas no histórico deste arquivo (git).
