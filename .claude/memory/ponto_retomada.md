---
name: ponto-retomada
description: "Cap. 4: §4.3 (fronteira safe/unsafe) — abertura + 4.3.1 + 4.3.2 REDIGIDAS e revisadas (18/jun); 4.3.3 falta. 4.2.3 com pendencias abertas (A3/B1-residuo/E/B5). Citacoes pendentes no .bib."
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
  - Claude (claude-opus-4-8), 2026-06-14
  - Claude (claude-opus-4-8), 2026-06-15
  - Claude (claude-opus-4-8), 2026-06-18
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 18/jun/2026.**

## Estado do Cap. 4
- **4.1, 4.2.1, 4.2.2 — REDIGIDAS e revisadas.**
- **4.2.3 (A Taxonomia) — REDIGIDA; revisão de banca com B1–B4 fechados. Pendências NÃO tocadas em 18/jun:** A3 (`list:eleven-cells` → `enumerate`; labels `sec:border`/`sec:cost`), B1-resíduo (linha ~106 "atomic load/store de P1"), E (passada ortográfica), B5 (na 4.2.2: critério de ortogonalidade forte demais).
- **§4.3 (Caracterização da Fronteira safe/unsafe) — AVANÇO de 18/jun:**
  - **Abertura, 4.3.1 (Procedimento), 4.3.2 (Critério) — REDIGIDAS e revisadas (banca), conceitualmente FECHADAS.**
  - **4.3.3 (Padrões que Cruzam a Fronteira) — ainda ESQUELETO** ("fila safe + registrador unsafe").

## Decisões/estrutura da §4.3 (18/jun)
- **Vocabulário safe×unsafe vive na ABERTURA da §4.3**; a 4.3.2 fica com a metade **PROBATÓRIA** (não redefine vocabulário).
- **Abertura:** tríade 4.2 exige garantia → 4.3 fronteira → 4.4 custo; vocabulário safe/unsafe; honestidade (Rust não é bala de prata; UB sempre confinável/marcado via bloco `unsafe`).
- **4.3.1 — sonda uniforme de 3 etapas:** (1) montar cenário + forma direta (ingênua, que daria DR em C) + forma idiomática safe; (2) compilar (`cargo check`), anotar veredito (compila/não + mensagem como DADO BRUTO, sem interpretar); (3) localizar a fronteira. **3 desfechos:** (A) inteiramente safe, (B) fronteira interna (parte unsafe na borda de HW), (C) inteiramente unsafe. Registro = construção / veredito / ponto de fronteira. A garantia é PARÂMETRO (vem da 4.2); 4.3.1 define as COLUNAS, 4.3.3 preenche as LINHAS por padrão.
- **4.3.2 — 3 blocos:** bloco 1 = 3 pilares (especificação / verificador = proof checker / determinístico + universal — verificação ≠ teste); bloco 2+3 FUNDIDOS = mensagem→mecanismo (`E0277`→`Send`/`Sync`; borrow `E0499`/`E0502`/`E0505`/`E0382`/`E0373`/`E0597`); 2 grupos (entre contextos = Sync/Send; mesmo contexto = borrow). bloco 4 = elo recusa⟺DR: mapeamento mecanismo↔cláusula de DR (falta Sync/Send → ≥2 contextos; borrow → escrita + ≥2 contextos; Atomic → não-atômico; Mutex → happens-before) + critério de descarte (2 requisitos: causa mapeia cláusula **E** cenário ≥2 contextos; assimetria: borrow também erra em código sequencial) + premissa de **soundness** do safe subset.

## Pendências da §4.3
- **Citações faltam no `.bib`** — ver [[citacoes-pendentes]] (`rust-error-index`, `rust-safe-soundness`).
- **`\ref` quebrados (`??`):** `sec:border`/`sec:cost` (4.3/4.4 sem `\label`); `subsec:types_guarantee`/`sec:unsafe`/`sec:send_sync` (cap. 3 esqueleto, sem `\label`).
- **passada ortográfica da §4.3** (acumulada — ex.: "veridito"×N, "deterministico", "estapa", "compatilhamento", "entre contexto", concordâncias, tipografia `\texttt{}`). Fazer de uma vez, no fim.
- **Roteiros da §4.3 (abertura, 4.3.1, 4.3.2) NÃO registrados em `plan/cap_4_metodologia.md`** — Regra 6: registrar (o plano só tem o roteiro original, sem os refinamentos de 18/jun: vocabulário na abertura, 3 desfechos, fusão 2+3, soundness).

## Próxima etapa
- **Roteiro + redação da 4.3.3** (Padrões que cruzam a fronteira — entregável do obj 2, o mapa); OU registrar os roteiros da §4.3 no plano antes.

## Pendências antigas (não bloqueiam)
- Confirmar atômicos do Xtensa (`S32C1I`) — afeta 4.4 (custo do P4).
- `refs/` (PDF Helmbold & McDowell) ainda não versionado — decidir versionar × gitignore.
- `referencias.bib`: ~46 herdadas a limpar; validar 12; autores de `sharma2024rust`.
- §4.2 cumpre o F7 — ver [[review-checklist-enforce]].

## Prazo
- Parede dura **31/ago/2026**. Ritmo ≈ 1 seção/semana.
