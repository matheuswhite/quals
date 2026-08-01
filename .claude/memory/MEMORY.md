<!--
author: Claude (claude-opus-4-7)
created: 2026-05-20
-->

# Repo memory mirror

Versioned mirror of durable Claude memory for this project. See `CLAUDE.md` → "Rule 6 — Portability of decisions" for the policy.

What lives here (and not in `CLAUDE.md`):

- [User profile](user_profile.md) — Matheus, mestrando UFAL IC; tese no nível do fenômeno (B-dominante) sobre a fronteira de segurança de memória do Rust em data races de controle concorrente — a lib Aule é o veículo
- [Personal project boundary](personal_project_boundary.md) — projeto pessoal acadêmico; nunca citar empregador nem email corporativo em nada deste repo ou memória
- [Ponto de retomada](ponto_retomada.md) — 01/ago: cap. Fundamentação em andamento. 3.3 podada 5→3; **3.3.1 e 3.3.2 ESCRITAS + citadas**; 3.3.3 = roteiro pronto (falta escrever; refs Helmbold/Netzer pendentes, Regra 7); 3.4 não escrita. `.bib` +3 (`book:lee-seshia`, `book:stallings`, `doc:c11`/N1570). **FALHA (ref inválida):** labels criados (`subsec:dr-def`, `subsec:data-race-x-race-condition`) não batem com o núcleo (`sec:dr-def`, `sec:dr-vs-race`) → renomear; `sec:prod-cons` sem casa. §1.1 fechada (`f4dc4c0`); §1.2/1.3 pendentes; BLOQUEADOR LISTA_DE_SIGLAS. Entrega 7/ago; defesa 26/ago
- [Citações pendentes](citacoes_pendentes.md) — resta só `rust-error-index` na §4.3.2 (Matheus traz URL → Claude formata). `rust-safe-soundness` RESOLVIDA 31/jul = `article:rust-safe-soundness` (Jung et al., CACM 2021)
- [Review checklist enforce](review_checklist_enforce.md) — ao revisar o texto da tese, cobrar `plan/checklist_revisao.md` (taxonomia de padrões de data race, F7)
- [Roteiro: explicação didática](roteiro-explicacao-didatica.md) — ao dar roteiro/explicar seção, ENSINAR como ela funciona (imagem + papéis dos blocos + porquê + micro-exemplo), não só listar o que tem que ter

What lives in `CLAUDE.md` (not duplicated here):

- Collaboration rules 1–7 (never write `.tex`; Rule 7 — Claude runs keyword searches he provides into a triage pipeline he curates (`plan/triagem_referencias.md`), no `.bib` write without his definitive verdict; four roles incl. *Bibliotecário*; allowed file types; outlines policy; authorship)
- Commit conventions (`ai:` vs `feat:`/`fix:`)
- Build, document structure, class-specific conventions, bibliography, `plan/`, assets
