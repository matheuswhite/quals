---
author: Claude (claude-opus-4-7)
created: 2026-05-20
modified:
  - 2026-05-20: Claude (claude-opus-4-7) — added LTeX disable magic comment
  - 2026-05-28: Claude (claude-opus-4-7) — added references on the cost of graph/self-referential structures in safe Rust
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

## Outros tópicos

A preencher conforme novas referências aparecerem (memory safety, Rust embedded, controle em linguagens type-safe, metodologia de pesquisa aplicada, etc.). Manter uma seção por tópico, em ordem alfabética dentro da seção.
