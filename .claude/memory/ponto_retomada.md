---
name: ponto-retomada
description: "Cap. 4: §4.4 COMPLETA (4.4.1 blocos 1-4 + 4.4.2, redigidas/revisadas 26/jun). Proxima = 4.5 (Aule) ou passada de revisao da 4.4. Acabamento: ortografia + 7 cite vazios (4.4.1 bloco 4) + nomes entre as 3 tabelas + refs sec:cost-exp* (4.6). src/p2_snippet.rs criado, a versionar."
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-14
  - Claude (claude-opus-4-8), 2026-06-15
  - Claude (claude-opus-4-8), 2026-06-18
  - Claude (claude-opus-4-8), 2026-06-21
  - Claude (claude-opus-4-8), 2026-06-26
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 26/jun/2026.**

## Estado do Cap. 4
- **4.1 e 4.2 — REDIGIDAS e revisadas.** §4.3 (Fronteira safe/unsafe) — **COMPLETA** (fechada 21/jun).
- **§4.4 (Catalogação do Espaço de Design das Garantias, obj 3) — REDIGIDA, revisada (banca) e conceitualmente COMPLETA (26/jun):**
  - **4.4.1 (Dimensões de Design):** bloco 1 (definição + renomeação eixo→dimensão; dimensão 1 **ternária** cópia/compartilhamento/transferência, **árvore de decisão** não-ortogonal, "representativas não exaustivas") · bloco 2 (catálogo `tab:impl-safe-rust`, 6 implementações) · bloco 3 (mapeamento `tab:impl-pattern`, P1–P4; **Arc fora do mapa** — só imutável, nota explicando) · bloco 4 (ancoragem + critério geral×framework / RTIC fora).
  - **4.4.2 (Trade-offs em `no_std`):** desambiguação "dimensão" (design × custo); 4 dimensões (runtime/ergonomia/footprint/**determinismo**, o mais crítico); custo **re-centrado no P3** (Mutex bloqueante × Snapshot lock-free+RAM); reframe "**preço da garantia forçada / em safe não dá pra não sincronizar**"; matriz `tab:cost-impl` (8 células, qualitativa) com **P4-Atomics ressalvando HW** (RMW atômico / fallback critical-section).

## Decisões da sessão (26/jun)
- Catálogo = 6 implementações: Atomics · Mutex/critical-section · **Snapshot/publicação** (double-buffer + `AtomicPtr`, opção **lock-free do P3**) · Transferência de Mensagens (SPSC) · Reference Counter (`Arc`, imutável, exige `alloc`, **fora do mapa**) · Cópia owned.
- **Critério de inclusão do catálogo:** construções **gerais** da linguagem/ecossistema, NÃO framework → **RTIC fora** (priority-ceiling é do RTIC; Embassy/bare-metal não têm).
- Custo **argumentado** aqui (qualitativo); **medido** em 4.6.

## Acabamento pendente da §4.4 (NÃO é conteúdo — Claude aponta, Matheus aplica)
- **Passada de ortografia** acumulada (4.4.1 + 4.4.2): `bloquei`, `perdar`, `compoe`, `cíclos`, `algorítmo`, `relacionada`, `descritos`, `atribuíndo`, `nenhum ISA`, concordâncias da frase-ponte, etc.
- **7 `\cite{}` vazios** no bloco 4 da 4.4.1 (ancoragem) → `[?]`. Busca/escolha é do Matheus (Regra 7); Claude formata. Tipo de fonte: Atomics/`Arc`/cópia = doc oficial; snapshot (RCU/seqlock) + SPSC = literatura de concorrência; RTIC = doc RTIC.
- **Nomes consistentes** entre as 3 tabelas (`Transferencia`/`Copia` sem acento na `tab:impl-safe-rust` × com acento nas outras).
- **Refs `sec:cost-exp-proc` / `sec:cost-exp`** (4.4.2 → 4.6) → `??` até a 4.6 existir.

## Build (instalado nesta sessão)
- **MiKTeX + latexmk 4.88 + Strawberry Perl** instalados; PDF compila (32 páginas). ⚠️ resolver "MiKTeX updates" (latexmk reclama). **Falta poppler (`pdftoppm`)** → Claude não renderiza o PDF (diagnostica pelo `.log`).
- **`src/p2_snippet.rs` FOI CRIADO** (untracked) — é o arquivo do `\coderust` da 4.3.3 (linha 147); **a versionar** senão o build quebra em quem clonar. `src/p2/` (cargo) untracked; `target/` já ignorado (`.gitignore`, commit `11fcc37`).

## Próxima etapa
- **4.5 (A Aule como Veículo de Instanciação, obj 4)** — pós-qual, apresentar como plano — OU a **passada de revisão/ortografia da §4.4** antes. Depois: 4.6 (protocolo, cria os labels `sec:cost-exp*`), 4.7 (verificação por tipos × C+MISRA).

## Pendências antigas (não bloqueiam)
- Atômicos do **Xtensa** (`S32C1I`) — peso do P4 / "RMW atômico" no alvo.
- `referencias.bib`: ~46 herdadas a limpar; validar 12; autores de `sharma2024rust`.
- `refs/` (PDF Helmbold & McDowell) a decidir versionar × gitignore.
- Citações da 4.3.2: `rust-error-index`, `rust-safe-soundness` — ver [[citacoes-pendentes]].

## Roadmap / prazo
- W4 = §4.4 ✓. Cap. 4 completo ~19/jul; cap. 5 ~02/ago; **parede dura 31/ago/2026**; ~1 seção/semana.
