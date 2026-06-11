---
name: ponto-retomada
description: "Cap. 4: 4.1 (caracterizacao) REDIGIDA e aprovada no conteudo; nomenclatura+poda da taxonomia de DR fechadas (P1-P4, eixo=garantia); proximo = orientar 4.2.2 (Os Tres Eixos)"
author: Claude (claude-opus-4-8)
created: 2026-05-31
co-authors:
  - Claude (claude-opus-4-8), 2026-06-05
  - Claude (claude-opus-4-8), 2026-06-10
metadata:
  type: project
---

**Ponto de retomada — fim da sessão de 10/jun/2026.**

## Estado atual do Cap. 4 (10/jun)
- **4.1 Caracterização — REDIGIDA (3 parágrafos) e aprovada no conteúdo** pela revisão de banca: P1 classificação exploratório-empírica (Wazlawick §2.6, em sequenciamento) + linha qualificação|dissertação; P2 definição dos 3 tipos (formal/empírica/exploratória) + natureza da evidência (compila-vs-não-compila / ciclos-deadlines) + defesa do "risco" da exploratória; P3 mapa método↔objetivo. **Acabamento pendente (não bloqueia):** ortografia/concordância; trocar `\cite`→`\citet` quando o autor é sujeito da frase; **confirmar as 3 definições direto no Wazlawick §2.6**.
- **4.2 Taxonomia — nomenclatura e poda FECHADAS** (registrado em `plan/cap_4_metodologia.md` §4.2): 4 padrões — **P1 Tipo primitivo compartilhado · P2 Produtor-consumidor · P3 Tipo composto compartilhado · P4 Read-modify-write compartilhado**. P5 (flag ISR↔tarefa) = variante de P1; P6 (trajetória) = funde em P2; P7 (core↔core) = limitação (multi-core fora do escopo Cortex-M0). **Eixo que organiza a taxonomia = a garantia exigida no lado safe** (atomic load/store · fila SPSC · exclusão mútua/snapshot · RMW atômico/seção crítica). Direção eixos→garantia (defesa contra circularidade).
- **4.2.1 Método de Levantamento — orientação dada** (Matheus redige): definição operacional de DR ancorada em C11/Rust (≥2 acessos concorrentes, ≥1 escrita, sem happens-before, ≥1 não-atômico) + separar DR de *race condition*; método = dedução pelos 3 eixos + poda por ocorrência em controle (NÃO é revisão sistemática; "representativo, não exaustivo"); fontes = papel bibliotecário (busca é dele, Regra 7); critério inclusão/exclusão explícito.

## Próxima etapa (11/jun)
- **Orientar 4.2.2 (Os Três Eixos):** justificar por que esses 3 eixos (par de contexto · estrutura do dado · padrão de acesso) e não outros; mostrar que eles geram a matriz. Depois 4.2.3 (A Taxonomia — tabela dos 4 padrões). Claude não toca no `.tex` (Regras 1 e 3).

## Pendências (não bloqueiam)
- **Commits sugeridos** (2, não misturar autoria): `docs:` para o `.tex` (4.1 redigida) + `ai:` para o `.md` (nomenclatura/poda). Verificar se já foram feitos.
- Acabamento da 4.1 (ver acima).
- Confirmar/citar o detalhe **ARMv6-M** (Cortex-M0 sem LDREX/STREX → seção crítica): sustenta o argumento do *custo* no P4.
- `referencias.bib`: ~46 entradas herdadas (DEA) a limpar; validar/ler as 12 refs novas antes de citar; completar autores de `sharma2024rust`.
- Seções 4.5–4.7 (pós-qual) vazias — depois das semanas de núcleo.
- A taxonomia (obj 1 / §4.2) cumpre o F7 — ver [[review-checklist-enforce]].

## Contexto de prazo
- Parede dura: **31/ago/2026**. Semana atual (09–14 jun) no roadmap = fechar 4.2–4.4. Ritmo real ≈ 1 seção/semana. Ver `plan/roadmap_escrita.md`.
