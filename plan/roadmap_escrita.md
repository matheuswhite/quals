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
---

<!-- LTeX: enabled=false -->

# Roadmap de escrita — qualificação (parede dura: **qua 26/ago/2026**)

Plano de *quando* escrever *o quê*. Não contém prosa da tese — só metas e sequência. Companheiro de [`outline_geral.md`](outline_geral.md) (que diz o que cada seção cobre).

## O que mudou (replanejamento de 09/jun)

> **Superado em 20/jul:** a parede passou de 31/ago → **26/ago** e o escopo do cap. 5 foi cortado p/ **1 caso**. Esta seção é o snapshot histórico de 09/jun; o estado corrente está em "Situação atual (replanejamento de 20/jul)".

- **Prazo:** era fim de julho → agora **fim de agosto/2026 (seg 31/ago)**. Esse é o **limite duro**: depois dele não há parede, folga nem prorrogação. O mês a mais **não é tempo livre** — ele absorve (a) o atraso já acumulado e (b) o ciclo de revisão + feedback do Icaro, que no plano antigo era apertado.
- **Atraso acumulado:** o plano antigo previa 4.1–4.4 fechados até 07/jun. Em 09/jun só **4.1** está escrito (+ rascunho de 1.2). Ritmo real desde 30/mai ≈ **1 seção por semana** de escrita. O plano abaixo já parte desse ritmo realista, não do otimista.
- **Consequência de estratégia:** com a parede em 31/ago, a regra deixa de ser "escrever até o fim e revisar se sobrar" e passa a ser **"travar a escrita ~15/ago e blindar 2 semanas de revisão + feedback"**. Se algo atrasar, corta-se do periférico (regras no fim do arquivo) para proteger a janela de revisão — nunca o contrário.

## Situação atual (replanejamento de 20/jul — defesa 26/ago)

Hoje é **seg 20/jul**, início da W7. **26/ago é a data da DEFESA**, não a entrega do documento — a semana **24–26/ago sai do plano de escrita** (é para montar e ensaiar a apresentação; ver tabela). Logo o documento tem de estar **congelado e revisado até ~23/ago (fim da W11)** — não há revisão na semana da defesa.

> **⚠ A confirmar com o Icaro/programa:** a **data-limite de ENTREGA do documento à banca**. Programas costumam exigir o texto alguns dias/semanas antes da defesa. Se a entrega for **antes de 23/ago**, o núcleo fecha mais cedo e pode forçar corte adicional (regras no fim). O plano abaixo assume documento pronto ~23/ago; ajustar assim que a data real for conhecida.

**Cap. 4 — quase fechado, mas não fechou.** 4.1–4.6 redigidas e revisadas; **a 4.7 é só esqueleto** (`\section{Verificação por Tipos...}` + 3 `\subsection` vazias, `Metodologia_Proposta.tex` ll. 406–415). O marco de fechamento era ~19/jul — você entra na W7 **~1 seção atrasado**.

**O que falta (por peso de escrita):**
- *Pesado (sábado, precisa fôlego):* cap. 5 (caso setpoint) · **cap. 3 = só 3.3+3.4 no núcleo** (3.1/3.2/3.5/3.6 viram parágrafos curtos — ver corte 3) · cap. 2 (Relacionados + tabela). **Cap. 1 saiu dos pesados** → noites (lapidação sobre o rascunho de 1.2).
- *Leve (noites):* **4.7** (protocolo, como a 4.6) · cap. 6 (Cronograma pós-qual) · cap. 7 (Conclusão) · pré-textuais + siglas · acabamento (7 `\cite` vazios na 4.4.1, nomes entre tabelas, `\cite` do firmware na 4.6.3).

