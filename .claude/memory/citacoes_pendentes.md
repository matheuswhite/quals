---
name: citacoes-pendentes
description: "Citacoes faltando no referencias.bib (rust-error-index, rust-safe-soundness) usadas na 4.3.2 — criar entradas antes da entrega"
author: Claude (claude-opus-4-8)
created: 2026-06-18
metadata:
  type: project
---

Duas `\cite` usadas na **§4.3.2** (`capitulos/Metodologia_Proposta.tex`) ainda **não têm entrada** em `referencias.bib` → renderizam `[?]`:

- **`rust-error-index`** — *Rust Compiler Error Index* (página oficial, `doc.rust-lang.org/error_codes`). Sustenta os códigos citados: `E0277` (Send/Sync), `E0499`, `E0502`, `E0505`, `E0382`, `E0373`, `E0597` (borrow / ownership / lifetime). **Matheus traz a fonte; Claude formata** a entrada `@online` quando ele passar **URL + data de acesso** (Regra 7 permite formatar entrada que ele traz). Autor sugerido: "The Rust Project Developers".
- **`rust-safe-soundness`** — referência da **soundness do safe subset** (safe Rust não causa data race / DR inexprimível no safe; propriedade da linguagem). Usada no **bloco 4** da 4.3.2 para fechar "aceitação → sem DR". Candidato natural: linha **RustBelt** (*"RustBelt: Securing the Foundations of the Rust Programming Language"*, Jung et al.; ou *"Safe systems programming in Rust"*, CACM). **Busca/escolha é do Matheus (Regra 7);** Claude só formata quando ele trouxer.

**Mesma classe de pendência (não são `\cite`, mas `\ref` quebrados por falta de `\label`):** `sec:border`, `sec:cost` (§4.3/§4.4 sem label); `subsec:types_guarantee`, `sec:unsafe`, `sec:send_sync` (cap. 3 ainda esqueleto). Ver [[ponto-retomada]].
