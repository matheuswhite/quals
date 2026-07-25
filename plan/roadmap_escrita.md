---
author: Claude (claude-opus-4-7)
created: 2026-05-28
modified:
  - 2026-05-30: Claude (claude-opus-4-8) — anotado o bloco out-of-box da Aule p/ ISR↔DMA como trabalho pós-qualificação (cap. 6)
  - 2026-06-04: Claude (claude-opus-4-8) — semanas 1-2 realinhadas à estrutura método-por-objetivo do cap. 4 (4.1–4.4 = obj 1–3; 4.5–4.7 = pós-qual); regra de corte atualizada (delay line → setpoint escalar); ver cap_4_metodologia.md
  - 2026-06-09: Claude (claude-opus-4-8) — replanejamento integral para o novo prazo (fim de agosto/2026, parede dura). Recalibrado ao estado real (só 4.1 + rascunho de 1.2 escritos) e ao ritmo observado (~1 seção/semana). Janela reorganizada em 11 semanas de escrita + bloco final de revisão/feedback sem folga depois de 31/ago.
  - 2026-06-11: Claude (claude-opus-4-8) — recalibrado ao ritmo real de ~1 seção nova por sábado e ao loop de feedback semanal/quinzenal com o Icaro (noites = incorporar feedback + planejar + ler; sábado = escrever novo). Tabela semana-a-semana refeita; marcos do cap. 4 e cap. 5 movidos para ~05/jul e ~19/jul; escrita agora sem folga até o congelamento (~15/ago).
  - 2026-06-21: Claude (claude-opus-4-8) — reconciliado com a estrutura real do cap. 4 (4.1–4.7 fechada; a §4.3 virou 4 unidades de escrita e não cabia em "1 sábado" como a tabela previa) e com o estado de 21/jun (4.1, 4.2 e §4.3 abertura+4.3.1+4.3.2 redigidas e revisadas; restam 4.3.3, 4.4, 4.5, 4.6, 4.7). Tabela refeita p/ W3–W12; marcos do cap. 4 e cap. 5 escorregaram ~2 semanas (~19/jul e ~02/ago), absorvendo o tamanho real da §4.3 + a migração ESP32; janela de revisão (W11–W12) preservada, mas o colchão antes da parede encolheu de ~6 p/ ~4 semanas.
  - 2026-06-26: Claude (claude-opus-4-8) — §4.4 inteira (4.4.1 + 4.4.2) redigida e revisada; núcleo analítico (obj 1–3) completo ~1 semana adiantado vs. a tabela de 21/jun (que previa 4.4 só na W4). Tabela W3–W10 deslizada ~1 semana p/ a esquerda; cap. 4 antecipa p/ ~12/jul, cap. 5 p/ ~26/jul; W10 vira colchão recuperado (margem antes da parede de ~4 p/ ~5 semanas). Resta na §4.4 só acabamento (ortografia · 7 `\cite` vazios na 4.4.1 · nomes entre as 3 tabelas).
  - 2026-07-04: Claude (claude-opus-4-8) — **§4.5 inteira fechada** (4.5.1 01/jul · 4.5.2 04/jul · 4.5.3 04/jul). W4 (29/jun–05/jul) previa "4.5 + 4.6"; a §4.5 virou 3 subseções e consumiu a W4 — a 4.6 escorrega p/ a W5. Restam 4.6 + 4.7 (ambas pós-qual/protocolo, mais leves) p/ fechar o cap. 4 no marco de ~12/jul. No prazo. Decisões da 4.5.3 registradas em [`cap_4_metodologia.md`](cap_4_metodologia.md) §4.5 (blocos sync = plan-only; `forbid` no core).
  - 2026-07-06: Claude (claude-opus-4-8) — decisão do Matheus: **não fechar 4.6 + 4.7 na mesma semana** (a W5 previa as duas). Desmembradas: **W5 = 4.6 (protocolo do experimento); W6 = 4.7** → cap. 4 fecha ~19/jul (era ~12/jul). Todo o núcleo escorrega ~1 semana: cap. 5 ~02/ago (era ~26/jul). O **colchão da W10 é consumido** — a W10 volta a ser "cap. 2 + cap. 1" (sobrecarregada, gatilho provável das regras de corte) e a margem cap.5→parede cai de ~5 p/ **~4 semanas**. Janela de revisão (W11–W12) preservada. Tabela W4–W12 e marcos refeitos.
  - 2026-07-08: Claude (claude-opus-4-8) — **§4.6.1 (Planta e plataforma) redigida e revisada** (planta Furuta física → ESP32; decisão B = âncora única na fronteira ISR↔tarefa P3; execução em 2 estágios, HIL dropado). Decisões detalhadas em [`cap_4_metodologia.md`](cap_4_metodologia.md) §4.6.1. **Ponto de retomada: próxima = 4.6.2** (implementações comparadas). No prazo (W5).
  - 2026-07-13: Claude (claude-opus-4-8) — **§4.6.2 (Implementações comparadas) redigida e revisada** (blocos 1–5 + tabela `tab:impl-compare`). Config B fixada: C+FreeRTOS(ESP-IDF)+MISRA vs Rust `no_std`+heapless+esp-hal bare-metal; **RTIC abandonado** (não suporta Xtensa); substrato assimétrico assumido e tratado por decomposição; Kalman pós-qual (Luenberger×Kalman reconciliado). Decisões em [`cap_4_metodologia.md`](cap_4_metodologia.md) §4.6.2. Falta só passe de forma. **Ponto de retomada: próxima = 4.6.3** (métricas e instrumentação). No prazo (W5).
  - 2026-07-16: Claude (claude-opus-4-8) — **§4.6.3 (Métricas e instrumentação) redigida e revisada** (blocos 1–5; convergência em várias rodadas de revisão banca). Decisões-chave: **auto-cancelamento da sonda `CCOUNT`** (viés constante cancela na subtração externa W−B, não dentro de um delta; jitter depende de variância desprezível); **tick do FreeRTOS sai da janela por mascaramento** (seção crítica adia o tick → variável de estudo e jitter tick-free) e é reportado como substrato só no deadline; **heap = custo de veículo**, fora da janela; **dois níveis de medição** (região guardada vs laço); jitter = máx−mín (deadline hard); footprint por barreira de otimização (otimização LIGADA). Decisões em [`cap_4_metodologia.md`](cap_4_metodologia.md) §4.6.3. Falta passe de forma + `\cite` do firmware. **Ponto de retomada: próxima = 4.6.4** (limites qualificação/dissertação). Cal. **W6** (13–19 jul); a §4.6 escorregou de W5 e restam **4.6.4 + 4.7** p/ fechar o cap. 4 (marco ~19/jul apertado).
  - 2026-07-18: Claude (claude-opus-4-8) — **§4.6.4 (Limites qualificação/dissertação) redigida e revisada** → **§4.6 inteira fechada** (4.6.1–4.6.4). Roteiro em 2 blocos + verificação banca de 6 furos (todos fechados). Decisões-chave: **limiar de "empate" = máx−min da distribuição do ruído da região vazia B** (dispersão, não "menor valor"; coerente com jitter = máx−min da 4.6.3 — regra fixa agora, valor adia); **N (repetições) = ponto em que a distribuição estabiliza**; escopo travado no **experimento de custo** (a 4.7 tem limite próprio, 4.7.3); "nº de cenários" **removido** (âncora única P3) e "placa" → "**variante da ESP32 da planta**" (consistência c/ 4.6.1). Regra-mãe: adiar o *quanto* sem adiar o *como*. Decisões em [`cap_4_metodologia.md`](cap_4_metodologia.md) §4.6.4. Falta passe de forma. **Ponto de retomada: próxima = 4.7** (obj 8 — verificação por tipos vs C+MISRA+sanitizers). Cal. **W6**; cap. 4 fecha na 4.7 (marco ~19/jul).
  - 2026-07-20: Claude (claude-opus-4-8) — **replanejamento p/ nova parede dura: qua 26/ago (era seg 31/ago).** Reconciliado ao estado de 20/jul (início da W7): cap. 4 com 4.1–4.6 fechadas mas **4.7 só esqueleto** (`\section` + 3 `\subsection` vazias, `Metodologia_Proposta.tex` ll. 406–415) → cap. 4 **não fechou**, ~1 seção atrasado vs. o marco ~19/jul; cap. 5 e cap. 2 vazios, cap. 3 em esqueleto, cap. 1 com rascunho de 1.2. **26/ago é a data da DEFESA**, não a entrega do documento; a semana **24–26/ago sai do plano de escrita** (montar/ensaiar a apresentação) → documento congelado e revisado até **~23/ago (fim da W11)**. Dois cortes de escopo (decisão do Matheus) p/ reconstruir o colchão e blindar a revisão (agora ~1,5 semana: W10-tail + W11): **(1) cap. 5 = 1 caso profundo (setpoint escalar), não 3** — aciona a regra de corte nº 3 proativamente; **(2) 4.7 escrita enxuta em noites** (nível protocolo, como a 4.6), sem consumir sábado. Tabela refeita W7–W11 (W12 = só a defesa, fora do plano); marcos e regras de corte atualizados. Regra-mãe intacta: nunca encolher a revisão.
  - 2026-07-20 (refino): Claude (claude-opus-4-8) — pesados o cap. 3 e o cap. 2 (a pedido do Matheus). Cap. 3 tem **duas seções novas pesadas** (3.3 Concorrência/Modelo de Memória — 5 subseções C11/Rust; 3.4 Rust/Tipos) → não cabe em 1 sábado no formato cheio. Decisão do Matheus: **cortar o cap. 3 mais fundo** — só 3.3 + 3.4 no nível que os casos/experimento usam; **3.1/3.2/3.5/3.6 viram parágrafos curtos** → cabe em 1 sábado (W8). **Cap. 1 desce para as noites** (é lapidação sobre o rascunho de 1.2, não escrita nova) → libera o 4º sábado. Resultado: **3 sábados de núcleo** (W7 cap. 5 · W8 cap. 3 · W9 cap. 2) + **W10 vira colchão** (absorve overflow do cap. 3/cap. 2, fecha cap. 1 + cap. 6/7 + pré-textuais nas noites) → congelamento pode adiantar p/ ~13/ago e a revisão volta a **~1,5–2 semanas** (W10-tail + W11). Guardrail (papel de revisor): a banca de memory safety fura exatamente na 3.3/3.4 — o corte é na **periferia**; 3.3+3.4 ficam sólidas (intocáveis).
  - 2026-07-25: Claude (claude-opus-4-8) — **nova parede: sex 7/ago (era ter 11/ago)**, antecipação *autoimposta* (o regimento só exige 11/ago; 7/ago dá ~4 dias de folga extra antes da defesa, mas encurta a escrita). **Corte do cap. 2 INTEIRO** (Trabalhos Relacionados sai do documento — não consta do template do IC, foi adicionado a mais, não é obrigatório na qualificação); `relatedworks.tex` só tinha o `\mychapter` e ninguém faz `\ref{cap:relatedworks}` → corte limpo. **Consequência dura:** 7/ago é sexta → o **sábado 08/ago de revisão some**; a revisão migra p/ as noites 03–06/ago (o corte do cap. 2 devolve o tempo). **Reconciliado ao estado REAL** (o roadmap dizia 4.7-esqueleto/cap.5-vazio, hoje FALSO): cap. 4 completo (4.1–4.7 + fecho; só passe de forma); cap. 5 §5.2 fechada (5.2.1–5.2.5 escritas/revisadas), faltam §5.1 + §5.3 + passe. Janela: **2 sábados (25/jul · 01/ago) + ~6 noites**. Tabela de repositórios/bibliotecas de controle: vira **seção dedicada no cap. 5** (Resultados Parciais; subseções se preciso). **A pesquisa já está feita e a tabela existe numa planilha** (curadoria do Matheus — Regra 7 satisfeita); falta só transcrevê-la para o `.tex` + escrever a prosa (trabalho leve, W8).
  - 2026-07-23: Claude (claude-opus-4-8) — **replanejamento p/ a PAREDE REAL DO DOCUMENTO: ter 11/ago.** O regimento exige entrega à banca **15 dias corridos** antes da defesa (26/ago) → o documento tem de estar congelado e entregue em **11/ago** (confirmado com o Matheus: corridos, não úteis), não ~23/ago. A janela de hoje (qui 23/jul) até lá caiu de ~5 semanas p/ **~2,7 semanas** e **a antiga janela de revisão (W11, 17–23/ago) some** — o período 12–26/ago fica pós-entrega (documento travado; só prep da defesa). Restam **3 sábados (25/jul · 01/ago · 08/ago) + ~8 noites**. Novo corte (decidido pelo Matheus, 23/jul): **cap. 2 sai do sábado e vira noites** (só tabela + Ada/SPARK + lacuna) p/ liberar o **Sat 08/ago como dia de revisão** e proteger ~3–4 blocos de revisão final (08–11/ago). **Regra-mãe reescrita:** entregar em 11/ago um documento coerente e que compila, com o núcleo (cap. 4+5, 3.3/3.4) sólido; todo o resto é cortável. Ação urgente: **enviar o cap. 4 (4.1–4.6, já pronto) ao Icaro AGORA**, sem esperar a 4.7 — é o único jeito de caber uma rodada de feedback do núcleo antes da entrega. Tabela refeita W7–W10 (W11+ fora do plano). Histórico anterior preservado abaixo.