**Cortes decididos (20/jul) — cortar *proativamente*, não esperar o gatilho da W10:**
1. **Cap. 5 = 1 caso, profundo (setpoint escalar).** Aciona a regra nº 3 ("1 completo e profundo > vários rasos") já agora. Devolve ~1 semana de escrita pesada.
2. **4.7 enxuta, em noites.** É pós-qual/protocolo; fecha o cap. 4 sem gastar um sábado de núcleo.
3. **Cap. 3 cortado mais fundo (refino 20/jul).** Tem 2 seções novas pesadas (3.3 Concorrência/Modelo de Memória; 3.4 Rust/Tipos) → não cabe em 1 sábado cheio. Corte: **só 3.3+3.4 no nível que os casos/experimento usam; 3.1/3.2/3.5/3.6 → parágrafos curtos.** Guardrail: a banca de memory safety fura na 3.3/3.4 — o corte é na **periferia**, não no núcleo. Cabe em 1 sábado (W8), com a W10 de colchão se a 3.3 estourar.
4. **Cap. 1 desce para as noites (refino 20/jul).** É lapidação sobre o rascunho de 1.2, não escrita nova → libera o 4º sábado.

**Por que os cortes eram necessários:** o corte de casos (3→1) recuperou ~1 semana; **a retirada da semana da defesa (24–26/ago) devolveu ~0,5–1 semana de revisão/margem** que o plano antigo previa depois da entrega. Com o cap. 3 cortado e o cap. 1 nas noites, sobram **só 3 sábados de núcleo (W7–W9)** → a **W10 vira colchão** e o congelamento pode adiantar p/ ~13/ago. Net: revisão de volta a **~1,5–2 semanas (W10-tail + W11)** — sem os cortes, cairia abaixo de 1 semana, furando a regra-mãe.

**Janela restante:** **3 sábados de núcleo (W7–W9: cap. 5 · cap. 3 · cap. 2)** + **W10 de colchão** (fecha cap. 1 + cap. 6/7 + pré-textuais nas noites; absorve overflow do cap. 3/cap. 2) + **~1,5–2 semanas de revisão (W10-tail + W11, até ~23/ago)**. **A semana da defesa não é margem.** Histórico detalhado do plano no log do frontmatter.

## Premissas

- **Janela (a partir de 20/jul):** documento pronto até **~23/ago** (defesa em **26/ago**) ≈ **~5 semanas** ≈ **3 sábados de núcleo (W7–W9) + W10 de colchão + ~1,5–2 semanas de revisão (W10-tail + W11)**. A **semana da defesa (24–26/ago) está fora do plano de escrita** — é só apresentação. A escrita tem **um amortecedor (a W10)** até o congelamento (~13–16/ago); passado ele, atraso come a revisão (ver tabela e riscos). *(A janela original era 09/jun→31/ago ≈ 12 semanas; ver log do frontmatter.)*
- **Dedicação:** parcial — segunda, quarta e quinta à noite + sábado de manhã ≈ **4 blocos/semana (~10–12 h)**. **Divisão de trabalho (refinada 11/jun):** *sábado de manhã* = **escrever seção nova** (é o motor de produção); *noites* = **incorporar o feedback do Icaro + planejar o sábado + ler o cap. 2** — não produzem seção nova. Logo o **throughput de conteúdo novo é ~1 seção/semana**, limitado pelo sábado. Seções leves/mecânicas (cap. 6, cap. 7, pré-textuais) podem caber em noites e **não** devem consumir um sábado.
- **Orientador:** Icaro. Acompanhamento **semanal (às vezes quinzenal)** → **loop de feedback rápido**: o que é entregue volta com observações que o Matheus **incorpora nas noites da mesma semana**, antes de escrever a próxima seção no sábado. Vantagem: corrige rota cedo e reduz retrabalho tardio — o que mais ameaça a parede de 26/ago. Continua valendo: **enviar cada parte do núcleo assim que fechar** (cap. 4 ~26/jul; cap. 5 ~02/ago, juntos no início da W8).
- **Estado de partida (09/jun):** 4.1 escrito; 1.2 em rascunho; todo o resto em esqueleto ou vazio. Experimento de segurança = só protocolo. Aule já madura ([`aule_roadmap.md`](aule_roadmap.md)).
- **Escopo:** ver [`outline_geral.md`](outline_geral.md) §"Decisões fechadas". Qualificação = **proposta + resultados parciais + protocolo**.

