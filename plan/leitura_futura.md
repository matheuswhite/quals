---
author: Claude (claude-opus-4-7)
created: 2026-05-20
modified:
  - 2026-05-20: Claude (claude-opus-4-7) — added LTeX disable magic comment
  - 2026-05-28: Claude (claude-opus-4-7) — added references on the cost of graph/self-referential structures in safe Rust
  - 2026-06-01: Claude (claude-opus-4-8) — added a "Espaco de design" section (analysis method + synchronization design space + embedded Rust concurrency) to inform obj. 3
  - 2026-07-26: Claude (claude-opus-4-8) — added "Biblioteca vs. framework (Inversion of Control)" section (Fowler bliki + Johnson & Foote 1988); both already in referencias.bib and cited in 5.1
  - 2026-07-31: Claude (claude-opus-4-8) — added "Contextualização (cap. 1)" section with the 7 references added to referencias.bib on 2026-07-30/31; all cited in §1.1, so they enter as "read before the banca" (same exception as the IoC section)
  - 2026-08-02: Claude (claude-opus-4-8) — added "Distinção data race × race condition (3.3.3)" section with Netzer & Miller (1992) and Bishop & Dilger (1996); both in referencias.bib and cited in 3.3.3, so they enter as "read before the banca"
---

<!-- LTeX: enabled=false -->

# Leitura futura

Lista versionada de referências que vale ler **para informar a escrita** da tese — não para citar como conteúdo dela. Bibliografia do conteúdo está em `referencias.bib`.

Estrutura de cada entrada:

- **Referência:** citação completa
- **Por que importa:** ligação concreta com este trabalho (qual decisão ou capítulo informa)
- **Estado:** por ler / lendo / lido
- **Notas:** anotações curtas após leitura (opcional)

---

## Narrativa em escrita acadêmica

### Joshua Schimel — *Writing Science*

- **Referência:** Schimel, J. (2012). *Writing Science: How to Write Papers That Get Cited and Proposals That Get Funded*. Oxford University Press.
- **Por que importa:** introduz e defende o conceito de *story arc* em texto científico — setup, conflito, resolução. Base teórica para a camada narrativa (3 atos) registrada em [`outline_geral.md`](outline_geral.md). Trata o documento acadêmico não como descrição neutra do trabalho, mas como narrativa argumentativa com tensão controlada.
- **Estado:** por ler.

### John Swales — modelo CARS (*Create A Research Space*)

- **Referência:** Swales, J. M. (1990). *Genre Analysis: English in Academic and Research Settings*. Cambridge University Press. — capítulo sobre introduções de artigos científicos, onde o modelo CARS é apresentado.
- **Por que importa:** modelo de três movimentos para introdução acadêmica — (1) estabelecer território, (2) estabelecer nicho, (3) ocupar nicho. Mapeia diretamente sobre o micro-3-atos sugerido para a seção 1.1 (Contextualização) em [`outline_geral.md`](outline_geral.md).
- **Estado:** por ler.

---

## Custo de grafos e estruturas auto-referentes em Rust safe

Sustenta o argumento do ponto-de-virada (cap. 4): por que a alternativa *backward* (grafo resolvido a partir da saída) forçaria `Rc<RefCell>`/`unsafe`/arena e, com isso, abrir mão das garantias estáticas em `no_std`. Como o backward **não** foi implementado, este claim precisa ser ancorado em literatura, não em experiência própria. Estas entradas podem migrar para `referencias.bib` quando efetivamente citadas. **Confirmar URL/edição/data ao citar.**

### "Learn Rust With Entirely Too Many Linked Lists"

- **Referência:** rust-unofficial. *Learn Rust With Entirely Too Many Linked Lists.* (texto comunitário online; confirmar URL e data de acesso).
- **Por que importa:** demonstração pedagógica de por que estruturas ligadas/auto-referentes colidem com ownership e borrow checker, e quais as saídas (`Rc`, `RefCell`, `unsafe`, índices). É a evidência mais didática do custo do backward.
- **Estado:** por ler.

### The Rust Programming Language — cap. 15 (`Rc`, `RefCell`, ciclos de referência)

