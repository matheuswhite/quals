---
name: ponto-retomada
description: "Cap. Resultados (renderiza como cap. 4 no PDF; comentarios '% 5.x' sao legado), secao 'Bibliotecas e repositorios de controle': 5.x.1 (Metodo) COMMITADA (9043d0d); 5.x.2 (Panorama comparativo) ESCRITA (prosa Matheus + tabela tab:lib-comp com coluna Referencia/cite + Aule citada matheuswhite/aule-rs) A COMMITAR; tabela do apendice tab:pid-survey CRIADA (csvsimple lendo res/pids.csv com coluna URL, landscape, 59 repos) A COMMITAR; 7 entradas .bib novas (6 repos control-system + aule). Fonte URLs: star list github.com/stars/matheuswhite/lists/control-system-rust. Cap. 4 completo. Entrega banca 7/ago; defesa 26/ago."
metadata:
  node_type: memory
  author: Claude (claude-opus-4-8)
  created: 2026-05-31
  co-authors:
    - "Claude (claude-opus-4-8), 2026-06-05"
    - "Claude (claude-opus-4-8), 2026-06-10"
    - "Claude (claude-opus-4-8), 2026-06-14"
    - "Claude (claude-opus-4-8), 2026-06-15"
    - "Claude (claude-opus-4-8), 2026-06-18"
    - "Claude (claude-opus-4-8), 2026-06-21"
    - "Claude (claude-opus-4-8), 2026-06-26"
    - "Claude (claude-opus-4-8), 2026-07-01"
    - "Claude (claude-opus-4-8), 2026-07-04"
    - "Claude (claude-opus-4-8), 2026-07-22"
    - "Claude (claude-opus-4-8), 2026-07-23"
    - "Claude (claude-opus-4-8), 2026-07-26"
    - "Claude (claude-opus-4-8), 2026-07-27"
    - "Claude (claude-opus-4-8), 2026-07-28"
  type: project
  originSessionId: bfd04e9d-3381-42a2-bac3-e70b75a64a40
---

**Ponto de retomada — sessão de 28/jul/2026.**

## FOCO — seção "Bibliotecas e repositórios de controle" (topo do cap. Resultados)

Nota de numeração: o capítulo Resultados renderiza como **cap. 4** no PDF atual (ordem: intro=1, fundamentacao=2, Metodologia=3, Resultados=4, Cronograma=5 — cap. 2/7 cortados). Os comentários `% 5.x` no `.tex` são **legado**; a seção aparece como §4.1 no PDF.

### 5.x.1 Método da busca (`subsec:control-repos-method`) — COMMITADA (`9043d0d`, `docs:`)
Escrita+revisada. *Pendência:* passe de acentos (pesquina→pesquisa, repositorios, paragrafos, genericos, algebra, concorrencia, relevancia).

### 5.x.2 Panorama comparativo (`subsec:control-repos-table`) — ESCRITA (a commitar como `docs:`)
Prosa do Matheus. Estrutura: veredito (ecossistema raso/bifurcado/imaturo) → funil PID no corpo **59→32 (libs)→17 (no_std)→9 (genérico pleno)→5 (anti-windup)→3 (saturação)**, com a ordem declarada como escolha do autor → 2 famílias: **A = análise LTI offline** (`control-sys-rs`, `TorBox`) × **B = execução/composição** (`pekpuglia`, `Hixos`, `AlbertoFoti`); `Josue-Herrera` = 6º repo degenerado (binário de aprendizado) → fecho posicionando a Aule.
Formato final (difere do "híbrido" antes cogitado): **prosa por família + micro-tabela `tab:lib-comp`** (7 linhas × colunas no_std/concorrência/genérico pleno/crates.io/maduro/Referência; marcadores Sim/Não/Parcial). A grade PID completa foi pro apêndice.
**Coluna "Referência" (`\cite`)** adicionada por Claude à `tab:lib-comp` (marcada inline `% modified-by: Claude`); linha da **Aule** = `\cite{aule}`.
**Bug já corrigido pelo Matheus:** `_` cru em `\texttt{...control_systems}` (linha 63) vazava `\texttt`/modo-math por toda a seção; agora é `control\_systems` (plural, confirmado na fonte).
*Pendências de forma (banca):* ortografia (ecossistema, raqueamento→ranqueamento, familía→família, proposito→propósito, diverdir→divergir, reunie→reúne, cental→central, idéia→ideia, "o Aule"/"a Aule" inconsistente, caption "dos repositório"→repositórios); reconfirmar os "ND" e o par README×código dos repos.

