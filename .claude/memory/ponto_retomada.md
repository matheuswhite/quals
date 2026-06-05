---
name: ponto-retomada
description: "Cap. 4: esqueleto método-por-objetivo transcrito no .tex (4.1-4.7); 5 decisões de escopo + bibliografia + Rule 7/Bibliotecário fechadas (4/jun); próximo = REDIGIR a prosa de 4.1-4.4 (sábado)"
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 4/jun/2026.**

## Concluído (sessão 4/jun)
- **Esqueleto do Cap. 4** reorganizado método-por-objetivo (`plan/cap_4_metodologia.md`) e **transcrito no `.tex`** pelo Matheus: 7 seções — 4.1 Caracterização; 4.2 Taxonomia (+3 subs); 4.3 Fronteira safe/unsafe (+3 subs); 4.4 Espaço de Design (+subs); 4.5 Aule como veículo; 4.6 Protocolo do experimento; 4.7 Verificação vs C+MISRA. Estrutura validada; placeholders no lugar da prosa.
- **5 decisões de escopo** fechadas: só data race; planta = pêndulo invertido + state feedback; natureza = pesquisa **exploratória-empírica** (taxonomia de Wazlawick §2.6 — RE-CLASSIFICADA em 5/jun; antes era o vocabulário Gil "aplicada/mista/exploratória-descritiva"); critérios qualitativo 100% + eixos operacionalizados (números na dissertação). Ponte obj 3→4 ("um por eixo") = **frase de fecho do 4.4**, não subseção.
- **Bibliografia:** 12 refs verificadas no `referencias.bib` (memória C11/Rust, RustBelt, RTIC, sanitizers, MISRA, controle, tempo real); método de busca registrado em `plan/registro_busca_bibliografica.md`.
- **Colaboração:** nova **Rule 7** (Claude não faz pesquisa bibliográfica no lugar dele) + papel **Bibliotecário** (sugere bases/palavras-chave, avalia abstracts, preenche BibTeX de obra trazida por ele). No `CLAUDE.md`.

## Atualização (sessão 5/jun)
- **Taxonomia metodológica RE-CLASSIFICADA (Gil → Wazlawick):** a 4.1 passa a usar a tríade de Wazlawick (§2.6 — formal/empírica/exploratória), não o vocabulário Gil de 4/jun. Resultado: **exploratória** (qualificação, obj 1–3) + **empírica/experimental** (dissertação, obj 5–8), em sequenciamento. Verificado no próprio livro (PDF trazido pelo Matheus). Ver `cap_4_metodologia.md` §4.1 + nota de correção.
- **4.1 em redação:** 1º parágrafo (caracterização exploratório-empírica, citando §2.6) rascunhado no `.tex`. Falta: ancorar o "empírico/experimental" no §3.4.5 (var. indep. = implementação Rust vs. C+MISRA / dep. = ciclos, deadlines); os **dois produtos** + linha qualificação|pós-qual; **nota de honestidade** (o experimento não roda na qualificação). Defesa-chave: para Wazlawick a exploratória é o estilo "mais arriscado" → ancorar a taxonomia (obj 1) em teoria (C11/Rust) + casos [[review-checklist-enforce]].

## Próxima etapa (sábado — bloco longo)
- **REDIGIR a prosa de 4.1–4.4** por cima dos placeholders (caracterização + métodos dos obj 1–3). A estrutura `.tex` já está montada; Claude não toca no `.tex`.
- **Antes de redigir:** fixar a **nomenclatura dos padrões P1–P7** e **podar a matriz** (incluir/cortar P4–P7) — ver `cap_4_metodologia.md` §4.2 + "Micro-decisões".

## Pendências (não bloqueiam)
- `referencias.bib` ainda tem ~46 entradas herdadas (DEA/segurança pública) — limpar quando quiser.
- Validar/ler as 12 refs novas antes de citar; completar autores de `sharma2024rust`.
- Seções 4.5–4.7 (pós-qual) ainda vazias — escrever depois das semanas de núcleo.
- A taxonomia (obj 1 / §4.2) é o que cumpre o F7 — ver [[review-checklist-enforce]].