- **Referência:** Klabnik, S.; Nichols, C. *The Rust Programming Language.* No Starch Press (versão online oficial). Capítulo sobre `Rc<T>`, `RefCell<T>` e *Reference Cycles / `Weak<T>`* (confirmar número do capítulo na edição citada).
- **Por que importa:** documenta oficialmente que (a) compartilhar nós exige `Rc<RefCell>`, (b) `RefCell` move o borrow check para runtime (pode dar panic), (c) ciclos — como os de feedback — causam leak e exigem `Weak`. Exatamente os custos que o feedback de uma malha de controle imporia no modelo backward.
- **Estado:** por ler.

### Matsakis — modelagem de grafos com índices de vetor

- **Referência:** Matsakis, N. *Modeling graphs in Rust using vector indices.* (post no blog "Baby Steps", ~2015; confirmar data e URL).
- **Por que importa:** apresenta a saída idiomática "arena + índices" para grafos em Rust e explica o trade-off — segurança contra UB, mas a integridade da referência vira responsabilidade do índice (análogo lógico do dangling). Sustenta o ponto de que arena é garantia *mais fraca* que a do sistema de tipos.
- **Estado:** por ler.

### Crates de arena com geração (`slotmap`, `generational-arena`)

- **Referência:** documentação dos crates `slotmap` e/ou `generational-arena` (docs.rs; confirmar versão).
- **Por que importa:** mostram a versão madura da arena, com *generations* para detectar índices obsoletos em runtime. Reforça o argumento: mesmo a melhor saída backward reintroduz uma verificação (de geração) em runtime que o modelo forward dispensa por construção.
- **Estado:** por ler.

## Espaço de design (design space)

Informa o obj. 3 (catalogar o **espaço de design** dos meios de implementar a sincronização que a garantia força no lado safe) e o critério "um por eixo do espaço de design" do obj. 4 (ver F19 em [`banca_pergunta_pesquisa.md`](banca_pergunta_pesquisa.md)). Cobre o *método* de estruturar/apresentar um espaço de design, o *conteúdo* (o espaço da sincronização) e sua concretização em Rust embarcado. **Confirmar URL/edição/data ao citar.**

### Herlihy & Shavit — *The Art of Multiprocessor Programming*

- **Referência:** Herlihy, M.; Shavit, N. *The Art of Multiprocessor Programming.* Morgan Kaufmann (confirmar edição — Revised Reprint 2012; há 2ª ed. 2020 com Luchangco e Spear).
- **Por que importa:** mapeia o espaço de design da sincronização — locks, lock-free, wait-free — e os trade-offs de progresso/custo entre eles. É o conteúdo técnico que o catálogo do obj. 3 enumera, e ancora a tensão "lock-free safe × `Mutex`" registrada em [`recorte_tese.md`](recorte_tese.md) (falsificabilidade da Q2: o custo da sincronização forçada).
- **Estado:** por ler.

### MacLean, Young, Bellotti & Moran — QOC / *Design Space Analysis*

- **Referência:** MacLean, A.; Young, R. M.; Bellotti, V. M. E.; Moran, T. P. (1991). "Questions, Options, and Criteria: Elements of Design Space Analysis." *Human–Computer Interaction*, 6(3–4), 201–250 (confirmar páginas/DOI).
- **Por que importa:** define o *método* de análise de espaço de design — Questions (eixos de decisão), Options (alternativas) e Criteria (critérios de escolha). É o arcabouço para estruturar o obj. 3: cada eixo = uma Question, cada meio = uma Option, custo/deadline/ergonomia = Criteria. Também fundamenta o critério "um por eixo" do obj. 4.
- **Estado:** por ler.

### RTIC — *Real-Time Interrupt-driven Concurrency*