## Estratégia

- **Núcleo primeiro.** Cap. 4 (metodologia) + cap. 5 (casos demonstrativos) são a contribuição B e o que a banca mais escrutina. Maior fatia de tempo e enviados ao Icaro primeiro.
- **Fundamentação calibrada DEPOIS do núcleo** — escrever só o que os casos/metodologia usam. Inflar a fundamentação é o **risco nº 1 de estouro**.
- **Relacionados em paralelo** — leitura contínua nas primeiras semanas; redação concentrada quando a leitura amadurecer.
- **Introdução em dois tempos** — o rascunho de 1.2 (pergunta + objetivos) já existe e fixa a direção; lapidação da intro inteira no fim.
- **Escrita é iterativa** — a ordem é a de *foco*, não exclusiva. Voltar e ajustar é esperado.
- **Padrão de uso dos blocos:** sábado de manhã = **redigir seção nova** (precisa de fôlego); noites = **incorporar o feedback do Icaro + planejar o sábado + ler** (tarefas que não exigem fôlego de escrita nova). O feedback rápido do Icaro é a **rede de segurança** contra retrabalho tardio.
- **Esqueleto `.tex` montado no início da semana daquele capítulo** (o `outline_geral.md` já é o esqueleto conceitual).

## Plano semana a semana

Datas ancoradas ao calendário real (semana = seg–dom; **hoje é seg 20/jul**, início da W7). Ajustar conforme o andamento.

> **Premissa da tabela (20/jul, refinada):** **~1 seção pesada/sábado**; itens leves (4.7, **cap. 1 lapidação**, cap. 6, cap. 7, pré-textuais, acabamento) saem em **noites**. **3 sábados de núcleo (W7–W9: cap. 5 caso · cap. 3 cortado · cap. 2) + W10 de colchão.** Núcleo enviado ao Icaro assim que fecha. **A semana da defesa (24–26/ago) está fora — não é tempo de escrita nem de revisão.**

| Sem. | Período | Foco | Saída esperada |
|---|---|---|---|
| **W7** | 20–26 jul | *Sábado:* **cap. 5 — caso setpoint escalar** (bug-C-que-não-compila-em-Rust; código compila/não-compila). *Noites:* **4.7 enxuta** (fecha o cap. 4) + começar estado da Aule/limitações. | **Cap. 4 fechado** + caso do cap. 5 redigido |
| **W8** | 27 jul–02 ago | *Sábado:* **cap. 3 cortado** — **3.3 (Concorrência/Modelo de Memória) + 3.4 (Rust/Tipos)** no nível que os casos/experimento usam; **3.1/3.2/3.5/3.6 = parágrafos curtos**. *Noites:* fechar cap. 5 (estado da Aule + limitações) + acabamento. **Enviar cap. 4 + cap. 5 ao Icaro (~02/ago).** | **Cap. 5 completo**; cap. 3 (núcleo) redigido |
| **W9** | 03–09 ago | *Sábado:* **cap. 2 recortado** (2.1 abordagens + Ada/SPARK + lacuna + **tabela**; verif. formal e libs de controle só posicionadas — ver outline). *Noites:* **cap. 1 lapidado** (intro + incidentes + 1.3) sobre o rascunho de 1.2. **Enviar cap. 3 ao Icaro.** | Cap. 2 + tabela; cap. 1 em curso |
| **W10** | 10–16 ago | **Colchão.** *Sábado:* absorver overflow do cap. 3/cap. 2 **ou** fechar cap. 1. *Noites:* **cap. 6 (Cronograma pós-qual) + cap. 7 (Conclusão) + pré-textuais + siglas** (sem `\lipsum`). **Congelar conteúdo ~13–16/ago** (mais cedo se W7–W9 correrem). | **Documento textualmente completo** |
| **W11** | 17–23 ago | **Revisão integral + fina + PDF final:** consistência entre capítulos, 5 eixos transversais, `\ref`/`\label` quebrados, fluxo do argumento, `.bib` completo e citado, siglas, compilação limpa; incorporar o feedback final do Icaro. **Documento congelado e entregue ~23/ago.** | **PDF final pronto pra banca** |
| ~~W12~~ | 24–26 ago | **Fora do plano de escrita — semana da defesa.** Montar e ensaiar a apresentação. **Defesa: qua 26/ago.** | Apresentação pronta |