---

<!-- LTeX: enabled=false -->

# Roadmap de escrita — qualificação (**entrega do documento à banca: sex 7/ago/2026** · defesa: qua 26/ago)

Plano de *quando* escrever *o quê*. Não contém prosa da tese — só metas e sequência. Companheiro de [`outline_geral.md`](outline_geral.md) (que diz o que cada seção cobre).

## As duas paredes (leia primeiro)

Existem **duas datas duras**, e a que rege a escrita **não** é a da defesa:

- **Entrega do documento à banca: sex 7/ago/2026** ← **esta é a parede da escrita.** É uma antecipação *autoimposta*: o regimento exige o texto só 15 dias corridos antes da defesa (**11/ago**), mas a entrega foi puxada para **7/ago** — dá ~4 dias de folga extra antes da defesa, ao custo de encurtar a escrita. Depois dela o documento está *entregue e travado*.
- **Defesa: qua 26/ago/2026.** O período **8–26/ago** é **pós-entrega**: documento intocável, tempo só para **montar e ensaiar a apresentação**.

**Consequência:** toda a pressão está *antes* de 7/ago. Da data de hoje (**sáb 25/jul**) até lá são **~13 dias ≈ 2 semanas**. Como 7/ago é **sexta**, o **sábado 08/ago sai da janela** — não há mais nenhum sábado de revisão dedicado; a revisão tem de acontecer nas noites de 03–06/ago e na manhã da entrega.

