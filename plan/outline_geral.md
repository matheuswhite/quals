---
author: Claude (claude-opus-4-7)
created: 2026-05-20
modified:
  - 2026-05-20: Claude (claude-opus-4-7) — added narrative (3-act) layer mapping each chapter to its dramaturgical function
  - 2026-05-20: Claude (claude-opus-4-7) — added LTeX disable magic comment
  - 2026-05-28: Claude (claude-opus-4-7) — recorded research framing (hybrid, B-dominant); propagated implications to chapters 1–5 and transversal axes
  - 2026-05-28: Claude (claude-opus-4-7) — resolved Act 2 turning point (forward composition + Signal monoid); recorded its memory-safety rationale and feedback trade-offs
  - 2026-05-28: Claude (claude-opus-4-7) — added 5th transversal axis (verification displacement, B-pure); noted forward as enabler (not proof) of B in ch.4
  - 2026-05-28: Claude (claude-opus-4-7) — closed scope decisions for the qualification; recorded project state (experiment = protocol only, hardware undecided, partial workload)
---

<!-- LTeX: enabled=false -->

# Outline geral da dissertação

Documento de planejamento. Descreve o **papel** de cada capítulo/seção e as **perguntas que cada parte precisa responder** — não contém prosa nem rascunho de texto. Iterar conforme o trabalho avança.

Referências cruzadas:
- Estrutura física do documento: `main.tex` e arquivos em `capitulos/`, `pre-textuais/`, `pos-textuais/`.
- Roadmap técnico da biblioteca: [`aule_roadmap.md`](aule_roadmap.md).
- Fundamentos de memory safety em Rust: [`rust_memory_safety_em_controle.md`](rust_memory_safety_em_controle.md).

---

## Enquadramento da pesquisa (decidido — 2026-05-28)

Decisão: **híbrido com hierarquia B-dominante.**

- **Tese (fim):** a afirmação de que Rust elimina, por construção, classes de bug de memória relevantes em controle embarcado. É o que a pergunta de pesquisa persegue e o critério de sucesso mede.
- **Aule (meio):** a biblioteca é pré-requisito de viabilidade — dá realismo aos casos demonstrativos (delay line, ISR↔DMA, workspace de MPC) em vez de exemplos de brinquedo. Não é a contribuição central.

Consequências que valem para todo o resto do outline:

- **Pergunta de pesquisa:** gira em torno de memory safety em controle embarcado. (Matheus redige a formulação final — ver 1.2.)
- **Critério de sucesso:** demonstrar a eliminação de classes de bug (experimento C-vs-Rust + invariantes provados), mesmo que a toolbox fique incompleta.
- **Regra de corte sob prazo:** sob pressão até jul/2026, corta-se profundidade/abrangência de features de controle (LQR, MPC avançado, root locus), **nunca** o experimento de segurança nem os casos demonstrativos.
- **O que isto NÃO é:** não é uma tese de "toolbox de controle em Rust". Paridade com MATLAB/`python-control` é validação de que o veículo funciona, não o objetivo.

Resolve o item transversal 3 (título "Towards memory safety…" coerente com B) e orienta 1.2 (objetivos).

---

## Decisões fechadas — escopo da qualificação (2026-05-28)

Estado de partida: ~28/mai/2026; qualificação em julho/2026 (~9 semanas); dedicação **parcial** (seg/qua/qui à noite + sábado de manhã, ~10–12 h/semana). Princípio que decide os recortes: **a qualificação defende proposta + resultados parciais + protocolo do experimento; o experimento completo e a toolbox madura ficam para a dissertação.**

### Recortes de escopo (assumidos sob o prazo — ajustar se discordar)
- **Cap. 1 abertura:** incidentes documentados (Toyota UA, Therac-25, Ariane 5, MCAS) como motivação.
- **Cap. 2 Ada/SPARK:** uma subseção como comparável conceitual mais próximo; sem aprofundar.
- **Cap. 3 Rust conceitual:** seção dedicada (ownership/borrow/lifetimes), não diluída em Eng. de Software. Ordem: classes de bug → ownership → A&OC mínimo → `no_std`/embedded.
- **Cap. 4 Aule:** produto único focado nos casos; **não** plataforma extensível.
- **Cap. 4 critérios:** eixos primários já fechados (4.6); números refinados na dissertação.

