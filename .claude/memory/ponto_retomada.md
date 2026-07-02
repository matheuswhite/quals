---
name: ponto-retomada
description: "Cap. 4: §4.5.1 (adequacao/maturidade da Aule como veiculo) REDIGIDA, revisada e FECHADA no argumento (01/jul, commit d3f641d). Proxima = 4.5.2 (composicao forward). Acabamento: ortografia da 4.5.1 + reconferir fatos da Aule no ../aule (roadmap 20/mai, repo ausente neste device). Pendencias: src/p2_snippet.rs a versionar; ESP32/HAL."
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
  - Claude (claude-opus-4-8), 2026-07-01
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 01/jul/2026.**

## Estado do Cap. 4
- **4.1, 4.2, 4.3 — COMPLETAS.** **§4.4 (Catalogação do Espaço de Design, obj 3) — COMPLETA** (redigida/revisada 26/jun; acabamento de ortografia + 7 `\cite` vazios pendente, ver abaixo).
- **§4.5.1 (Adequação e maturidade do veículo) — REDIGIDA, revisada (banca), FECHADA no argumento (01/jul; commit `d3f641d`).**
  - **Estrutura:** par 1 = adequação (Aule = veículo de implementação/medição; **foco no núcleo de controle**, o `unsafe` do P2 fica na **borda de HW** → coerência com 4.3.3); par 2–4 = maturidade pelos **3 requisitos**; par 5 = **ponte para 4.5.2** (`\label{subsec:design-choice}`).
  - **3 requisitos:** (1) simulação no mesmo ecossistema (`Block`/`Signal`/`Simulation` + integradores Euler/RK4); (2) controle não-trivial (PID+anti-windup, TF/SS contínuo+discreto, **observador de Luenberger → demonstra P3**); (3) `no_std` por features (`std`/`alloc`/`swd`; só `std` impede embarcado).
  - **Ressalva-chave (honestidade):** blocos matriciais (SS, observador) exigem **`alloc`**; heap custa **determinismo**, mas esse custo é do **veículo (Aule), não da garantia** → **confound a isolar em 4.6**.

## Decisões da sessão (01/jul) — revisão da 4.5.1
- **Justificativa da Aule re-centrada:** removido "herda memory safety do Rust" (é de todo Rust safe → não justifica ESTA lib) → trocado por "implementa controle não-trivial em HW + permite medir custo". Razão forte = `no_std` real + HIL + controle não-trivial.
- **P2-fora-da-Aule = coerência, não exceção:** a borda de HW (ISR/DMA/ADC) fica fora por construção (casa 4.3.3: `unsafe` na borda de HW); a Aule veicula o **domínio** (algoritmo), não os **mecanismos** de sincronização (que são genéricos do Rust — evita o furo "por que não Rust puro?").
- **Flanco cortado:** removidos Smith Predictor e identificação de sistemas do texto (aposentados/irrelevantes ao recorte → abriam pergunta de banca).
- **Detalhe do mecanismo forward** movido para **comentário na 4.5.2** (não invadir a irmã).
- **Bloco 3 (lacunas de toolbox) DESCARTADO deliberadamente:** listar MIMO/MPC/frequência abre flanco e é irrelevante (Aule = veículo, não objeto). **Viés veículo×autor = defesa ORAL, não texto** (claim é B-dominante: avalia-se o Rust *através* da Aule).

## Acabamento pendente da §4.5.1 (Claude aponta, Matheus aplica — NÃO é conteúdo)
- **Ortografia/gramática:** `bibiloteca` (3×), `ecosistema`, `memory safefy`→safety, `decisão design`→"de design", `um questão`→uma, `consequencias`, `Funções Transferencia`→"de Transferência", `dinamica`, `um feature`→uma, `é necessário`→necessária, `não são necessários`→não é necessária, `Perceba, que`, `foco do núcleo`→no, vírgulas `P2, mora` / `P1 a P4, estejam`; `\texttt{}` nos tipos.
- **Build:** confirmar que `\ref{cap:results}` tem `\label` no cap. 5 (senão vira `??`).

## Próxima etapa
- **4.5.2 (Composição forward como decisão de memory safety)** — gancho já plantado no fecho da 4.5.1 (encadeamento = decisão de design, não ergonomia). **Notas de honestidade p/ o roteiro:** forward = **enabler, não prova**; encadeamento via operador `*` usa `&mut dyn Block` (**dispatch dinâmico** → NÃO alegar zero-custo; o caminho monomorfizado é `.output()` direto); custo do **backward** (`Rc<RefCell>`/arena/`unsafe`) = argumento técnico + literatura, **não medido**. **Rascunho comentado no `.tex`** (~linha 260) com o mecanismo (`Simulation`/`EndlessSimulation`/`Iterator`, operador `*`, `Signal` encapsula f32/f64/Complex32/DMatrix) — **reconferir no `../aule`**.
- Depois: 4.5.3 (instanciação do catálogo + política de `unsafe`), 4.6 (protocolo, cria labels `sec:cost-exp*`), 4.7.

## Pendências (não bloqueiam)
- ⚠️ **`../aule` NÃO está neste device**; roadmap de 20/mai → **reconferir fatos de maturidade da 4.5.1** antes da defesa: existe `EndlessSimulation`? observador/SS exigem `alloc`? nome da feature `swd`? refator `Controller`/`Block` saiu do papel?
- ⚠️ **ESP32 / HAL da Aule** — sustenta "implementar em hardware" (4.5.1) + plataforma (4.6). Atômicos do Xtensa (`S32C1I`) — peso do P4. (Decisão 2026-06-15.)
- **`src/p2_snippet.rs`** (+`src/p2/`) AINDA untracked — `\coderust` da 4.3.3; build quebra para quem clonar. `refs/` (PDF Helmbold & McDowell) a decidir versionar × gitignore.
- Acabamento §4.4: 7 `\cite{}` vazios (4.4.1 bloco 4) + ortografia + nomes entre as 3 tabelas + refs `sec:cost-exp*`.
- Citações 4.3.2: `rust-error-index`, `rust-safe-soundness` — ver [[citacoes-pendentes]].
- `referencias.bib`: ~46 herdadas a limpar; validar 12; autores de `sharma2024rust`.

## Roadmap / prazo
- §4.5.1 ✓. Cap. 4 completo ~12–19/jul; cap. 5 ~02/ago; **parede dura 31/ago/2026**; ~1 seção/semana.
