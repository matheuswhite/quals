---
author: Claude (claude-opus-4-7)
created: 2026-05-20
modified:
  - 2026-05-20: Claude (claude-opus-4-7) — added LTeX disable magic comment
  - 2026-05-28: Claude (claude-opus-4-7) — added references on the cost of graph/self-referential structures in safe Rust
  - 2026-06-01: Claude (claude-opus-4-8) — added a "Espaco de design" section (analysis method + synchronization design space + embedded Rust concurrency) to inform obj. 3
  - 2026-07-26: Claude (claude-opus-4-8) — added "Biblioteca vs. framework (Inversion of Control)" section (Fowler bliki + Johnson & Foote 1988); both already in referencias.bib and cited in 5.1
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

## Outros tópicos

A preencher conforme novas referências aparecerem (memory safety, Rust embedded, controle em linguagens type-safe, metodologia de pesquisa aplicada, etc.). Manter uma seção por tópico, em ordem alfabética dentro da seção.