### Estado real do projeto (decide o cap. 5)
- **Experimento de segurança (C+FreeRTOS vs Rust+RTIC + sanitizers):** apenas **conceito/protocolo** — nada implementado. → cap. 4 descreve o método; cap. 5 apresenta o **protocolo**, não dados.
- **Hardware-alvo:** **indefinido.** → para a qualificação, plano = simulação em host + HIL via probe-rs (já na Aule); placa específica é decisão da fase de execução. Não bloqueia.
- **Resultado parcial real (cap. 5):** (a) estado atual da Aule — já substancial, ver [`aule_roadmap.md`](aule_roadmap.md); (b) **casos demonstrativos** (os 3 de [`rust_memory_safety_em_controle.md`](rust_memory_safety_em_controle.md), como código que compila/não-compila) — evidência por construção, qualitativa, já fazível; (c) protocolo do experimento. Sem medições.

### Consequência para o cap. 6
O cronograma é o roadmap de escrita até julho, em arquivo próprio (`plan/roadmap_escrita.md`, a montar). Carga parcial × 9 semanas exige priorização dura.

---

## Eixos transversais

Antes do detalhamento capítulo a capítulo, três fios que precisam aparecer em mais de um lugar e amarrar o trabalho:

1. **Tripé do tema** — *sistemas de controle* × *segurança de memória* × *sistemas embarcados / `no_std`*. Cada capítulo precisa indicar qual(is) vértice(s) está abordando e como se conecta ao outro.
2. **Biblioteca vs. framework** — decisão de design recorrente. Aparece em Introdução (como diferencial), Metodologia (como princípio de projeto), Resultados (como o que foi entregue), Conclusão (como contribuição).
3. **Garantia por construção (tipos) vs. garantia em tempo de execução (testes/runtime)** — distinguir o que Rust dá de graça do que precisa ser desenhado ativamente.
4. **Fronteira do que Rust garante vs. não garante** — a tese só é honesta se disser onde a memory safety do Rust **não** ajuda (stack overflow, erros lógicos, `unsafe` em FFI/HAL, panic em embarcado). Ver `rust_memory_safety_em_controle.md` §"Onde memory safety não ajuda". Aparece em cap. 3 (delimitação conceitual) e cap. 4/5 (honestidade do experimento). Sob enquadramento B, este eixo é o que protege a tese de soar exagerada.
5. **Deslocamento da verificação** — o que em C/C++ é convenção informal não-verificada (inicializar antes de ler, não reter ponteiro além da vida do dono, sincronizar acesso compartilhado entre contextos) torna-se, em Rust, obrigação codificada no tipo e checada em compilação. O esforço de garantir ausência de uma classe de bug migra de revisão humana + ferramentas externas (sanitizers em runtime, análise estática externa) para o sistema de tipos. É o argumento central de B (ver `rust_memory_safety_em_controle.md` §"Argumento para a tese"). Atravessa cap. 2 (vs. abordagens que verificam em runtime/análise externa), cap. 3 (ownership/borrow) e cap. 5 (o experimento mede esse deslocamento). **Nota:** este eixo é a versão B-pura de uma ideia que começou misturada com A ("explícito > implícito"); a parte "explícito para o desenvolvedor" (forward, `last_output` legível) é A e vive no ponto-de-virada do cap. 4, não aqui.

---

## Camada narrativa (3 atos)

A estrutura formal (cap. 1-7) é o **esqueleto institucional** — o que aparece no sumário. A camada narrativa abaixo é o **fluxo argumentativo** — o que organiza a leitura. Atos não substituem capítulos; correm por baixo deles. Cada capítulo é anotado adiante com seu **Ato narrativo** indicando a função dramatúrgica.