## Situação atual (replanejamento de 25/jul — entrega 7/ago)

Hoje é **sáb 25/jul**, W7. A parede andou de 11/ago para **7/ago** (autoimposta) e some o sábado 08/ago de revisão.

**Blocos que sobram até a entrega (7/ago):**
- **2 sábados:** 25/jul (W7) · 01/ago (W8). *(08/ago é depois da entrega — não conta.)*
- **~6 noites** (seg/qua/qui): W8 (27, 29, 30 jul) + W9 (03, 05, 06 ago).
- **Manhã de sex 07/ago** para o passe final.

**Estado REAL do texto (reconciliado em 25/jul — o roadmap anterior estava desatualizado):**
- **Cap. 4** — **completo (4.1–4.7 + fecho).** Falta só passe de forma (6 `\cite` vazios; tabela TODO na §4.3.3; ortografia §4.5/§4.7).
- **Cap. 5** — **§5.2 (caso setpoint P1) fechada em conteúdo** (5.2.1–5.2.5 escritas e revisadas em banca). Faltam **§5.1 (estado da Aule)** e **§5.3 (limitações)** — só headings — + passe de forma da §5.2 (inclui colar a listagem do `rustc` na 5.2.3, hoje vazia).
- **Cap. 3** — esqueleto.
- **Cap. 2** — **CORTADO** (ver abaixo).
- **Cap. 1** — rascunho de 1.2 (pergunta + objetivos).
- **Cap. 6/7 + pré-textuais** — vazios / `\lipsum`.