> **Onde os cortes batem primeiro (se algo escorregar):** cap. 5 já em 1 caso e cap. 3 já no mínimo (3.3+3.4). O **primeiro amortecedor é a W10** (colchão). Depois dela, o próximo lápis é **cap. 2 → só a tabela + 1 subseção/abordagem**, depois **cap. 1 → não reabrir a intro inteira** (o rascunho de 1.2 já fixa a direção). Ver regras de corte no fim. **Nunca encolher a revisão da W11, rebaixar a 3.3/3.4 abaixo do núcleo, sacrificar o único caso, nem invadir a semana da defesa.**

> **Sobre a "leitura bibliográfica para o cap. 2":** é a leitura dos *trabalhos* que o cap. 2 (Relacionados) vai comparar. Roda **de fundo** ao longo de W7–W9 (não em bloco) — ler + escrever na mesma semana estoura. Para cada trabalho, anotar *que classe de bug elimina e em que momento* (compilação / análise estática / runtime / teste) → vira direto a tabela comparativa. A busca é **do Matheus** (Regra 7); registrar as fontes em `leitura_futura.md` / `referencias.bib`.

## Marcos de controle (datas que disparam alarme se passarem)

- **~26 jul (W7):** **cap. 4 fechado** (4.7 nas noites) + caso setpoint escalar do cap. 5 redigido.
- **~02 ago (W8):** **cap. 5 completo + cap. 3 (3.3+3.4, núcleo) redigido → enviar cap. 4 + cap. 5 ao Icaro.** Maior envio de núcleo; não esperar o fim.
- **~09 ago (W9):** cap. 2 + tabela comparativa fechados; cap. 1 em lapidação (noites).
- **~13–16 ago (W10):** **documento textualmente completo + congelamento de conteúdo** (todos os capítulos + cap. 6/7 + pré-textuais, sem `\lipsum`). A partir daqui, só revisão — nada de seção nova.
- **~23 ago (fim W11):** **documento congelado, revisado e entregue à banca** (PDF final). *(Confirmar se o programa exige entrega antes disso — ver aviso na "Situação atual".)*
- **qua 26 ago:** **defesa.** A semana 24–26 é só apresentação.

A escrita tem **um amortecedor (a W10)** e nada além dele; **a semana da defesa não é margem**. Se o cap. 5 (~26/jul), o cap. 3 (~02/ago) ou o cap. 2 (~09/ago) escorregar a ponto de comer a W10 inteira, acionar **imediatamente** as regras de corte abaixo — passado o colchão, o atraso come a revisão da W11, que não se move.

## Sincronização com o Icaro

- Acompanhamento **semanal (às vezes quinzenal)**: levar a cada reunião o que fechou desde a anterior.
- **Incorporar o feedback nas noites da mesma semana** — não acumular para um mutirão depois; o loop rápido só rende se a correção entra antes da próxima seção.
- **Enviar cada parte do núcleo assim que fechar:** cap. 4 ~26/jul, cap. 5 ~02/ago (juntos, início da W8) — não esperar o fim; é o que mais pode pedir retrabalho.
- Se ele sinalizar mudança de rumo, ajustar o escopo *antes* de avançar — retrabalho tardio é o que fura a parede de 26/ago.

## Definição de "pronto" para a qualificação (mínimo defensável)