- **Referência:** *RTIC — Real-Time Interrupt-driven Concurrency* (livro/documentação do framework; rtic.rs — confirmar versão e data de acesso).
- **Por que importa:** documenta o espaço de design concreto de concorrência **safe** em Cortex-M — recursos compartilhados, prioridades, seções críticas e a troca ISR↔tarefa. É o lado embarcado dos "meios" do obj. 3 e do caso de reconfiguração de parâmetros, e conecta com a plataforma do experimento (Cortex-M0, obj. 5). Relacionados a confirmar/considerar: crates `critical-section`, `heapless` (fila SPSC) e os atômicos de `core::sync::atomic`.
- **Estado:** por ler.

## Biblioteca vs. framework (Inversion of Control)

Sustenta o argumento da §5.1 (`sec:aule-state`): por que a Aule é biblioteca e não framework, ancorado no conceito de *Inversion of Control* (quem chama quem / Hollywood Principle). **Exceção ao propósito do arquivo:** as duas já estão em `referencias.bib` e citadas na 5.1 — entram aqui como *leitura a validar antes da banca* (Regra 7: ler o que se cita), não como leitura-só-para-informar.

### Fowler — *Inversion of Control* (bliki)

- **Referência:** Fowler, M. (2005). *Inversion of Control.* Bliki. `\cite{martin-fowler:inversion-of-control}` — https://martinfowler.com/bliki/InversionOfControl.html
- **Por que importa:** formulação acessível de "quem chama quem" + Hollywood Principle + a distinção biblioteca/framework usada na l. 20 da 5.1. Fonte web (não peer-reviewed) — pareá-la com Johnson & Foote para peso acadêmico.
- **Estado:** por ler.

### Johnson & Foote — *Designing Reusable Classes*

- **Referência:** Johnson, R. E.; Foote, B. (1988). "Designing Reusable Classes." *Journal of Object-Oriented Programming*, 1(2), 22–35. `\cite{johnson1988reusable}`.
- **Por que importa:** origem peer-reviewed do conceito — cunhou o termo e a observação de que os métodos definidos pelo usuário são chamados de dentro do framework. É a citação que blinda o flanco "IoC não é do Fowler" na banca.
- **Estado:** por ler.

---

## Contextualização (cap. 1) — citadas na §1.1, a validar antes da banca

As sete entradas adicionadas a `referencias.bib` em 30–31/jul/2026 para a Contextualização. **Mesma exceção da seção de IoC acima:** já estão citadas no texto, então entram aqui como *leitura obrigatória antes da banca* (Regra 7 — ler o que se cita), não como leitura-só-para-informar. Metadados foram confirmados em fonte primária; o que **não** foi confirmado é se o conteúdo de cada obra sustenta a afirmação que ela ancora — é isso que a leitura tem de fechar.

### Ogata — *Engenharia de Controle Moderno*

- **Referência:** Ogata, K. (2010). *Engenharia de Controle Moderno.* 5. ed. São Paulo: Pearson Prentice Hall. ISBN 978-85-7605-810-6. `\cite{book:ogata}`
- **Por que importa:** ancora a teoria de controle na abertura da §1.1 (malha fechada, referência/setpoint, controle digital). É a única referência de controle "clássico" da introdução.
- **Estado:** por ler.
- **Pendência:** confirmar a **edição efetivamente consultada** — a entrada assume a 5ª brasileira. Se foi outra (ou a original *Modern Control Engineering*), corrigir `edition`/`publisher`/`year`/`isbn`.

### Buttazzo — *Hard Real-Time Computing Systems*

- **Referência:** Buttazzo, G. C. (2011). *Hard Real-Time Computing Systems: Predictable Scheduling Algorithms and Applications.* 3. ed. New York: Springer (Real-Time Systems Series). ISBN 978-1-4614-0675-4. `\cite{book:deadline-requirement}`
- **Por que importa:** sustenta a afirmação central do primeiro parágrafo da §1.1 — deadline como **requisito**, não meta, e a distinção hard/soft/firm com a consequência da falha. É o que separa "perder deadline num desktop" de "perder deadline numa planta".
- **Estado:** por ler.
- **Pendência:** confirmar edição (há 1ª/1997, 2ª/2005, 3ª/2011, 4ª/2024) e localizar a passagem exata que define deadline no contexto de controle, para poder citar capítulo/seção na arguição.

### MISRA C:2012