Referências para esta abordagem: Joshua Schimel, *Writing Science* (story arc em texto científico); John Swales, modelo CARS (3 movimentos para introdução acadêmica).

### Mapa cap. → ato

| Ato | Capítulos | Função dramatúrgica |
|---|---|---|
| **1 — Setup** | 1, 2, 3 | Mundo, tensão, pergunta motora |
| **2 — Confrontation** | 4 e parte de 5 | Tentativa, complicações, ponto-de-virada |
| **3 — Resolution** | restante de 5, 6, 7 | Evidência, contribuição, gancho |

Cap. 5 (Resultados Parciais) atravessa Atos 2 e 3 — primeira metade exibe a tentativa funcionando (Ato 2); segunda metade sintetiza evidência (Ato 3). Marcar essa fronteira explicitamente quando o capítulo for refinado.

### Tensão central que sustenta a narrativa

Sistemas de controle críticos rodam em software cuja pilha (C/C++ + paliativos como MISRA, fuzzing, code review) não elimina classes inteiras de bug por construção. Rust elimina, mas seu ecossistema de controle ainda é raso para o domínio embarcado `no_std`. **A pergunta que abre o Ato 1 e a tese só fecha no Ato 3:** dá pra ter memory safety por construção em controle embarcado sem abrir mão de ergonomia e expressividade?

### Como usar este mapa

- **Filtro de escopo:** ao decidir se um trecho entra/sai, perguntar "que ato ele serve, e como?". Resposta "nenhum" → cortar.
- **Filtro de tom:** Ato 1 estabelece e provoca; Ato 2 explora e admite dificuldades; Ato 3 sintetiza e aponta. Tom errado pro ato derrapa a leitura.
- **Identificar o ponto-de-virada (midpoint do Ato 2):** decisão de design da Aule que destrava o restante. Precisa estar **explícita** no cap. 4 — banca cobra "qual foi a decisão difícil, e por que assim?". → **RESOLVIDO:** composição forward + `Signal` (monoid); ver cap. 4.

---

## Capítulo 1 — Introdução

**Função:** convencer leitor (e banca) de que o problema existe, é relevante, e que sua proposta endereça uma lacuna específica. Em qualificação, isso também sinaliza maturidade da delimitação.

**Ato narrativo:** Ato 1 — abre o mundo (controle embarcado importa), introduz a tensão (memory safety mal resolvida), e fecha com a pergunta motora que o resto da tese persegue. Internamente, a seção 1.1 pode seguir o micro-padrão CARS: território → nicho → ocupação.

### 1.1 Contextualização
- O que é o problema? Qual o domínio (controladores embarcados)?
- Por que memory safety importa nesse domínio especificamente?
- O que C/C++ entrega hoje e o que falta?
- Por que Rust e por que **agora**?

### 1.2 Objetivos
#### 1.2.1 Objetivo Geral
- Uma frase. O que será entregue ao final do mestrado.
- Critério: deve ser verificável (alguém de fora deve saber dizer se foi atingido).

#### 1.2.2 Objetivos Específicos
- Lista de marcos parciais que, juntos, satisfazem o geral.
- Mapeáveis 1-pra-1 com o cronograma (capítulo 6).
- Cada objetivo específico deve ter um critério de "feito".

### 1.3 Visão Geral da Dissertação
- Resumo de uma frase por capítulo restante.
- Função: dar mapa de navegação ao leitor.

### Decisões em aberto pra este capítulo
- ~~A introdução cita Aule pelo nome ou descreve "uma biblioteca"?~~ **Resolvido sob B:** cita pelo nome, mas apresentada como *meio* (veículo que torna os casos reais), não como objeto central.
- **Encaminhamento sob B (confirmar):** liderar a motivação pelos incidentes documentados mapeados a classes de bug de memória (Toyota UA, Therac-25, Ariane V, MCAS — ver `rust_memory_safety_em_controle.md` §"Argumento para a tese"); dados estatísticos de CVEs entram como reforço, não como abertura.
- **Novo (B):** o objetivo geral (1.2.1) orienta-se à *demonstração de eliminação de classes de bug*, não à entrega de uma toolbox. As features de controle aparecem nos objetivos específicos como pré-requisito de viabilidade, não como fim.

