---
author: Claude (claude-opus-5)
created: 2026-08-03
---

<!-- LTeX: enabled=false -->

# Revisão mecânica de 2026-08-03 — o que foi decidido e o que falta

Matheus suspendeu a Rule 3 nesta data para uma revisão mecânica dos `.tex`. Todas as
decisões abaixo foram tomadas **por ele**, item a item; Claude só transcreveu.

> **Não houve compilação.** Não há TeX nesta máquina (`pdflatex`/`latexmk` ausentes).
> A verificação foi estática: zero refs órfãos, zero chaves desbalanceadas, zero `\ac`
> dentro de matemática/`\texttt`/tabela/listagem, cobertura de siglas conferida por
> contagem independente. **Rodar `latexmk` é obrigatório antes de confiar no resultado.**

---

## Decidido e aplicado

**Refs órfãos (eram 4, agora 0)**
- `sec:prod-cons` → os dois `\ref` removidos.
- `sec:scope` → aponta para o cap. 6 (`cap:cronograma`), onde a delimitação de escopo vai morar.
- `list:eleven-cells` → as 11 células viraram `enumerate`; a frase passou a "Na lista a seguir".
- `sec:cost-exp` → `subsec:quantity-measurement` (§4.6.4).

**Bug de numeração de capítulo (achado na verificação)**
`ic.cls` faz `\refstepcounter{mychaptercounter}` **dentro** do ambiente `mychapterenviroment`,
que é um grupo — então `\@currentlabel` volta ao valor anterior quando o ambiente fecha.
Um `\label` na linha *seguinte* ao `\mychapter` captura rótulo obsoleto. Era o caso de
`\label{cap:experiment}` e `\label{cap:cron}`, ambos referenciados no texto (6 `\ref`).
Os dois `\label` soltos foram removidos e os `\ref` repontados para os labels do próprio
`\mychapter` (`cap:resultados`, `cap:cronograma`). **Confirmar na compilação** que os
números de capítulo saem certos.

**Correções pontuais confirmadas por ele**
| Local | De → Para |
|---|---|
| Metod. §4.2.3 | "DMA-Tarefa (eixo 2)" → "(eixo 1)" |
| Fund. §3.4.2 | "referências mutáveis" → "imutáveis" |
| Metod. §4.7.2 | "o elemento previne" → "o elemento 2 previne" |
| Metod. §4.3.2 | "aceitação de descarte" → "aceitação ou descarte" |
| Fund. §3.3.2 | apagado o fragmento órfão "envolve em" |
| Fund. §3.3.2 | "não pode confiar começar" → "não pode confiar em começar o seu trabalho" |
| Metod. §4.3.1 | "compila-se este cenário e o observa" → "compila-se e observa-se este cenário" |
| Metod. §4.5.1 | "não são necessários" → "não é necessária" |
| Metod. §4.7.1 | inserido "e, por outro lado, o" para fechar o "Por um lado" |

**LaTeX**
- Números de seção escritos à mão (§4.1 e §4.3) → `\ref`. A §4.3.3 não tinha label; criado `subsec:border-crossing`.
- `\citet` nos dois casos em que a citação é sujeito da frase (§4.1, Wazlawick).
- "DR" (uso único) → "data race".
- Labels de capítulo em ASCII kebab-case: `cap:metodologia`, `cap:resultados`, `cap:cronograma`.
- `2ms` → `2\,ms`; `exploratório->empírico` → `$\rightarrow$`; `Signal<T>`, `Rc<RefCell>`, `Arc<Mutex>`, `Mutex<RefCell>`, `DMatrix<f32>` → `\texttt{}` (14 pontos).
- `\cite` → `\citep` em tudo (32 pontos); chaves `url:rust-safe-soundess` e `rust-safe-soundness` → `article:rust-safe-soundness`.

**Siglas**
- Removidas as 11 do template (DEA/segurança pública) que iam impressas; 51 siglas do texto declaradas em ordem alfabética.
- Corpo convertido para `\ac{}`/`\acp{}`: **186 ocorrências** em prosa corrida. Pulados de propósito: tabelas, `\caption`, `\texttt{}`, matemática (`$\text{RMW}$` da taxonomia), listagens e compostos (`ISR-Tarefa`, `RISC-V`, `ESP-IDF`, `ISR/DMA`).
- Glosas manuais: `SoC`, `TOCTOU`, `LoC` e `CAS` foram substituídas por `\ac{}` (o PDF imprime o mesmo texto). `UB` e `OOB` mantiveram a glosa do autor + `\acused{}`, porque `\ac` aninharia parênteses ("(Undefined Behaviour (UB))") e trocaria o PT de "acesso fora dos limites" pelo EN da declaração.
- Expansões de `LoC` e `TOCTOU` ajustadas para a grafia/idioma que ele usou.
- 7 siglas ficam declaradas sem `\ac` no corpo (IAE, ISE, ITAE, RK4, SPSC, SS, TF) — decisão dele de mantê-las na lista. `SS`/`TF`/`RK4` colidem com nomes de tipo da Aule.

---

## Ainda aberto — depende de você

**Citações**
- `rust-error-index` (Metod. §4.3.2, 2x): sem entrada no `.bib`. Você traz a URL, Claude formata.
- 6 `\citep{}` **vazias**: 5 em §4.4.1 (Atomics/`Arc`/Cópia owned; Mutex; snapshot e publicação; transferência de mensagens; priority-ceiling do RTIC) e 1 em §4.6.3 (firmware original da planta, fonte do período de 2 ms).

**Frases que exigem sua redação**
- Fund. §3.4.2: "ambos os nós B e C **deveriam ser possíveis de modificar** o valor do nó".
- Metod. §4.2.1: "sem a necessidade de **entrar este padrão** em uma produção científica".

**Conteúdo / argumento**
- Metod. §4.6.3: "Essa estatística é fácil de ser calculada, **porém** é muito sensível a valores máximos, **por isso é a estatística utilizada**" — o "porém" aponta contra a conclusão; falta o motivo real da escolha da amplitude máximo-mínimo.
- Metod. §4.4.1 e §4.5.3: `tab:impl-pattern` e `tab:tracking` têm **legenda idêntica** com conteúdos diferentes.
- Metod. §4.3.3: "…tem-se o seguinte resultado:" seguido de `% TODO Tabela com o resultado da sonda.` — anuncia tabela que não existe.
- Seus dois `% TODO` em §4.2.3 seguem abertos: descrever a notação $\langle E1,E2,E3\rangle$ na subseção dos três eixos, e descrever o uso do símbolo $\epsilon$.

**Escopo**
- A delimitação de escopo (single-core) precisa ser escrita no cap. 6, que hoje tem só `\section{Calendário}` e `\section{Plano de Trabalho}`. O `\ref` de §4.2.3 já aponta para lá.

**Decisão de forma**
- Os 4 capítulos e a lista de siglas levaram cabeçalho `%` de coautoria (Rule 5), redigido para deixar explícito que nenhuma frase autoral foi reescrita. Se preferir sem, é só remover.
- Rule 6: a suspensão da Rule 3 valeu **só para esta tarefa**. Se quiser que valha adiante, tem de virar linha no `CLAUDE.md`.