- **Referência:** MISRA (2013). *MISRA C:2012 — Guidelines for the Use of the C Language in Critical Systems.* 3. ed. Nuneaton: MIRA Limited. ISBN 978-1-906400-10-1. `\cite{doc:MISRA}`
- **Por que importa:** é a fonte primária do argumento do terceiro parágrafo da §1.1 e da §4.7.2 — MISRA força C disciplinado, mas é convenção apoiada em análise estática incompleta e **não automatiza a eliminação de data race**.
- **Estado:** por ler.
- **Pendência (decisão):** escolher a versão que o trabalho adota — MISRA C:2012 (2013), *Third Edition First Revision* (2019, com Amendments 1/2) ou **MISRA C:2023**. Hoje o texto diz apenas "o padrão MISRA". Ao fixar, verificar se alguma regra trata explicitamente de concorrência/acesso compartilhado — é o ponto que a banca pode cobrar.

### Serebryany & Iskhodzhanov — ThreadSanitizer

- **Referência:** Serebryany, K.; Iskhodzhanov, T. (2009). "ThreadSanitizer: data race detection in practice." In: *Proceedings of the Workshop on Binary Instrumentation and Applications (WBIA '09)*, pp. 62–71. ACM. DOI 10.1145/1791194.1791203. `\cite{doc:TSan}`
- **Por que importa:** paper original do TSan. Ancora os limites do sanitizer na §1.1 (cobertura dinâmica: só pega o que é exercitado) e é a mesma ferramenta cuja saída real aparece na listagem `code:tsan-out` da §5.2.2. Também sustenta a §4.7.3.
- **Estado:** por ler.
- **Pendência:** confirmar no paper o que ele afirma sobre **cobertura** e sobre o algoritmo híbrido (happens-before + lockset) — a §1.1 e a §4.7.3 afirmam limites que devem sair do texto, não de senso comum.

### Jung, Jourdan, Krebbers & Dreyer — *Safe Systems Programming in Rust*

- **Referência:** Jung, R.; Jourdan, J.-H.; Krebbers, R.; Dreyer, D. (2021). "Safe Systems Programming in Rust." *Communications of the ACM*, 64(4), 144–152. DOI 10.1145/3418295. `\cite{article:rust-safe-soundness}`
- **Por que importa:** fonte peer-reviewed para o mecanismo do quarto parágrafo da §1.1 — ownership/borrowing proibindo estaticamente a mutação de estado compartilhado, e `unsafe` encapsulado em APIs. **Cobre também** a citação que faltava na §4.3.2 (soundness do subconjunto safe) e serve à §4.7.3. Linha RustBelt; se for preciso o argumento formal, o par é *RustBelt* (POPL 2018).
- **Estado:** por ler.
- **Pendência:** a `\cite` no `.tex` ainda está como `url:rust-safe-soundess` (typo em *soundness* + prefixo `url:` para artigo) — trocar para `article:rust-safe-soundness`.

### Pinho, Couto & Oliveira — *Towards Rust for Critical Systems*

- **Referência:** Pinho, A.; Couto, L.; Oliveira, J. (2019). "Towards Rust for Critical Systems." In: *2019 IEEE International Symposium on Software Reliability Engineering Workshops (ISSREW)*, pp. 19–24. IEEE. `\cite{article:rust-critical}`
- **Por que importa:** analisa **quais guidelines de codificação segura em C (MISRA) o Rust dispensa por construção** — é o interlocutor acadêmico do argumento MISRA → verificação por tipos da §1.1 e da §4.7. Hoje esse argumento não tem ninguém na literatura.
- **Estado:** por ler.
- **⚠️ Citação mal alocada:** está citada na §1.1 para "mantém controle sobre recursos e **baixa utilização de recursos**" — afirmação de desempenho/footprint que este paper **não** sustenta. Mover a `\cite` para a passagem sobre MISRA e buscar outra fonte (comparação de desempenho/footprint Rust vs C) para a alegação de recursos.
- **Pendência:** DOI não confirmado (Xplore e CSDL bloquearam leitura automática) — pegar no IEEE Xplore, doc. 8990314, e acrescentar o campo `doi`.

### Mabin — anúncio do esp-hal 1.0.0-beta

- **Referência:** Mabin, S. (fev. 2025). *esp-hal 1.0.0 beta announcement.* Espressif Developer Portal. https://developer.espressif.com/blog/2025/02/rust-esp-hal-beta/ `\cite{url:esp-rust-no-std-stable}`
- **Por que importa:** ancora o "por que agora" da §1.1. Confirmado na fonte (post de 24/fev/2025): é o **primeiro SDK Rust com apoio do fabricante**, após ~6 anos, e marca a estabilização de API com foco exclusivo nos crates `no_std` (os crates de port da `std` passam a *community-supported*). Foi por isso que a data no texto migrou de "2023–2024" para **2025**.
- **Estado:** lido (verificado nesta sessão para confirmar a data).
- **Nota:** é fonte web, não peer-reviewed. Se a banca cobrar peso acadêmico no "por que agora", o par possível é a literatura de Rust em embarcado — *Rust for Embedded Systems: Current State and Open Problems* (CCS 2024) apareceu na busca e não foi triado.

---

## Distinção data race × race condition (3.3.3) — citadas, a validar antes da banca

As duas entradas adicionadas a `referencias.bib` em 02/ago/2026 para a subseção 3.3.3. **Mesma exceção das seções de IoC e Contextualização:** já estão citadas no texto, então entram aqui como *leitura obrigatória antes da banca* (Regra 7 — ler o que se cita), não como leitura-só-para-informar. Metadados confirmados em fonte primária; o que a leitura tem de fechar é se o conteúdo sustenta a afirmação que cada uma ancora.

### Netzer & Miller — *What Are Race Conditions? Some Issues and Formalizations*

- **Referência:** Netzer, R. H. B.; Miller, B. P. (1992). "What Are Race Conditions? Some Issues and Formalizations." *ACM Letters on Programming Languages and Systems (LOPLAS)*, 1(1), 74–88. DOI 10.1145/130616.130623. `\cite{article:netzer-miller-races}`
- **Por que importa:** fonte canônica que formaliza *general race* (= race condition) × *data race*. Ancora a definição de race condition (3.3.3 l. 50) e a afirmação de assimetria (l. 52), e por consequência sustenta o recorte estrito da taxonomia (a 3.3.3 fecha justificando a 4.2.1).
- **Estado:** por ler.
- **Pendência (a fechar na leitura — a banca fura aqui):** confirmar **como** o paper formaliza a relação entre os dois conceitos — se afirma continência (*data race* ⊂ *race condition*) ou interseção sem continência. Isso decide se a 3.3.2 ("data race contido dentro de race condition") e a 3.3.3 (assimetria "RC sem DR") ficam alinhadas com a fonte ou precisam ser reformuladas. Ver a discussão de topologia registrada na revisão da 3.3.3.

### Bishop & Dilger — *Checking for Race Conditions in File Accesses*

- **Referência:** Bishop, M.; Dilger, M. (1996). "Checking for Race Conditions in File Accesses." *Computing Systems*, 9(2), 131–152. USENIX Association. `\cite{article:bishop-dilger-toctou}`
- **Por que importa:** origem do termo TOCTOU (*time-of-check-to-time-of-use*). Ancora a nomenclatura do padrão *check-then-act* / TOCTOU na 3.3.3 l. 52.
- **Estado:** por ler.
- **Ressalva/Pendência:** o estudo é sobre corridas em **acesso a arquivos Unix** (segurança), não controle embarcado. A leitura tem de confirmar que a definição de TOCTOU transfere para o cenário ISR×tarefa sem distorção (o conceito é a janela entre *check* e *use*, independente do recurso) — e ter essa resposta pronta caso a banca cobre "isso é de arquivos, não de controle".

---

## Outros tópicos

A preencher conforme novas referências aparecerem (memory safety, Rust embedded, controle em linguagens type-safe, metodologia de pesquisa aplicada, etc.). Manter uma seção por tópico, em ordem alfabética dentro da seção.
