---
name: ponto-retomada
description: "Cap. 4 esqueleto reorganizado método-por-objetivo (plan/cap_4_metodologia.md) + 2 decisões de escopo (4/jun): só data race (delay line/MPC fora) e planta = pêndulo invertido; próximo = redigir 4.1–4.4 no .tex"
author: Claude (claude-opus-4-8)
created: 2026-05-31
metadata:
  type: project
---

**Ponto de retomada — Cap. 4 em curso (4/jun/2026).**

## Concluído
- **§1.2** (pergunta + 8 objetivos; corte 1–3 qualificação / 4–8 pós-qual) redigida pelo Matheus e commitada (`capitulos/introducao.tex`).
- **Título** no nível do fenômeno (B-dominante), sem Aule: *"Mapeando o custo e a fronteira de segurança do Rust no território de data races em algoritmos de controle"*.
- **Esqueleto do Cap. 4** reorganizado **método-por-objetivo** em `plan/cap_4_metodologia.md`: 4.1 caracterização; 4.2–4.4 = obj 1–3 (qualificação); 4.5–4.7 = obj 4–8 (pós-qual, como protocolo). O ponto-de-virada (forward/`Signal`) migrou para 4.5.

## Decisões de escopo (4/jun) — tomadas e propagadas
1. **Só data race no núcleo.** Delay line (OOB/uninit) e MPC workspace (UAF) **aposentados** — não são data race. Taxonomia (obj 1, §4.2) em 3 eixos: par de contextos × estrutura do dado × padrão de acesso. Casos do cap. 5: setpoint escalar (didático) + ISR/DMA→buffer (central) + estado composto estimador↔controlador.
2. **Planta do experimento (§4.6)** = **pêndulo invertido + realimentação de estados** (Cortex-M0); Kalman vira observador opcional; Smith Predictor + MPC aposentados.

Propagado a `plan/cap_4_metodologia.md`, `plan/roadmap_escrita.md`, `plan/rust_memory_safety_em_controle.md`.

## Próxima etapa
- **Sábado (bloco longo):** redigir **4.1–4.4** no `.tex` (caracterização + métodos dos obj 1–3) a partir do esqueleto. Matheus já abriu `capitulos/Metodologia_Proposta.tex`.
- **Pendente de propagação:** `plan/outline_geral.md` ainda cita os 3 casos antigos (cap. 5) e o experimento Smith+Kalman (cap. 4) — atualizar.
- Em paralelo: leitura bibliográfica do cap. 2.

## Ainda valendo
- A taxonomia que o obj 1 promete (F7) agora **é** a §4.2 — ver [[review-checklist-enforce]] e `plan/checklist_revisao.md`.
- Todas as 5 decisões em aberto do `cap_4_metodologia.md` **resolvidas** (4/jun): escopo (só data race), planta (pêndulo), natureza (aplicada/mista/exploratória), critérios (qualitativo 100% + eixos operacionalizados; números na dissertação).
- Resíduos não-graves: período de amostragem; ortografia do rascunho; lista `1. 2. 3.` não vira `enumerate` em LaTeX.