---

## Capítulo 2 — Trabalhos Relacionados

**Função:** mostrar que você conhece o estado da arte e justificar por que sua proposta acrescenta algo. Em qualificação, falhar aqui é fatal — a banca vai pressionar.

**Ato narrativo:** Ato 1 — aprofunda a tensão introduzida em 1.1. Cada trabalho citado precisa empurrar a tensão: "X resolve Y mas não Z", "W ataca a borda errada do problema". Não é catálogo — é mapeamento da lacuna que a Aule preenche. Tabela comparativa final é o cliffhanger que prepara a entrada do Ato 2.

### Estrutura sugerida (reordenada sob B)

Sob enquadramento B, os comparáveis **primários** são abordagens de *garantia de segurança*; toolboxes de controle entram como *contexto* (de onde a Aule herda requisitos), não como o eixo de comparação central.

- **2.x (primário) Abordagens de memory/type safety em software crítico** — Rust (safe + `unsafe` confinado), Ada/SPARK, MISRA-C + ferramentas (Polyspace, Coverity, Frama-C), C com sanitizers (ASan/TSan/UBSan). Eixo: *que classes de bug cada uma elimina, e em que momento (compilação / análise estática / runtime / teste)?*
- **2.x (primário) Verificação formal aplicável a Rust** — Kani, Creusot, Prusti. O que provam e a que custo. Liga ao cap. 4 (invariantes provados).
- **2.x (contexto) Bibliotecas de controle como origem de requisitos** — MATLAB Control Toolbox, `python-control`, Slycot; libs de controle em Rust (`control-rs` etc.). Servem pra dizer "isto é o que uma toolbox precisa ter" e situar a Aule, **não** pra reivindicar superioridade funcional.
- **2.x Trabalhos acadêmicos no cruzamento controle × segurança de software** — onde a literatura já tocou no problema; qual a lacuna.
- **2.x Síntese comparativa** — tabela cujo eixo central é *classe de bug eliminada × abordagem*, com colunas secundárias (embedded-ready, ergonomia, custo de adoção). **Aule entra como linha**, posicionada pela combinação "elimina por construção + ergonômica + `no_std`".

### Decisões em aberto
- ~~A taxonomia é por linguagem ou por abordagem de garantia?~~ **Resolvido sob B:** por **abordagem de garantia** (é o que conversa com a tese). Linguagem vira atributo dentro de cada abordagem.
- Quão fundo entrar em Ada/SPARK? Sob B, é o comparável conceitual mais forte (também mira segurança por construção) — provavelmente merece mais espaço que as toolboxes. Definir profundidade.
- Incluir ferramentas adjacentes (RTOS type-safe, ex. RTIC/Embassy)? Sob B, RTIC é relevante porque aparece nos casos (cap. cap. de memory safety) — incluir como parte da abordagem Rust, não como item isolado.

---

## Capítulo 3 — Fundamentação Teórica

**Função:** dar ao leitor exatamente o vocabulário e os conceitos necessários para entender os capítulos 4-5. Nem mais, nem menos.

**Ato narrativo:** Ato 1 — última etapa antes da virada do Ato 2. Equipa o leitor com o vocabulário mínimo para entender a tentativa que vem. Cada seção precisa passar pelo filtro "remover isso quebra a leitura do Ato 2 ou 3?" — se não, corta. É a fronteira final do "setup" — termina deixando o leitor pronto pra ver a proposta entrar em cena.

**Risco identificado (papel de revisor):** as 4 áreas atuais ("Sistemas de Controle", "Arquitetura e Organização de Computadores", "Engenharia de Software", "Sistemas Embarcados") são amplas demais. Sem filtro, vira manual genérico. Cada seção precisa de **um teste de relevância**: "remover esta seção quebra a leitura de algum capítulo posterior?"