### Tabela do apêndice `tab:pid-survey` — CRIADA (a commitar como `ai:`)
`pos-textuais/apendiceA.tex`: `longtable` em `landscape` (pdflscape) via **csvsimple** lendo `res/pids.csv` (59 repos × 18 atributos + coluna **URL**), cabeçalhos rotatebox 90°, `respect underscore` (NÃO usar o pacote `underscore` — colide com `listings`), `\textwidth`←`\textheight` p/ largura landscape. Pacotes adicionados em `main.tex`: `longtable`, `pdflscape`, `csvsimple`. **Build `latexmk` exit 0, 71 páginas.**

### `referencias.bib` — 7 entradas novas (a commitar como `ai:`)
6 repos control-system (chaves `control-sys-rs`, `torbox`, `pekpuglia`, `hixos`, `albertofoti`, `josue-herrera`) + `aule` (matheuswhite/aule-rs). Metadados **CONFIRMADOS na fonte primária (GitHub) em 2026-07-28**. `author` = handle GitHub (sem nome real exibido); `aule` = "dos Santos, Matheus T.". `year` omitido nos 6 (data de commit não exposta na verificação); `aule` year=2026.

### `res/pids.csv` — VERSIONAR (untracked; commit como dado do Matheus, sem trailer — carve-out)
Coluna **URL** (20ª) adicionada da star-list, mapeada **1:1 por posição** (ordem da lista == ordem do CSV). Fonte: **https://github.com/stars/matheuswhite/lists/control-system-rust** (65 repos = 59 PID [itens 1–59] + 6 control-system [60–65]).
**DECISÃO PENDENTE do Matheus:** 2 typos no campo `Name` do CSV — `pid-crtl` (repo real `pid-ctrl`, Iraeis) e `rig-...-tunner-example` (repo real `...tuner...`, 0xPlaygrounds). As URLs já apontam para o repo **correto**; o `Name` na tabela ainda mostra o typo.

## Resto do Cap. Resultados (fora da seção de repos)
- **§5.1 (Aule, `sec:aule-state`)** — COMMITADA (`6d170f2`).
- **§5.2 (P1, `sec:case-setpoint`)** — escrita/revisada; listagem `code:rustc-error` (§5.2.3) **PREENCHIDA pelo Matheus (28/jul)** — sem pendência de conteúdo. A commitar (`docs:`).
- **§5.3 (Limitações)** — COMMITADA (`b50ce52`, `docs:`).

## Cap. 4 (Metodologia, renderiza cap. 3) — COMPLETO. Só passe de forma.
6 `\cite{}` vazios (5 na 4.4.1 + 1 na 4.6.3); tabela TODO na §4.3.3; `sec:dr-def`/`sec:dr-vs-race` seguem `??`. Enviar cap. 4 + cap. 5 ao Icaro assim que a seção de repos fechar.

## Pendências gerais (não bloqueiam)
- Ortografia da 5.x.2 (acima). `refs/` untracked (decidir versionar × gitignore). `referencias.bib` herdadas (DEA) a limpar.
- Citações `rust-error-index`, `rust-safe-soundness` — ver [[citacoes-pendentes]].

## Prazo (roadmap_escrita.md, replan 25/jul)
- **Entrega à banca: sex 7/ago/2026** (autoimposta; regimento 11/ago). **Defesa: qua 26/ago.** Cap. 2 e 7 CORTADOS.

## Workflow desta linha (manter)
Roteiro por seção (skill `roteiro-academico`: imagem + 6 campos) → Matheus escreve → "verifique" (banca, sem mercê) → aponta furos → aplica → commit. Papel bibliotecário p/ buscas (Regra 7). Ver [[review-checklist-enforce]] e [[roteiro-explicacao-didatica]].