**Corte novo (decidido pelo Matheus, 25/jul) — cap. 2 sai do documento:** o cap. de Trabalhos Relacionados **não consta do template do IC** (foi adicionado a mais) e **não é obrigatório na qualificação** → é removido inteiro (comentar o `\include` no `main.tex`; `relatedworks.tex` estava vazio; nenhum `\ref{cap:relatedworks}` a quebrar). Isso devolve as noites que o plano de 11/ago reservava para o cap. 2 — é o que compensa a perda do sábado 08/ago de revisão. **A tabela de repositórios/bibliotecas de controle** que iria para o cap. 2 vira uma **seção dedicada no cap. 5** (Resultados Parciais; com subseções se preciso), situando a Aule no panorama de libs de controle. **A pesquisa já foi feita e a tabela existe numa planilha** (curadoria do Matheus — Regra 7 satisfeita: ele buscou e decidiu). Falta só **transcrever a planilha para uma tabela LaTeX + escrever a prosa** — trabalho **leve** (não é montar pesquisa), cabe numa noite da W8. Risco baixo; deixa de ser candidata a corte por causa da busca.

**Onde a folga real aparece:** o cap. 5 estava dado como "vazio" no plano antigo, mas a §5.2 já está fechada — o sábado 25/jul não escreve o caso do zero, só fecha §5.1 + §5.3 + passe de forma. Sobra capacidade para adiantar o cap. 3 ou a revisão.