**Priorização sob B (núcleo vs. periferia):** com memory safety como tese, o peso da fundamentação inverte em relação a uma tese de toolbox.
- **Núcleo** (sustenta diretamente os casos e o experimento): classes de bug de memória e ownership/borrow/lifetimes (3.3); o mínimo de A&OC que os casos exigem — stack vs. heap, atomicidade/torn read, MMU/MPU (3.2); `no_std`/`core`/`alloc` e modelo de execução ISR↔tarefa (3.4).
- **Periferia** (só o suficiente pra ler os casos): teoria de controle (3.1) entra no nível necessário pra entender delay line, observador e MPC como *objetos* — não como projeto de controladores. Profundidade de controle além disso é candidata a corte.
- **Teste afiado:** se uma subseção de 3.1 não é pré-requisito de nenhum caso do cap. de memory safety nem do experimento, ela serve à Tese A (toolbox), não à B — reavaliar.

### 3.1 Sistemas de Controle
- Mínimo: o que é planta, controlador, malha aberta/fechada, controlador discreto vs. contínuo.
- Conceitos que **a biblioteca exporta** — blocos, espaço de estados, função de transferência. Se Aule usa esse vocabulário, defina aqui.
- **NÃO entrar em** projeto de controladores específicos (PID detalhado, LQR, pole placement) a menos que apareça depois.

### 3.2 Arquitetura e Organização de Computadores
- Pergunta de filtro: o que de A&OC importa para entender memory safety em embedded?
- Candidatos: memória virtual vs. física, MMU/MPU, stack vs. heap, modelo de memória, alinhamento, endianness.
- **NÃO entrar em** pipelining, cache hierarchy, ISA design — a menos que ataquem o problema da tese.

### 3.3 Engenharia de Software
- Foco em: tipos, abstração, composição, princípios de design de API.
- Memory safety como propriedade de software, classificação de bugs (referenciar [`rust_memory_safety_em_controle.md`](rust_memory_safety_em_controle.md)).
- O que torna uma biblioteca "boa" — testabilidade, modularidade, portabilidade.

### 3.4 Sistemas Embarcados
- `no_std` vs. `std` em Rust; `core`, `alloc`.
- Restrições de recursos (memória estática, ausência de heap em alguns casos).
- Bare metal vs. RTOS.

### Decisões em aberto
- A ordem atual está em "do mais conhecido pro mais específico". Faz sentido inverter? Começar de embedded + Rust e ir abrindo o leque?
- Onde entra a parte **conceitual de Rust** (ownership, lifetimes, traits)? Em 3.3 ou em uma seção dedicada?

---

## Capítulo 4 — Metodologia Proposta

**Função:** descrever **como** o trabalho será conduzido — não o que ele entrega. É contrato com a banca.

**Ato narrativo:** Ato 2 — entrada da tentativa. Aqui mora o **ponto-de-virada (midpoint)** da narrativa: a decisão de design não-óbvia da Aule que organiza o restante. Identificar e tornar explícita essa decisão é a tarefa narrativa mais importante deste capítulo. Complicações reais (ergonomia em `no_std`, custo de generics, lacunas vs. MATLAB) devem aparecer aqui sem maquiagem — esconder fragilidades enfraquece o Ato 3.

### 4.1 Caracterização da Pesquisa
- Tipo (aplicada, experimental, quantitativa). Já está.
- Refinar: que evidência você vai gerar? Métricas? Comparações? Casos de uso?

### 4.2 Levantamento de Requisitos da Biblioteca
- Como você decide quais abstrações entram (vs. ficam fora)?
- Fontes: literatura, casos de uso, análise comparativa, feedback de usuários potenciais.
- Output desta atividade: lista de requisitos funcionais + não-funcionais (`no_std`, portabilidade, ergonomia).

### 4.3 Projeto da Arquitetura da Solução
- Como traduzir requisitos em módulos/traits/tipos.
- Critérios de decisão de design (ex.: "preferir composição estática sobre dinâmica quando possível").
- Onde documentar essas decisões (ex.: ADRs no repo da biblioteca).

