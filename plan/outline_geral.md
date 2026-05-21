---
author: Claude (claude-opus-4-7)
created: 2026-05-20
modified:
  - 2026-05-20: Claude (claude-opus-4-7) — added narrative (3-act) layer mapping each chapter to its dramaturgical function
  - 2026-05-20: Claude (claude-opus-4-7) — added LTeX disable magic comment
---

<!-- LTeX: enabled=false -->

# Outline geral da dissertação

Documento de planejamento. Descreve o **papel** de cada capítulo/seção e as **perguntas que cada parte precisa responder** — não contém prosa nem rascunho de texto. Iterar conforme o trabalho avança.

Referências cruzadas:
- Estrutura física do documento: `main.tex` e arquivos em `capitulos/`, `pre-textuais/`, `pos-textuais/`.
- Roadmap técnico da biblioteca: [`aule_roadmap.md`](aule_roadmap.md).
- Fundamentos de memory safety em Rust: [`rust_memory_safety_em_controle.md`](rust_memory_safety_em_controle.md).

---

## Eixos transversais

Antes do detalhamento capítulo a capítulo, três fios que precisam aparecer em mais de um lugar e amarrar o trabalho:

1. **Tripé do tema** — *sistemas de controle* × *segurança de memória* × *sistemas embarcados / `no_std`*. Cada capítulo precisa indicar qual(is) vértice(s) está abordando e como se conecta ao outro.
2. **Biblioteca vs. framework** — decisão de design recorrente. Aparece em Introdução (como diferencial), Metodologia (como princípio de projeto), Resultados (como o que foi entregue), Conclusão (como contribuição).
3. **Garantia por construção (tipos) vs. garantia em tempo de execução (testes/runtime)** — distinguir o que Rust dá de graça do que precisa ser desenhado ativamente.

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
- **Identificar o ponto-de-virada (midpoint do Ato 2):** decisão de design da Aule que destrava o restante. Precisa estar **explícita** no cap. 4 — banca cobra "qual foi a decisão difícil, e por que assim?".

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
- A motivação de partida vai de **incidentes reais conhecidos** (Toyota unintended acceleration, etc.) ou de **dados estatísticos** (% de CVEs por classe de bug)?
- A introdução cita Aule pelo nome ou descreve "uma biblioteca"?

---

## Capítulo 2 — Trabalhos Relacionados

**Função:** mostrar que você conhece o estado da arte e justificar por que sua proposta acrescenta algo. Em qualificação, falhar aqui é fatal — a banca vai pressionar.

**Ato narrativo:** Ato 1 — aprofunda a tensão introduzida em 1.1. Cada trabalho citado precisa empurrar a tensão: "X resolve Y mas não Z", "W ataca a borda errada do problema". Não é catálogo — é mapeamento da lacuna que a Aule preenche. Tabela comparativa final é o cliffhanger que prepara a entrada do Ato 2.

### Estrutura sugerida (a refinar)
- **2.x Bibliotecas de controle em Rust** — `control-rs`, `nalgebra-based`, esforços de comunidade.
- **2.x Bibliotecas de controle em outras linguagens** — MATLAB Control Toolbox, `python-control`, Slycot, Modelica. Servem como baseline de funcionalidade esperada.
- **2.x Linguagens "memory-safe" em embarcados** — Rust embedded WG, Ada/SPARK, MISRA-C, Frama-C. Cada uma mira garantias diferentes; mapear.
- **2.x Trabalhos acadêmicos sobre verificação/segurança de software de controle** — onde a literatura cruza com sua proposta?
- **2.x Síntese comparativa** — tabela que mostra eixos (expressividade, portabilidade, segurança, embedded-ready, ergonomia) × trabalhos. **Aule entra como linha final** com seus pontos.

### Decisões em aberto
- A taxonomia é por **linguagem** ou por **abordagem de garantia**?
- Quão fundo entrar em Ada/SPARK? É parente próximo conceitual; pode ser comparação rica ou distração.
- Incluir ferramentas adjacentes (RTOS com tipo-safety, ex. RTIC) ou manter foco em libs?

---

## Capítulo 3 — Fundamentação Teórica

**Função:** dar ao leitor exatamente o vocabulário e os conceitos necessários para entender os capítulos 4-5. Nem mais, nem menos.

**Ato narrativo:** Ato 1 — última etapa antes da virada do Ato 2. Equipa o leitor com o vocabulário mínimo para entender a tentativa que vem. Cada seção precisa passar pelo filtro "remover isso quebra a leitura do Ato 2 ou 3?" — se não, corta. É a fronteira final do "setup" — termina deixando o leitor pronto pra ver a proposta entrar em cena.

**Risco identificado (papel de revisor):** as 4 áreas atuais ("Sistemas de Controle", "Arquitetura e Organização de Computadores", "Engenharia de Software", "Sistemas Embarcados") são amplas demais. Sem filtro, vira manual genérico. Cada seção precisa de **um teste de relevância**: "remover esta seção quebra a leitura de algum capítulo posterior?"

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
- Definir **eixos mensuráveis**: expressividade (linhas de código pra implementar X), portabilidade (alvos suportados), overhead (binário, tempo), segurança (CVEs evitados por construção).
- Baselines de comparação (definidos no cap. 2).

### Decisões em aberto
- A metodologia trata Aule como produto único ou como **plataforma extensível** (terceiros podem contribuir blocos)?
- Os critérios de avaliação precisam ser fechados **agora** (qualificação) ou podem ser refinados na dissertação?

---

## Capítulo 5 — Resultados Parciais

**Função:** mostrar à banca que o trabalho saiu do papel — há artefato, decisões tomadas e evidência preliminar.

**Ato narrativo:** atravessa Ato 2 e Ato 3. Primeira metade — estado da biblioteca, decisões validadas, casos de uso construídos — fecha o Ato 2 mostrando que a tentativa começou a funcionar. Segunda metade — síntese, limitações honestas — inicia o Ato 3, virando "tentativa que funciona" em "evidência que sustenta a contribuição". Quando este capítulo for refinado, marcar a fronteira interna entre as duas metades.

### 5.1 Análise de Eficiência (atual)
- **Crítica (papel de revisor):** "eficiência" como única dimensão é estreito demais pra qualificação. O leitor pergunta: eficiência de quê — tempo de execução, footprint, esforço de desenvolvimento, expressividade?

### Estrutura sugerida (a refinar)
- **5.x Estado atual da biblioteca** — o que está implementado, referência a [`aule_roadmap.md`](aule_roadmap.md).
- **5.x Decisões de design já validadas** — exemplos de escolhas que se mostraram corretas/incorretas (ex.: trait `X` foi refatorada porque…).
- **5.x Casos de uso construídos** — controladores concretos que rodam com Aule. Mínimo: 1 não-trivial.
- **5.x Métricas preliminares** — só se houver. Não inventar.
- **5.x Limitações conhecidas** — honestidade aqui ganha credibilidade na banca.

### Decisões em aberto
- O capítulo cita resultados quantitativos (medições) ou apenas qualitativos (decisões tomadas)?
- Há benchmarks contra alguma baseline já?

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