**Regra-mãe (mantida):** entregar em 7/ago um documento coerente, que compila, com o núcleo sólido (cap. 4 + cap. 5 + 3.3/3.4) e um passe de revisão final. Sem sábado de revisão, ela é **incremental nas noites**; o que não fechar até 06/ago aciona os cortes na mesma noite. **O que não se corta:** o único caso (cap. 5), o protocolo (4.6), a 3.3/3.4, e o passe de revisão final mínimo (não entregar cru).

**Ação urgente:** **cap. 4 (completo) + cap. 5 (assim que §5.1/§5.3 fecharem) ao Icaro** — sob esta janela cabe no máximo uma rodada de feedback do núcleo antes de 7/ago.

## Premissas

- **Janela (a partir de 25/jul):** documento **congelado e entregue em sex 7/ago** ≈ **~2 semanas** = **2 sábados (25/jul · 01/ago) + ~6 noites + a manhã de 7/ago**. **Não há colchão nem sábado de revisão** (08/ago é pós-entrega) — a revisão é incremental nas noites 03–06/ago. O período 8–26/ago é pós-entrega (só apresentação). *(A janela original 09/jun→31/ago era ~12 semanas; a de 20/jul, ~5; a de 23/jul mirava 11/ago; ver log do frontmatter.)*
- **Dedicação:** parcial — seg, qua e qui à noite + sábado de manhã ≈ **4 blocos/semana**. *Sábado* = escrever seção nova (motor de produção); *noites* = incorporar feedback do Icaro + fechar itens leves + planejar + ler. Throughput de conteúdo novo pesado ≈ **1 seção/sábado**.
- **Orientador (Icaro):** semanal/quinzenal. Sob esta parede, **cabe ~1 rodada de feedback do núcleo** — por isso o cap. 4 + cap. 5 vão assim que o cap. 5 fechar. O cap. 3 provavelmente terá só um passe rápido (ou nenhum) antes de 7/ago; escrevê-lo defensável "de primeira" pesa mais agora.
- **Estado de partida (25/jul):** ver "Situação atual". Experimento de segurança = só protocolo (correto para qualificação). Aule madura ([`aule_roadmap.md`](aule_roadmap.md)).
- **Escopo:** ver [`outline_geral.md`](outline_geral.md) §"Decisões fechadas". Qualificação = **proposta + resultados parciais + protocolo**.