### 4.4 Implementação da Biblioteca em Rust
- Estratégia de desenvolvimento (incremental por feature? por camada?).
- Como Rust **dita** decisões de design (versus C/C++).
- Política de `unsafe`: quando aceitar, como isolar.

### 4.5 Estratégia de Validação e Testes
- Testes unitários, propriedade (proptest/quickcheck), integração.
- Validação em host e em embedded (qual hardware-alvo?).
- Critérios de aceitação por feature.

### 4.6 Critérios de Avaliação e Comparação
- **Eixos primários sob B (do experimento em `rust_memory_safety_em_controle.md` §"Experimento proposto"):**
  - bugs que um sanitizer detecta em C e que **não compilam** em Rust (a evidência central);
  - tamanho da fronteira `unsafe` no projeto Rust (quanto da segurança não é coberta pelo compilador);
  - linhas de "boilerplate de segurança" (locks manuais, bounds checks, verificação de init) eliminadas;
  - paridade de performance (ciclos/iteração) — esperado: empate. Refutar o medo "Rust é mais lento".
- **Eixos secundários (validação do veículo, não da tese):** expressividade, portabilidade, overhead de binário. Comparação numérica com `python-control` mora aqui.
- Baselines definidos no cap. 2 (abordagem de garantia, não toolbox).

### Experimento central (âncora do método sob B)
O experimento comparativo já esboçado em `rust_memory_safety_em_controle.md` §"Experimento proposto" é o coração metodológico: mesmo algoritmo (Smith Predictor + Kalman de baixa ordem + estado compartilhado com ISR + reconfiguração de horizonte) implementado em **C+FreeRTOS** e **Rust+`heapless`+RTIC**, ambos passados por ASan/TSan/UBSan, documentando para cada bug o trio {snippet C que o produz, erro de compilação Rust que o impede, diagnóstico do sanitizer}. Decidir a escala do experimento na qualificação vs. dissertação.

### Ponto-de-virada do Ato 2 — RESOLVIDO (2026-05-28)

**Midpoint:** a adoção da composição *forward* com `Signal` (monoid) como base de toda a biblioteca — todo elemento é um `Block` avaliado para a frente, em vez de um grafo resolvido a partir da saída (backward).

**Por que é decisão de memory safety (não só arquitetura):** determina *de onde vêm as garantias de segurança*. O grafo backward, em Rust, empurra para `Rc<RefCell>` (borrow em runtime → panic, exige `alloc`), arena+índices (troca segurança-de-tipo por segurança-de-índice, mais fraca) ou `unsafe`. A composição forward mantém as garantias no sistema de tipos — estáticas, `no_std` sem heap. Liga ao eixo transversal 3.

**Enabler, não prova (refinamento 2026-05-28):** o forward *viabiliza* memory safety por construção em `no_std` (mantém as garantias sem `Rc<RefCell>`/`unsafe`), mas não a *demonstra*. A demonstração são os casos (cap. 5) e o experimento (cap. 4) — o midpoint abre a possibilidade, o clímax a prova. Honestidade: memory safety básica (ausência de UB) vale em *qualquer* Rust safe, inclusive backward; o que o forward entrega especificamente é mantê-la **estática e sem heap**, que é o que importa no alvo embarcado. Atenção também: o encadeamento via operador `*` usa `&mut dyn Block` (dispatch dinâmico), então **não** alegar "zero-custo" sem ressalva — o caminho monomorfizado é a chamada direta `.output()`.

**Natureza da virada (contar com honestidade):** não foi batalha perdida-e-vencida com o borrow checker — a versão backward **não** foi implementada. Matheus reconheceu o custo do backward; a forma forward+`Signal`/monoid **emergiu de várias tentativas** até convergir, informada por abordagens idiomáticas em Rust (modelo iterator). É *convergência por iteração*, não derrota do caminho alternativo.

**Consequência de honestidade (tarefa):** como o backward não foi medido, a afirmação sobre seu custo precisa ser ancorada em argumento técnico + literatura (o problema conhecido de "grafos em Rust safe"), nunca em experiência própria de implementação. Material para cap. 2/3.

