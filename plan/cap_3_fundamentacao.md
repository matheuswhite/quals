---
author: Claude (claude-opus-4-8)
created: 2026-06-14
co-authors:
  - Claude (claude-opus-4-8), 2026-06-15
---

<!-- LTeX: enabled=false -->

# Mapa do Cap. 3 — Fundamentação Teórica

> Estrutura/scoping (Regra 4). **Não é prosa** — descreve *o que* cada seção cobre e *quem* a consome, não *como* será escrita (Regras 1 e 3; quem edita o `.tex` é o Matheus).

## Princípio reitor (vale pra todo conceito do capítulo)

> **Fundamentação explica. Metodologia decide/aplica.**
> Teste: "estou *ensinando* o conceito ou estou *escolhendo* com base nele?" Ensinar → cap. 3. Escolher / recortar / aplicar → cap. 4.

Corolário: cada subseção abaixo tem um **consumidor** declarado num capítulo posterior. **Se não tiver consumidor, corta.** Fundamentação não é livro-texto.

## Estrutura-alvo (ordem do capítulo)

Hoje a `fundamentacao.tex` tem 4 seções largas (Controle · Arquitetura · Eng. SW · Embarcados). Adicionar **duas seções novas** (3.3 Concorrência/Modelo de Memória; 3.4 Rust/Tipos) e distribuir subseções nas existentes.

| Seção | Subseção (tópico a cobrir) | Consumidor (cap. posterior) |
|---|---|---|
| **3.1 Sistemas de Controle** *(existe)* | malhas / tempo real / período / deadline; estimadores (estado `x̂`+`P`) | 4.6 (deadlines); gancho de P3 |
| **3.2 Arquitetura e Organização** *(existe)* | instruções atômicas e barreiras (load/store atômico; LL/SC — LDREX/STREX no ARM, `S32C1I` no Xtensa do ESP32) | 4.4 (garantias); base de P1/P4 |
| | **classe de MCUs sem RMW atômico** (ARMv6-M sem LDREX/STREX; RISC-V sem ext. A) → ilustração de custo; o alvo é **ESP32 Xtensa** (provável `S32C1I` → tem atômico) → custo re-centrado no **P3** | 4.4 / 4.3 (custo) ⚠️ confirmar atômicos do Xtensa (ver Decisão 2026-06-15 em [`cap_4_metodologia.md`](cap_4_metodologia.md)) |
| **3.3 Concorrência e Modelo de Memória** *(NOVA)* | contextos de execução concorrente (ISR, tarefa/RTOS, DMA, núcleos) | 4.2.2 eixo 1 (par de contextos) |
| | relação **happens-before** e sincronização | 4.2.1 (def. operacional remete aqui) |
| | **modelo de memória do C11** (DR formal, §5.1.2.4) | 4.2.1 (âncora `\cite`); 4.7 (lado C) |
| | **modelo de memória do Rust** + ordenações de atômicos (Acquire/Release/Relaxed) | 4.2.1; 4.7 (contraste C×Rust) |
| | **data race × race condition** (amplo × estrito; nota histórica Helmbold/Netzer × C11) | 4.2.1 bloco 2 (invoca p/ recorte) |
| **3.4 Rust: Sistema de Tipos e Segurança de Memória** *(NOVA)* | ownership, borrow, lifetimes | 4.3 (fronteira) |
| | **`Send`/`Sync`** | 4.3.2 (critério) |
| | **`safe`/`unsafe` e a fronteira** (o que `unsafe` *não* desliga) | 4.3 (toda a seção) |
| **3.5 Engenharia de Software** *(existe)* | **MISRA C** (o que cobre / não cobre) | 4.7 (lado C) |
| | **sanitizers (TSan/ASan)** e análise dinâmica | 4.7 (dinâmico × prova por tipos) |
| **3.6 Sistemas Embarcados** *(existe)* | `no_std`, RTOS, **RTIC** (resources = mecanismo de sincronização) | 4.4 (eixo de design); Aule 4.5 |
| | footprint / determinismo | 4.4 (trade-offs); 4.6 |

Ordem 3.1→3.6 = domínio → HW → semântica de concorrência → mecanismo Rust → verificação → embarcado. Entrega os conceitos na ordem em que o cap. 4 os puxa.

## Decisões que são do Matheus

1. **Rust = seção própria (3.4) ou subseção de Eng. de Software?** Recomendação do conselheiro: **própria** — o sistema de tipos do Rust *é* o objeto da tese, não uma técnica de SW entre outras.
2. **Fronteira HW × linguagem dos atômicos.** Proposta: substrato de HW em 3.2 (LDREX/STREX, ARMv6-M); modelo de linguagem em 3.3 (happens-before, ordenações), com `\ref` cruzado. Mantém o gancho de custo de P4 ancorado na arquitetura.
3. **Disciplina de escopo** — cada subseção tem consumidor na tabela; o que não tiver, cortar.

## Pendências abertas

- **ARMv6-M / Cortex-M0 sem LDREX/STREX** — confirmar/citar antes de afirmar (atravessa 3.2 → 4.4/4.3).
- **Refs Helmbold & McDowell (1996), Netzer & Miller (1992), C11 §5.1.2.4** — a busca/escolha é do Matheus (Regra 7); Claude só formata o `.bib` quando ele trouxer. Vão em 3.3, não na 4.2.1.