## Estratégia

- **Núcleo primeiro, e enviado cedo.** Cap. 4 + cap. 5 são a contribuição B e o foco da banca. Cap. 4 vai ao Icaro **hoje**; cap. 5 assim que fechar.
- **Cap. 2 cortado do documento** (não consta do template do IC, adicionado a mais, não obrigatório na qualificação) — devolve as noites que o plano de 11/ago reservava para ele; é o que compensa a perda do sábado 08/ago de revisão.
- **Fundamentação calibrada** — só 3.3 (concorrência/modelo de memória) + 3.4 (Rust/tipos) no nível que o núcleo usa; 3.1/3.2/3.5/3.6 em parágrafos curtos. Inflar aqui é o risco nº 1 de estouro.
- **Introdução por lapidação** — o rascunho de 1.2 fixa a direção; a intro fecha em noites, não reabre.
- **Revisão incremental, não guardada para o fim** — como não há semana de revisão, cada seção fechada já passa por um passe de forma na noite seguinte; o bloco final (03–06/ago + manhã de 07) é integração e consistência, não primeira revisão.
- **Escrita é iterativa** — a ordem é de *foco*, não exclusiva.

## Plano semana a semana

Datas ancoradas ao calendário real (semana = seg–dom; **hoje é sáb 25/jul**, W7). **Parede: sex 7/ago.**

> **Premissa da tabela (25/jul):** **1 seção pesada/sábado**; itens leves (cap. 1, cap. 6, cap. 7, pré-textuais, acabamento, §5.1/§5.3) saem em **noites**. **2 sábados: 25/jul cap. 5 · 01/ago cap. 3.** **Cap. 2 cortado** (não entra). Núcleo ao Icaro assim que fecha (cap. 4 já pronto). **Sem sábado de revisão** — revisão incremental nas noites 03–06/ago. **8–26/ago = pós-entrega.**

| Sem. | Período | Foco | Saída esperada |
|---|---|---|---|
| **W7** | 25–26 jul | *Sábado 25:* **fechar o cap. 5** — a §5.2 (caso setpoint) já está pronta; escrever §5.1 (estado da Aule) + §5.3 (limitações) + passe de forma da §5.2 (colar a listagem do `rustc` na 5.2.3). *Dom:* **enviar cap. 4 + cap. 5 ao Icaro.** | Cap. 5 completo; cap. 4 + 5 no Icaro |
| **W8** | 27 jul–02 ago | *Sábado 01:* **cap. 3 — 3.3 + 3.4** no nível do núcleo (3.1/3.2/3.5/3.6 = parágrafos curtos). *Noites:* incorporar feedback do Icaro + passe de forma do cap. 4/5 + **seção de repos de controle no cap. 5** (transcrever a planilha + escrever) + começar cap. 1 (lapidar 1.2). | Cap. 3 (núcleo) redigido; seção de repos no cap. 5; feedback do núcleo incorporado |
| **W9** | 03–07 ago | *Noites 03–06:* fechar **cap. 1** + **cap. 6 + cap. 7 + pré-textuais** (sem `\lipsum`) **e revisar incremental** (consistência, `\ref`/`\label`, `.bib`, siglas, compilação). **Congelar conteúdo ~qui 06/ago.** *Sex 07 (manhã):* **passe final** — PDF limpo, checklist de "pronto", **entregar à banca**. | **PDF final entregue (sex 7/ago)** |
| — | 8–26 ago | **Pós-entrega — fora do plano de escrita.** Documento travado. Montar e ensaiar a apresentação. **Defesa: qua 26/ago.** | Apresentação pronta |