**Desdobramentos a jusante (não são o midpoint):**
- Refator `Controller`/`Block` → "mesmo código em simulação e hardware".
- Verificação formal (Kani) → clímax do Ato 3, não a virada.

**Feedback no modelo forward (decisão de design + ponto que a banca cutuca):** a realimentação é explícita — o desenvolvedor lê o `last_output` do bloco à frente e a injeta onde quer. Vantagem: o atraso/estado da malha fica *literal*, não escondido num diagrama que sugere simultaneidade. Trade-offs a guardar: (a) explícito vira manual → propenso a erro em sistemas grandes; (b) laço algébrico puro (sem atraso) pode não ser representável — tende a forçar um atraso unitário; (c) comparar com solvers de laço algébrico (Simulink). Não resolver agora; ter resposta pronta.

### Decisões em aberto
- A metodologia trata Aule como produto único ou como **plataforma extensível** (terceiros podem contribuir blocos)? Sob B, "produto único focado nos casos" reduz escopo — provavelmente melhor.
- Os critérios de avaliação precisam ser fechados **agora** (qualificação) ou podem ser refinados na dissertação?
- Qual o hardware-alvo do experimento (Cortex-M específico)? O bridge SWD via probe-rs já existe na Aule — aproveitar.

---

## Capítulo 5 — Resultados Parciais

**Função:** mostrar à banca que o trabalho saiu do papel — há artefato, decisões tomadas e evidência preliminar.

**Ato narrativo:** atravessa Ato 2 e Ato 3. Primeira metade — estado da biblioteca, decisões validadas, casos de uso construídos — fecha o Ato 2 mostrando que a tentativa começou a funcionar. Segunda metade — síntese, limitações honestas — inicia o Ato 3, virando "tentativa que funciona" em "evidência que sustenta a contribuição". Quando este capítulo for refinado, marcar a fronteira interna entre as duas metades.

### 5.1 Análise de Eficiência (atual)
- **Crítica (papel de revisor):** "eficiência" como única dimensão é estreito demais pra qualificação. O leitor pergunta: eficiência de quê — tempo de execução, footprint, esforço de desenvolvimento, expressividade?

### Estrutura sugerida (reorganizada em duas metades sob B)

**Metade 1 — "o veículo funciona" (fecha o Ato 2):**
- **5.x Estado atual da biblioteca** — o que está implementado, referência a [`aule_roadmap.md`](aule_roadmap.md). Função: mostrar que a Aule é real e usável, não vaporware.
- **5.x Validação funcional do veículo** — comparação numérica Aule ↔ `python-control` em casos conhecidos. Função: provar que a base de controle está correta, pra que os casos de segurança não sejam contestados como "controle de brinquedo".
- **5.x Decisões de design que codificam segurança** — onde o sistema de tipos já tornou bugs impossíveis (liga ao ponto-de-virada do cap. 4).

**Metade 2 — "a tese se sustenta" (abre o Ato 3):**
- **5.x Casos demonstrativos como evidência por construção** — para cada um dos 3 casos (delay line, ISR↔DMA, MPC workspace): o trecho C com o bug e o equivalente Rust que **não compila** / força a forma segura. É o resultado parcial *qualitativo* mais forte, e independe do experimento completo. **Núcleo do cap. 5 na qualificação.**
- **5.x Protocolo do experimento (trabalho futuro)** — design do comparativo C-vs-Rust + sanitizers + métricas (fronteira `unsafe`, boilerplate, performance). Apresentado como **protocolo**, não resultados (o experimento é só conceito hoje — ver "Decisões fechadas").
- **5.x Limitações conhecidas** — onde a memory safety do Rust não alcança (eixo transversal 4). Honestidade aqui ganha credibilidade na banca.

**Fronteira Ato 2 → Ato 3:** entre a Metade 1 e a Metade 2. Marcar quando o capítulo for escrito.

