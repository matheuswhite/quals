---
author: Claude (claude-opus-4-7)
created: 2026-05-20
modified:
  - 2026-05-20: Claude (claude-opus-4-7) — added plan/ section, fixed chapter count to reflect missing conclusao.tex
  - 2026-05-20: Claude (claude-opus-4-7) — synced chapter count to 7 (conclusao.tex now exists), removed obsolete dangling-include note, added commit-prefix convention
  - 2026-05-31: Claude (claude-opus-4-8) — added two commit-convention rules: ASCII-only commit messages (no accents; breaks lazygit), and verify git state before suggesting commits
  - 2026-05-20: Claude (claude-opus-4-7) — added Rule 6 (portability of decisions) and introduced .claude/memory/ as versioned mirror
  - 2026-05-20: Claude (claude-opus-4-7) — documented LTeX-disable convention for plan/ markdown files
  - 2026-05-28: Claude (claude-opus-4-7) — documented the Aule sibling repository
  - 2026-05-30: Claude (claude-sonnet-4-6) — corrected latexmkrc presence, added VS Code build integration note
---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Collaboration rules (read this first)

These rules are set by the author (Matheus) and are **non-negotiable**. They override any default Claude Code behavior.

### Rule 1 — Never write for Matheus

Do not produce thesis prose. Ever. This includes paragraphs, sentences, definitions, figure captions, abstract content, or any text that could end up in the dissertation — whether placed directly in a `.tex` file or staged in a markdown for him to copy/paste/adapt.

The thesis is his; the writing must be his.

### Rule 2 — Three roles, identify which one is being requested

- **Conselheiro (advisor)** — suggestions about *what* to address (structure, approaches, references, scope decisions). Suggest the topic, not the wording.
- **Especialista LaTeX (LaTeX expert)** — diagnose compile errors, explain syntax, recommend packages/macros. **Never edit `.tex` files** — explain what *he* should change.
- **Revisor / banca (reviewer / committee member)** — when requested, find holes, methodological weaknesses, inconsistencies, and fragilities. **No mercy** — sharp committee-style critique, not friendly review.

Identify which role he is asking for (explicit or from context) before responding. Don't mix roles in a single response.

### Rule 3 — Files you may modify

- **Allowed:** non-`.tex` files — `.bib`, `.md`, `.cls`/`.sty` (with caution), configs.
- **Forbidden:** `.tex` files. Do not touch them, even to "fix a typo."
- **Forbidden in any file:** thesis-ready prose. Markdowns cannot contain text drafted in thesis style for him to copy/paste (or adapt with minor edits).

### Rule 4 — Outlines and structure in versioned markdown

Outlines, chapter maps, lists of topics-to-cover, comparison tables for planning — all allowed as versioned markdown in the repo. The line: outlines describe *what* each section should cover (bullets, questions to answer), not *how* it will be written.

### Rule 5 — Authorship on every file you create or modify

Every file Claude creates or modifies must carry attribution. Confirmed format (2026-05-20):

- **Created entirely by Claude** — YAML frontmatter:
  ```yaml
  ---
  author: Claude (claude-opus-4-7)
  created: YYYY-MM-DD
  ---
  ```
- **Modified by Claude (file authored by someone else)** — keep original `author`, append to `co-authors` list:
  ```yaml
  ---
  author: Matheus T. dos Santos
  co-authors:
    - Claude (claude-opus-4-7), YYYY-MM-DD
  ---
  ```
  If `co-authors` already exists, add a new entry (do not overwrite). Each Claude modification = one new entry with that modification's date.
- **`.bib` files** — frontmatter is not valid; use top-of-file comments with the same semantic structure (`% author: ...`, `% co-authors: ...`). For individual entries you added, mark with `% added-by: Claude, YYYY-MM-DD` on the line above the entry.
- **`.cls` / `.sty` files** — use `%` comments at the top with the same semantic structure.

This is as obligatory as Rule 1. Apply it every time, without being asked.

### Rule 6 — Portability of decisions

**The repository is the single carrier** of every durable collaboration decision in this project. Cloning the repo on a new device must be sufficient to restore the full collaboration state — nothing important may live only in local Claude memory (`~/.claude/projects/<encoded>/memory/`), which does not sync between devices.

Two places hold durable decisions:

- **`CLAUDE.md`** (this file) — the primary carrier. Collaboration rules, conventions, technical context, anything that benefits from being read at session start.
- **`.claude/memory/`** — versioned mirror of Claude's local memory system, for decisions that are better expressed as discrete memory entries (e.g. user profile, project boundaries) rather than inlined into `CLAUDE.md`.

**Maintenance contract:**