- [ ] Pergunta de pesquisa + objetivos claros (cap. 1)
- [ ] Metodologia completa, incluindo o protocolo do experimento (cap. 4)
- [ ] **1 caso demonstrativo completo e profundo** (setpoint escalar) mostrando bug-C-que-não-compila-em-Rust (cap. 5) — *escopo travado em 1 caso (decisão 20/jul); os demais viram trabalho pós-qual (cap. 6)*
- [ ] Estado atual da Aule documentado (cap. 5)
- [ ] Fundamentação enxuta cobrindo só o que o núcleo usa (cap. 3) — **3.3 (modelo de memória/data race) + 3.4 (Rust/tipos) sólidas**; 3.1/3.2/3.5/3.6 em parágrafos curtos
- [ ] Relacionados com tabela comparativa por abordagem de garantia (cap. 2)
- [ ] Cronograma da dissertação — trabalho pós-qualificação (cap. 6)
- [ ] Pré-textuais reais (sem `\lipsum`, sem siglas herdadas do template)
- [ ] Compila limpo (`latexmk`)

## Riscos e regras de corte (se atrasar)

Com a **defesa em 26/ago** e a semana 24–26 reservada só para a apresentação, o objetivo dos cortes é **proteger a revisão da W11 (17–23/ago) + o congelamento até ~16/ago**. Já acionados proativamente em 20/jul: **casos 3→1**, **4.7 em noites**, **cap. 3 cortado à periferia (só 3.3+3.4 no núcleo)**, **cap. 1 em noites** e **cap. 2 recortado a tabela + prosa mínima** (verif. formal e libs de controle rebaixadas; Ada/SPARK mantido — ver [`outline_geral.md`](outline_geral.md)). O próximo lápis desce nesta ordem:

1. **A W10 (colchão)** — primeiro amortecedor: absorve overflow antes de qualquer corte de conteúdo.
2. **Cap. 2 ainda crescendo** → segurar em 2.1 + Ada/SPARK + lacuna + tabela; verif. formal e libs de controle já rebaixadas (não reabrir).
3. **Cap. 1** → não reabrir a intro inteira; lapidar sobre o rascunho de 1.2, que já fixa pergunta + objetivos.
4. **Cap. 6/7 + pré-textuais** → são de noites; se apertarem, o **cap. 6 (cronograma pós-qual) tem prioridade sobre a conclusão** — a banca de qualificação cobra o plano da dissertação.

**Nunca cortar** (é o que define a qualificação sob enquadramento B): pergunta de pesquisa clara, protocolo do experimento (4.6), **o caso setpoint escalar — agora único, virou intocável**, **o núcleo da fundamentação (3.3 modelo de memória/data race + 3.4 ownership/`Send`-`Sync`/`unsafe`) — a banca de memory safety fura exatamente aí**, e o eixo "fronteira do que Rust não garante" (honestidade). **Nem encolher a revisão da W11, nem invadir a semana da defesa (24–26/ago).**

> Atenção: o **cap. 6 da tese** (Cronograma de Execução) planeja o trabalho *pós-qualificação* (implementar o experimento, MPC/IMC, verificação formal, **bloco out-of-box da Aule para concorrência `ISR↔DMA`** — ver abaixo) — é diferente **deste** arquivo, que é o cronograma de *escrita da qualificação*.
>
> **Bloco out-of-box `ISR↔DMA` (decisão 30/mai):** o *exemplo demonstrativo* do data race ISR↔tarefa entra **na qualificação** como código **fora da Aule** (Rust puro: RTIC / atomic / `Send`-`Sync`) — é a evidência da classe de memory safety da tese. O *bloco reutilizável da Aule* que encapsula esse padrão de forma ergonômica é **trabalho pós-qualificação**, a ser proposto no cap. 6. Ter o **esboço do mecanismo** (como expor o recurso compartilhado de forma safe) pronto para a defesa, mesmo sem implementar. Ver `recorte_tese.md`.

## Manutenção deste roadmap

- Atualizar o status no início de cada semana (feito / atrasado / replanejado).
- Se uma semana estourar, empurrar e cortar do **periférico** (regras acima), nunca da janela de revisão nem do núcleo.
- Registrar desvios — serve de insumo honesto pro cap. 6 (estimar o ritmo real ajuda a planejar a dissertação).
