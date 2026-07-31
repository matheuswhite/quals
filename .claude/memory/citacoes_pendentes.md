---
name: citacoes-pendentes
description: "Citacao faltando no referencias.bib: rust-error-index (usada na 4.3.2) — Matheus traz URL, Claude formata. rust-safe-soundness RESOLVIDA em 31/jul (article:rust-safe-soundness = Jung et al., CACM 2021)"
author: Claude (claude-opus-4-8)
created: 2026-06-18
metadata:
  type: project
  co-authors:
    - "Claude (claude-opus-4-8), 2026-07-31"
---

Uma `\cite` usada na **§4.3.2** (`capitulos/Metodologia_Proposta.tex`) ainda **não tem entrada** em `referencias.bib` → renderiza `[?]`:

- **`rust-error-index`** — *Rust Compiler Error Index* (página oficial, `doc.rust-lang.org/error_codes`). Sustenta os códigos citados: `E0277` (Send/Sync), `E0499`, `E0502`, `E0505`, `E0382`, `E0373`, `E0597` (borrow / ownership / lifetime). **Matheus traz a fonte; Claude formata** a entrada `@online` quando ele passar **URL + data de acesso** (Regra 7 permite formatar entrada que ele traz). Autor sugerido: "The Rust Project Developers".

**✅ `rust-safe-soundness` — RESOLVIDA em 31/jul/2026.** Entrou no `.bib` como **`article:rust-safe-soundness`**: Jung, Jourdan, Krebbers & Dreyer, *"Safe Systems Programming in Rust"*, **CACM 64(4):144–152, 2021**, DOI `10.1145/3418295` (veredito do Matheus na triagem do cap. 1; metadados confirmados na ACM DL). Serve à §4.3.2 **e** à §1.1. *Atenção:* a `\cite` do cap. 1 ainda está escrita como `url:rust-safe-soundess` (typo em *soundness* + prefixo `url:`) — trocar para a chave correta.

**Mesma classe de pendência (não são `\cite`, mas `\ref` quebrados por falta de `\label`):** `sec:border`, `sec:cost` (§4.3/§4.4 sem label); `subsec:types_guarantee`, `sec:unsafe`, `sec:send_sync` (cap. 3 ainda esqueleto). Ver [[ponto-retomada]].