### Decisões em aberto
- ~~O capítulo cita resultados quantitativos ou qualitativos?~~ **Encaminhamento sob B:** ambos — qualitativo (bugs que não compilam, decisões de tipo) é o núcleo; quantitativo (performance, fronteira `unsafe` em LoC) reforça. Não inventar números que ainda não existem.
- Quanto do experimento de segurança estará pronto até a qualificação? Define se a Metade 2 mostra resultado ou só protocolo + piloto.
- A comparação com `python-control` já tem alguma medição feita, ou é trabalho futuro?

---

## Capítulo 6 — Cronograma de Execução

**Função:** convencer a banca de que o restante do trabalho cabe no tempo restante.

**Ato narrativo:** Ato 3 — operacionaliza a resolução. Se o Ato 3 promete uma contribuição que se completa na defesa final, o cronograma é a evidência de que essa promessa é executável. Banca lê isso procurando lacunas: cabe? as dependências batem? há buffer pra escrita? Cronograma fraco enfraquece toda a narrativa anterior.

### 6.1 Calendário
- Tabela ou diagrama de Gantt com fases até julho/2026.
- Granularidade: mensal ou bimestral.

### 6.2 Plano de Trabalho
- Cada objetivo específico do cap. 1 mapeado em atividades concretas.
- Marcos verificáveis (não "estudar tema X", mas "entregar protótipo Y").
- Buffer pra escrita da dissertação (regra de bolso: ~3 meses).

### Decisões em aberto
- Granularidade do cronograma — semanal é detalhado demais, mensal pode esconder gargalos.
- Como tratar dependências externas (publicações, eventos, validação com terceiros)?

---

## Capítulo 7 — Conclusão (qualificação)

**Função:** fechar a qualificação. Em qualificação a conclusão costuma ser curta — síntese do que já se sabe, expectativas pro próximo ciclo.

**Ato narrativo:** Ato 3 — resolução e gancho. Responde explicitamente à pergunta motora aberta no Ato 1, mesmo que parcialmente (é qualificação, não defesa). O "gancho" é a ponte pra dissertação final: o que ainda não respondemos e por que vale responder. Sem essa amarração, o documento termina em vez de fechar.

### Estrutura sugerida
- **7.x Síntese do trabalho até aqui** — o que foi definido, o que foi construído.
- **7.x Próximos passos** — alinhado com o cronograma do cap. 6.
- **7.x Contribuições esperadas** — antecipa o que vai estar na conclusão da dissertação final.

---

## Pós-textuais

### Apêndice A
- **Função atual:** placeholder genérico do template.
- **A definir:** o que vai aqui? Candidatos: snippets de API da biblioteca, casos de uso completos, configurações de build, dados de benchmarks. Decidir o conteúdo determina se o apêndice é único ou se vira `apendiceA`, `apendiceB`, etc.

### Bibliografia
- Gerada automaticamente de `referencias.bib`. Manter `.bib` sempre atualizado.

---

## Itens transversais que ainda precisam de decisão

1. **Lista de Siglas (`pre-textuais/LISTA_DE_SIGLAS.tex`) está com siglas herdadas do template original** (DEA, CVLI, CISPs, etc.) — nada do tema atual. Definir a lista de siglas reais.
2. **Resumo / Abstract / Palavras-chave** — placeholders. Escrever depois que a introdução estabilizar.
3. **Título do trabalho** — atualmente "Aule: Towards memory safety in system control". Confirmar se é título definitivo pra qualificação.
4. **Estilo de citação** — `natbib` com `[square, numbers]`. Confirmar com a banca/orientação se é o aceito pelo programa.
5. **Idioma** — tudo em português, abstract em inglês. Manter.

---

## Como iterar este documento

A cada refinamento (decisão tomada, escopo recortado, seção adicionada):
- Atualizar este arquivo no plano correspondente.
- Marcar decisões resolvidas como `~~aberta~~ resolvida: <decisão>` em vez de apagar (rastreabilidade).
- Quando um capítulo amadurecer, considerar mover detalhes para arquivo dedicado em `plan/cap_<nome>.md`.