> **Onde os cortes batem primeiro (se algo escorregar):** não há colchão nem sábado de revisão. O cap. 2 já saiu. O primeiro lápis é **cap. 1 → não reabrir a intro** (1.2 já fixa direção); depois **cap. 7 (conclusão) → mínima**, mantendo o cap. 6 (cronograma pós-qual, que a banca cobra). **Nunca:** sacrificar o único caso (cap. 5), o protocolo (4.6), a 3.3/3.4, nem o passe de revisão final. Se o cap. 3 (~01/ago) escorregar a ponto de comer as noites de revisão (03–06/ago), **acionar os cortes imediatamente** — não há para onde empurrar depois de 7/ago.

> **Pesquisa de repositórios de controle → seção nova no cap. 5:** a tabela que sairia no cap. 2 (cortado) vira uma **seção dedicada nos Resultados Parciais** (subseções se preciso), situando a Aule entre as bibliotecas de controle. **A pesquisa já está feita e a tabela existe numa planilha** (curadoria do Matheus — Regra 7). Falta só **transcrever a planilha → tabela LaTeX + escrever a prosa** (W8, noite). Para a banca, vale registrar o **método da busca** (bases, strings, critério de inclusão/exclusão) — modelo em `registro_busca_bibliografica.md` — e **versionar a planilha (ou um CSV)** no repo para rastreabilidade.

## Marcos de controle (datas que disparam alarme se passarem)

- **~sáb 25/jul (W7):** **cap. 5 completo** (§5.2 já pronta; fechar §5.1 + §5.3 + passe de forma); **cap. 4 + cap. 5 ao Icaro.** Gatilho da única rodada de feedback do núcleo.
- **~sáb 01/ago (W8):** cap. 3 (3.3+3.4) redigido; feedback do núcleo em incorporação.
- **~qui 06/ago (W9):** **congelamento de conteúdo** — todos os capítulos + cap. 6/7 + pré-textuais (sem `\lipsum`). *(Cap. 2 não entra — cortado.)* A partir daqui só revisão.
- **sex 7/ago:** **documento congelado, revisado e ENTREGUE à banca** (PDF final). **Parede dura — não se move.**
- **qua 26/ago:** **defesa.** 8–26/ago = só apresentação.

**Não há amortecedor.** Se o cap. 3 (~01/ago) escorregar, o corte entra no mesmo dia (regras no fim). Passado 7/ago não há folga: o atraso vira entrega crua ou não-entrega.

## Sincronização com o Icaro

- **Enviar cap. 4 + cap. 5 ao Icaro assim que o cap. 5 fechar (~26/jul)** — é o que cabe de feedback antes da parede; não acumular para o fim.
- **Incorporar o feedback nas noites da mesma semana** — o loop rápido só rende se a correção entra antes da próxima seção.
- Cap. 3 provavelmente entra sem rodada de feedback completa; **avisar o Icaro da parede de 7/ago** para calibrar a expectativa e priorizar o retorno sobre o cap. 4/5.
- Se ele sinalizar mudança de rumo, ajustar o escopo *antes* de avançar — retrabalho tardio, nesta janela, não tem para onde caber.

## Definição de "pronto" para a qualificação (mínimo defensável)

