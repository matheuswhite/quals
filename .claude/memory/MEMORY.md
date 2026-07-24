<!--
author: Claude (claude-opus-4-7)
created: 2026-05-20
-->

# Repo memory mirror

Versioned mirror of durable Claude memory for this project. See `CLAUDE.md` → "Rule 6 — Portability of decisions" for the policy.

What lives here (and not in `CLAUDE.md`):

- [User profile](user_profile.md) — Matheus, mestrando UFAL IC; tese no nível do fenômeno (B-dominante) sobre a fronteira de segurança de memória do Rust em data races de controle concorrente — a lib Aule é o veículo
- [Personal project boundary](personal_project_boundary.md) — projeto pessoal acadêmico; nunca citar empregador nem email corporativo em nada deste repo ou memória
- [Ponto de retomada](ponto_retomada.md) — Cap. 4 completo (4.1–4.7); cap. 5 em andamento: §5.2.1 (cenário P1) e §5.2.2 (data race em C, com TSan) escritas/revisadas/defensáveis, **uncommitted** (msgs `docs:` dadas). Próximo (sábado W7) = §5.2.3 (recusa do `rustc`, `E0277`) → 5.2.4 (atomic) → 5.2.5 (trio). **Parede real = entrega 11/ago** (não 26/ago). ⚠️ roadmap desatualizado (diz 4.7 esqueleto; está completa)
- [Citações pendentes](citacoes_pendentes.md) — `\cite` faltando no `.bib` da §4.3.2: `rust-error-index` (Matheus traz URL → Claude formata) e `rust-safe-soundness` (busca do Matheus — linha RustBelt)
- [Review checklist enforce](review_checklist_enforce.md) — ao revisar o texto da tese, cobrar `plan/checklist_revisao.md` (taxonomia de padrões de data race, F7)
- [Roteiro: explicação didática](roteiro-explicacao-didatica.md) — ao dar roteiro/explicar seção, ENSINAR como ela funciona (imagem + papéis dos blocos + porquê + micro-exemplo), não só listar o que tem que ter

What lives in `CLAUDE.md` (not duplicated here):

- Collaboration rules 1–7 (never write `.tex`; Rule 7 — Claude runs keyword searches he provides into a triage pipeline he curates (`plan/triagem_referencias.md`), no `.bib` write without his definitive verdict; four roles incl. *Bibliotecário*; allowed file types; outlines policy; authorship)
- Commit conventions (`ai:` vs `feat:`/`fix:`)
- Build, document structure, class-specific conventions, bibliography, `plan/`, assets
