<!--
author: Claude (claude-opus-4-7)
created: 2026-05-20
-->

# Repo memory mirror

Versioned mirror of durable Claude memory for this project. See `CLAUDE.md` → "Rule 6 — Portability of decisions" for the policy.

What lives here (and not in `CLAUDE.md`):

- [User profile](user_profile.md) — Matheus, mestrando UFAL IC; tese no nível do fenômeno (B-dominante) sobre a fronteira de segurança de memória do Rust em data races de controle concorrente — a lib Aule é o veículo
- [Personal project boundary](personal_project_boundary.md) — projeto pessoal acadêmico; nunca citar empregador nem email corporativo em nada deste repo ou memória
- [Ponto de retomada](ponto_retomada.md) — PRÓXIMO = **cap. Fundamentação** no sáb 01/ago (último sábado): só 3.3 + 3.4 no nível do núcleo; tem de criar os 6 labels que o núcleo já referencia e saem `??` (`sec:dr-def`, `sec:dr-vs-race`, `sec:prod-cons`, `sec:send_sync`, `sec:unsafe`, `subsec:types_guarantee`) + decidir a casa de `sec:scope`. §1.1 FECHADA em argumento após 6 rodadas de banca (commit `f4dc4c0`); 7 refs novas no `.bib`; §1.2 diagnosticada mas intacta (furo: 1.1 pergunta 2, obj. geral promete 3 — obj. 8/§4.7 sem pergunta); §1.3 vazia. BLOQUEADOR: LISTA_DE_SIGLAS com 11 siglas de outro trabalho (DEA) vai impressa. Entrega 7/ago; defesa 26/ago
- [Citações pendentes](citacoes_pendentes.md) — resta só `rust-error-index` na §4.3.2 (Matheus traz URL → Claude formata). `rust-safe-soundness` RESOLVIDA 31/jul = `article:rust-safe-soundness` (Jung et al., CACM 2021)
- [Review checklist enforce](review_checklist_enforce.md) — ao revisar o texto da tese, cobrar `plan/checklist_revisao.md` (taxonomia de padrões de data race, F7)
- [Roteiro: explicação didática](roteiro-explicacao-didatica.md) — ao dar roteiro/explicar seção, ENSINAR como ela funciona (imagem + papéis dos blocos + porquê + micro-exemplo), não só listar o que tem que ter

What lives in `CLAUDE.md` (not duplicated here):

- Collaboration rules 1–7 (never write `.tex`; Rule 7 — Claude runs keyword searches he provides into a triage pipeline he curates (`plan/triagem_referencias.md`), no `.bib` write without his definitive verdict; four roles incl. *Bibliotecário*; allowed file types; outlines policy; authorship)
- Commit conventions (`ai:` vs `feat:`/`fix:`)
- Build, document structure, class-specific conventions, bibliography, `plan/`, assets