- [ ] Pergunta de pesquisa + objetivos claros (cap. 1)
- [ ] Metodologia completa, incluindo o protocolo do experimento (cap. 4) — **completa (4.1–4.7); falta passe de forma**
- [ ] **1 caso demonstrativo completo e profundo** (setpoint escalar) mostrando bug-C-que-não-compila-em-Rust (cap. 5) — *escopo travado em 1 caso; os demais viram trabalho pós-qual (cap. 6)*
- [ ] Estado atual da Aule documentado (cap. 5)
- [ ] Seção de pesquisa de repositórios/bibliotecas de controle no cap. 5 (com tabela) — situa a Aule no panorama; **pesquisa feita, tabela na planilha** (Regra 7 ok) → falta transcrever p/ o `.tex` + escrever (trabalho leve)
- [ ] Fundamentação enxuta cobrindo só o que o núcleo usa (cap. 3) — **3.3 (modelo de memória/data race) + 3.4 (Rust/tipos) sólidas**; 3.1/3.2/3.5/3.6 em parágrafos curtos
- [ ] Cronograma da dissertação — trabalho pós-qualificação (cap. 6)
- [ ] Pré-textuais reais (sem `\lipsum`, sem siglas herdadas do template)
- [ ] Compila limpo (`latexmk`) + `.ref`/`.label` sem quebras + `.bib` citado

## Riscos e regras de corte (se atrasar)

Com a **entrega em 7/ago** e **sem colchão nem sábado de revisão**, o objetivo dos cortes é **preservar o núcleo (cap. 4+5, 3.3/3.4) e um passe de revisão final mínimo**. Já acionados: **casos 3→1**, **cap. 3 à periferia (só 3.3+3.4 no núcleo)**, **cap. 1 em noites**, e — novo em 25/jul — **cap. 2 CORTADO do documento** (não é do template do IC; devolve as noites que compensam a perda do sábado 08/ago). O próximo lápis desce nesta ordem:

1. **Cap. 1** → não reabrir a intro; lapidar sobre o rascunho de 1.2.
2. **Cap. 7 (conclusão) → mínima**; **manter o cap. 6** (cronograma pós-qual — a banca de qualificação cobra o plano da dissertação).
3. **Acabamento não-bloqueante** (nomes entre tabelas, `\cite` de firmware) → só se sobrar; não pode atrasar a compilação limpa.

**Nunca cortar** (define a qualificação sob enquadramento B): pergunta de pesquisa clara, protocolo do experimento (4.6), **o caso setpoint escalar (único, intocável)**, **o núcleo da fundamentação (3.3 modelo de memória/data race + 3.4 ownership/`Send`-`Sync`/`unsafe`)**, o eixo "fronteira do que Rust não garante" (honestidade), e **um passe de revisão final** (não entregar cru). A entrega de 7/ago **não se move**.

> **Atenção:** o **cap. 6 da tese** (Cronograma de Execução) planeja o trabalho *pós-qualificação* (implementar o experimento, MPC/IMC, verificação formal, **bloco out-of-box da Aule para concorrência `ISR↔DMA`**) — é diferente **deste** arquivo, que é o cronograma de *escrita da qualificação*.
>
> **Bloco out-of-box `ISR↔DMA` (decisão 30/mai):** o *exemplo demonstrativo* do data race ISR↔tarefa entra **na qualificação** como código **fora da Aule** (Rust puro: atomic / `Send`-`Sync`) — evidência da classe de memory safety da tese. O *bloco reutilizável da Aule* que encapsula o padrão é **pós-qualificação**, proposto no cap. 6. Ter o **esboço do mecanismo** pronto para a defesa, mesmo sem implementar. Ver `recorte_tese.md`.

## Manutenção deste roadmap

- Atualizar o status no início de cada semana (feito / atrasado / replanejado).
- Sem colchão: se uma semana estourar, o corte entra **no mesmo dia** (regras acima) — nunca da revisão final nem do núcleo.
- Registrar desvios — insumo honesto pro cap. 6 (o ritmo real ajuda a planejar a dissertação).