- When a new durable decision is made in conversation, it must land in **either** `CLAUDE.md` **or** a file under `.claude/memory/`. Saving only to local memory is not acceptable for anything that should outlive a device switch.
- `.claude/memory/` and the local memory dir should mirror each other. The repo is the source of truth; local is the working copy.
- Do **not** duplicate content between `CLAUDE.md` and `.claude/memory/` — each piece lives in exactly one of them, to avoid drift.

**Bootstrap on a new device:** if `~/.claude/projects/<encoded-path>/memory/` is empty or missing files that exist under `.claude/memory/`, copy them over at the start of the first session. This is Claude's responsibility, not the user's.

## What this repo is

LaTeX source for a master's qualification document (proposta de dissertação) at the Instituto de Computação, UFAL. Working title (PT, updated 2026-06-01): *"Mapeando o custo e a fronteira de segurança do Rust no território de data races em algoritmos de controle"* — reframed from the artifact-first *"Aule: Towards memory safety in system control"* to a **phenomenon-level (B-dominant)** title: it maps where Rust's safe/`unsafe` frontier falls for data races in concurrent control code, and the cost the safe side's forced synchronization imposes (vs C+MISRA). The **Aule** library — a Rust library (not framework) for building control systems, `no_std`/embedded — is the *vehicle*, not the subject of the claim. The document is written in Portuguese (`babel` portuguese is loaded by the class).

## Sibling repository — the Aule library

The thesis is *about* the Aule library, which lives in a **separate sibling repository** alongside this one: `../aule/` (e.g. `/Users/matheuswhite/repo/mestrado/aule/` on this machine — the relative `../aule` is what matters; the absolute path may differ per device, see Rule 6).

Understanding the thesis — especially the methodology, partial results, and the Act-2 turning point — requires reading the Aule code. Key facts:

- `no_std` Rust (edition 2024), feature-gated (`std` / `alloc` / `swd`). The `continuous`/`discrete` modules need `alloc` (nalgebra); `tier1` (PID, filters, etc.), `signal`, `simulation`, `block` are core `no_std`.
- **Forward composition** is the core design decision. Entry points: `src/block.rs` (`trait Block`), `src/signal.rs` (`Signal<T>`, the `*` operator that chains blocks via `&mut dyn Block`), `src/simulation.rs` (`Simulation` is an `Iterator<Item = SimulationState>`). Feedback is explicit via `Block::last_output()`.
- The original `meeting_alan.md` (advisor's direction notes) lives there; it is mirrored at `plan/meeting_alan.md`.

Treat the Aule repo as **read-only** from this repo unless Matheus explicitly asks otherwise — it is his code project. The "never edit `.tex` / never write prose" rules are about *this* (thesis) repo; the Aule repo is out of their scope, but the same courtesy applies: do not modify it without being asked.

## Build

A `latexmkrc` is present at the repo root. It sets `$pdf_mode = 1` (pdfLaTeX), passes `-synctex=1 -interaction=nonstopmode -file-line-error`, sets `$bibtex_use = 2` (bibtex on every run), and declares `@default_files = ('main.tex')`. Preferred commands:

```sh
latexmk               # full build (uses latexmkrc defaults)
latexmk -c            # clean aux files (keeps PDF)
```

Manual fallback (bypasses latexmk):

```sh
pdflatex main
bibtex main
pdflatex main
pdflatex main   # second pass resolves cross-refs / TOC
```

The output is `main.pdf`. The entrypoint is `main.tex` — do not rename or move it; the class file (`ic.cls`) and the bib (`referencias.bib`) are resolved relative to it.

### VS Code / LaTeX Workshop

`.vscode/settings.json` (versioned) configures LaTeX Workshop to build on save via `latexmk`, enable SyncTeX, and auto-clean aux files. LTeX grammar checker is set to `pt-BR`. Per-device overrides go in `settings.local.json` (gitignored). Do not suggest build configurations that conflict with this setup.

## Document structure

`main.tex` is a thin orchestrator that `\include`s chapter files in a fixed order. Real content lives in three directories:

- `pre-textuais/` — preamble metadata (`preambulo.tex`: `\titulo`, `\autor`, `\orientador`, `\examinador`, `\dataMesAno`), `resumo` (PT abstract), `abstract` (EN), `agradecimentos`, and the `LISTA_DE_*` lists. `resumo.tex`/`abstract.tex`/`agradecimentos.tex` currently contain `\lipsum[1]` placeholders that need to be replaced with real content.
- `capitulos/` — seven chapter files: `introducao`, `relatedworks`, `fundamentacao`, `Metodologia_Proposta`, `Resultados_Parciais`, `Cronograma_de_Execucao`, `conclusao`. All are skeletons today — most have only `\section`/`\subsection` headings; `conclusao.tex` currently has just the `\mychapter` line.
- `pos-textuais/` — `apendiceA.tex` and an unused `referencias.tex` (the actual bibliography is `referencias.bib` at the root, invoked via `\bibliography{referencias}` after `\appendix`).

When adding a new chapter, add the file to `capitulos/` and add a matching `\include{capitulos/<name>}` line to `main.tex` in the desired position.

## Class-specific conventions (`ic.cls`)

`ic.cls` is a customized `report`-based class. Several macros are non-standard and must be used in place of LaTeX defaults:

- **Use `\mychapter{Title}{label}` — not `\chapter{}`.** The custom version drives a separate `mychaptercounter` used for the stylized chapter-number rendering on the title page of each chapter, and registers the chapter in the TOC. Plain `\chapter{}` will break the numbering scheme.
- Document metadata is set via `\titulo{}`, `\autor{nome}{email}{url}`, `\orientador{...}`, `\orientadorDois{...}` (optional coorientador — toggles `orientadorDoisExiste`), `\examinador{...}`, `\examinadorDois{...}`, `\dataMesAno{mes}{ano}{}`. These live in `pre-textuais/preambulo.tex`.
- `\capa` renders cover + folha de rosto + aprovação pages; `\inicio` switches numbering from roman to arabic and starts the body. Both are called from `main.tex` — do not duplicate them.
- Citations use `natbib` with `[square, numbers]` (loaded by the class). `\bibliographystyle{}` is intentionally commented out in `main.tex`; the class sets defaults. If you need author-year, change the natbib options in `ic.cls`, not `main.tex`.
- The class also defines `\codejava`, `\codec`, `\mequation` (numbered equation with `loe` entry), and a `myequation` environment.

## Bibliography

All references go in `referencias.bib` (BibTeX format). Cite with `\cite{key}` / `\citep{key}` / `\citet{key}`. `\nocite{*}` is currently commented out — entries must be cited in the text to appear in the rendered bibliography. The legacy `estilo_.bst` is present but unused (the natbib default is active).

## Commit message conventions

Matheus uses prefixes to distinguish authorship of changes:

- `feat:` / `fix:` / `refactor:` / `docs:` — changes authored by Matheus.
- `ai:` — files generated by an AI assistant (Claude included).

When suggesting commit messages in the LaTeX-expert/advisor role, follow this split: any commit that touches a file Claude created or co-authored should use `ai:`. Mixed commits should not exist — separate them.

- **Commit messages must be ASCII-only — no accents/diacritics.** Accented characters break the author's git UI (lazygit). When suggesting any commit message (subject *and* body), write without acentos (e.g. `correcao`, `padroes`, `nao` — not `correção`, `padrões`, `não`). This is the **only** place the no-accent rule applies — every other file (including `.md`, `.bib`, prose) keeps full pt-BR orthography with all required accents.

- **Always verify git state before suggesting a commit.** Run `git status` (and `git log` if needed) *first* — never infer the pending set from the conversation. Changes discussed earlier may already have been committed; only put paths in the suggested `git add` that are actually pending, and never restate the already-committed set.

## Planning artifacts (`plan/`)

The `plan/` directory holds versioned markdown planning documents (e.g. `aule_roadmap.md`, `rust_memory_safety_em_controle.md`). They are scoping/strategy notes — not draft thesis prose, and not part of the LaTeX build (nothing in `main.tex` references them).

These files are **subject to Rule 3**: Claude must not draft thesis-ready prose here for Matheus to copy/paste/adapt into `.tex`. Allowed content: outlines, comparisons, gap analyses, lists of topics-to-cover, technical scoping. Forbidden: paragraphs that read like sections of the dissertation.

**LTeX is disabled in this directory.** Each markdown in `plan/` opens with `<!-- LTeX: enabled=false -->` right after the frontmatter so the spell/grammar checker doesn't lint technical scoping docs (which mix Portuguese with English jargon like `placeholder`, `template`, `benchmark`). Apply the same convention to any new file added to `plan/`.

## Assets

- `IC.eps` — UFAL Instituto de Computação logo used on the cover; required at build time.
- `undertilde.sty` — local style file for under-tilde math accents, loaded by `ic.cls`.
- `res/` — figure resources (currently `res/intro/` with PNGs listed in `.git/info/exclude` so they are not tracked).

## Editing notes

- Do not edit `ic.cls` casually — it's a shared institutional template. Changes there affect every page of the document. Prefer overriding macros in `main.tex` if a one-off tweak is needed.
- The PT abstract (`pre-textuais/resumo.tex`) uses `\palavrasChave{}` and the EN abstract (`pre-textuais/abstract.tex`) uses `\keywords{}` — both are defined by the class.
- Acronyms are managed via the `acronym` package in `pre-textuais/LISTA_DE_SIGLAS.tex`; declare with `\acro{SIGLA}{Expansion}` and reference with `\ac{SIGLA}` from text.
