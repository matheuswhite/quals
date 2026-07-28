---
name: ponto-retomada
description: "Cap. 5, secao 'Bibliotecas e repositorios de controle' (sec:control-repos, TOPO do cap. 5): 5.x.1 (Metodo da busca) ESCRITA+REVISADA (falta commit docs: + acentos); 5.x.2 (Panorama) VAZIA com formato JA DECIDIDO (grade PID no apendice via csvsimple + grade control hibrida/prosa por familia). Analise das 6 libs de controle + verificacao de busca na API em plan/comparacao_libs_controle.md. 5.1/5.2/5.3 escritas (5.1=6d170f2, 5.3=b50ce52). Cap. 4 completo (falta passe de forma). Entrega banca 7/ago; defesa 26/ago."
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
  type: project
  originSessionId: bfd04e9d-3381-42a2-bac3-e70b75a64a40
---

**Ponto de retomada — sessão de 27/jul/2026. Fechamento do dia.**

## FOCO ATUAL — seção "Bibliotecas e repositórios de controle" (`sec:control-repos`, TOPO do cap. 5)

### 5.x.1 Método da busca (`subsec:control-repos-method`) — ESCRITA + REVISADA (banca)
Cobre: motivação (situar a Aule no ecossistema open-source — cronologia corrigida, "para situar", não "antes de escolher"); 2 buscas no GitHub, `language:rust`, chaves `pid` e `"control system"` (frase exata); ordenação por estrelas COM ressalva (estrela ≠ maturidade/qualidade, só relevância percebida); data de congelamento 09/jun/2025; funil 340→165→59 (`pid`) e 347→125→6 (`"control system"`) — corte 1 = ≥1 estrela, corte 2 = falso positivo (Process Identifier + irrelevantes; version/source control ~95%); duas grades — **PID: 18 atributos** (enumerate, polaridade "sim=positivo/negativo"; `generic typing` em 3 níveis não/primitivo/completo); **control: 7 dimensões descritivas** (no_std, genéricos, backend, capacidades, abstração, concorrência, maturidade); ressalva final GitHub ≠ base indexada + recall (`idsp` sem "pid" no nome).
*Furos já fechados por ele nesta sessão:* cronologia; `anti-windup` (era `anti-widnup`); genericidade (3 níveis).
*Pendências:* **commit `docs:`** (o texto é do Matheus) + passe de acentos (pesquina, repositorios, paragrafos, genericos, algebra, concorrencia, relevancia).

### 5.x.2 Panorama comparativo (`subsec:control-repos-table`) — VAZIA (só heading). PRÓXIMO A ESCREVER.
**Decisão de formato tomada (ver `plan/comparacao_libs_controle.md`):**
- Grade PID 59×18 → **APÊNDICE** (via `csvsimple`, pacote a adicionar; `ic.cls` já tem booktabs/tabularx/rotating). Corpo = só síntese (contagens/funil de features).
- Grade control 6×7 → **HÍBRIDO**: micro-tabela de sinal (✓/✗) p/ a lacuna (no_std, concorrência, genérico, crates.io, maturidade) + prosa por FAMÍLIA (análise offline × execução). Matheus prefere prosa; se zero-tabela, exigir 1 frase-síntese do "0/6" + itemize (nunca 6 parágrafos-catálogo).
- Roteiro imagem+6 campos da 5.x.2 OFERECIDO, ainda não montado — retomar.

### Análise pronta (insumo da 5.x.2) — `plan/comparacao_libs_controle.md`
6 libs de controle inspecionadas no código (subagentes de IA): **0/6 no_std, 0/6 concorrência/data race, 0/6 genéricas de fato, 5/6 abandonadas (1 star), 1/6 no crates.io.** Duas famílias: análise LTI offline (control-sys-rs, TorBox) × execução/composição (pekpuglia type-safe, Hixos diagrama+RK4+PID, AlbertoFoti EDOs). Aule = única no cruzamento no_std+composição+concorrência. Divergências README×código: control-sys-rs anuncia LQR ausente; TorBox diz "simulating" sem loop.

## aule-rs (sibling) — estado
`origin/main` (commit `4fb7d35`) usa **nalgebra 0.34 em modo `no_std`** (`default-features=false`, `libm`, `alloc`) + num-complex — NÃO faer (faer era da branch `arduino_fix`, working tree local). `main` local atualizada por FF nesta sessão. Branches `sync` e `number_generic` existem em `origin` (não inspecionadas a fundo). CLAUDE.md "nalgebra" está correto p/ a main.

## Resto do Cap. 5 (fora da seção de repos)
- **§5.1 (Aule, `sec:aule-state`)** — COMMITADA (`6d170f2`).
- **§5.2 (P1, `sec:case-setpoint`)** — escrita/revisada. *Pendência:* listagem `code:rustc-error` (§5.2.3) VAZIA — colar saída real do `rustc` (`E0277`, `Cell<f32>` não é `Sync`).
- **§5.3 (Limitações, `sec:partial-limitations`)** — escrita/revisada, COMMITADA (`b50ce52`, `docs:`).
- ⚠️ Numeração: comentários `% 5.1/5.2/5.3` no `.tex` são anteriores à entrada da seção de repos no topo → conferir se os `% 5.x` realinham.

## Cap. 4 — COMPLETO (4.1–4.7 + fecho). Só passe de forma.
6 `\cite{}` vazios (5 na 4.4.1 + 1 na 4.6.3 firmware); tabela TODO na §4.3.3; ortografia §4.5/§4.7; `sec:dr-def`/`sec:dr-vs-race` seguem `??` (cap. 3 nasce na W8). Enviar cap. 4 + cap. 5 ao Icaro assim que a seção de repos fechar.

## Pendências gerais (não bloqueiam)
- Citações `rust-error-index`, `rust-safe-soundness` — ver [[citacoes-pendentes]].
- `refs/` untracked (decidir versionar × gitignore); `referencias.bib` herdadas a limpar.
- Gancho `Mirror::Primitive32`/P1 fora da 5.1 de propósito ("em desenvolvimento" + cap. 6).

## Prazo (roadmap_escrita.md, replan 25/jul)
- **Entrega à banca: sex 7/ago/2026** (autoimposta; regimento 11/ago). **Defesa: qua 26/ago.** Cap. 2 e 7 CORTADOS. Núcleo intocável: caso P1, protocolo (4.6), 3.3/3.4, revisão final.

## Workflow desta linha (manter)
Roteiro por seção (skill `roteiro-academico`: imagem + 6 campos) → Matheus escreve → "verifique" (banca, sem mercê) → aponta furos → aplica → "verifique novamente" → commit. Papel bibliotecário p/ buscas (Regra 7). Ver [[review-checklist-enforce]] e [[roteiro-explicacao-didatica]].
