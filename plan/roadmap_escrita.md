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
---

<!-- LTeX: enabled=false -->

# Roadmap de escrita — qualificação (até **final de agosto/2026**)

Plano de *quando* escrever *o quê*. Não contém prosa da tese — só metas e sequência. Companheiro de [`outline_geral.md`](outline_geral.md) (que diz o que cada seção cobre).

## O que mudou (replanejamento de 09/jun)

- **Prazo:** era fim de julho → agora **fim de agosto/2026 (seg 31/ago)**. Esse é o **limite duro**: depois dele não há parede, folga nem prorrogação. O mês a mais **não é tempo livre** — ele absorve (a) o atraso já acumulado e (b) o ciclo de revisão + feedback do Icaro, que no plano antigo era apertado.
- **Atraso acumulado:** o plano antigo previa 4.1–4.4 fechados até 07/jun. Em 09/jun só **4.1** está escrito (+ rascunho de 1.2). Ritmo real desde 30/mai ≈ **1 seção por semana** de escrita. O plano abaixo já parte desse ritmo realista, não do otimista.
- **Consequência de estratégia:** com a parede em 31/ago, a regra deixa de ser "escrever até o fim e revisar se sobrar" e passa a ser **"travar a escrita ~15/ago e blindar 2 semanas de revisão + feedback"**. Se algo atrasar, corta-se do periférico (regras no fim do arquivo) para proteger a janela de revisão — nunca o contrário.

## Situação atual (replanejamento de 21/jun)

Reconciliação com a estrutura **real** do cap. 4 (ver [`cap_4_metodologia.md`](cap_4_metodologia.md)). A tabela de 11/jun ficou desatualizada em dois pontos **estruturais**, não só de data.

**Estrutura do cap. 4 — FECHADA em 4.1–4.7 (método-por-objetivo):** 4.1 caracterização · 4.2 taxonomia (obj 1) · 4.3 fronteira safe/unsafe (obj 2) · 4.4 espaço de design + custo (obj 3) · 4.5 Aule como veículo (obj 4, pós-qual) · 4.6 protocolo do experimento (obj 5–7, pós-qual) · 4.7 verificação por tipos vs C+MISRA (obj 8, pós-qual).

**Feito e revisado (banca):** 4.1 · 4.2 (4.2.1–4.2.3) · §4.3 completa (abertura + 4.3.1 + 4.3.2 + 4.3.3) · **§4.4 completa (4.4.1 + 4.4.2), redigida e revisada 26/jun** — resta só acabamento (ortografia · 7 `\cite` vazios na 4.4.1 · nomes entre as 3 tabelas).
**Resta no cap. 4:** 4.5 · 4.6 · 4.7 (todas pós-qual, mais leves).

**Onde a tabela de 11/jun errou (corrigir, não só atrasar):**
- Previa **"4.3 + 4.4 no mesmo sábado"** (sem. 2). Irreal: a §4.3 virou **4 unidades de escrita** (abertura + 4.3.1 + 4.3.2 + 4.3.3), consumiu o slot de 15–21/jun inteiro (e a 4.3.3 ainda falta); a 4.4 nem começou. O throughput real segue ~**1 seção/semana**, mas "seção" da §4.3/§4.4 = subseção-cluster, **não** a `\section` inteira.
- A **migração ESP32 (15/jun)** injetou retrabalho (custo re-centrado P4→P3; ripple em pergunta / 4.1 / 4.2.2 / 4.2.3 / 4.4.2 / 4.6 / cap. 3) — parte do atraso é isso, não lentidão.
- **Arquitetura B (11/jun)** já vale: resultado **conceitual** fica no cap. 4 (taxonomia 4.2.3, mapa 4.3, catálogo 4.4); **material** no cap. 5. Consequência p/ a tabela: o **protocolo do experimento mora em 4.6** (não duplicar no cap. 5) → **cap. 5 = casos demonstrativos + estado da Aule + limitações**.

**Janela restante:** **8 semanas de escrita** (W3–W10, 22/jun → ~15/ago) + 2 de revisão (W11–W12). É **apertado**: ~9 unidades de escrita p/ 8 semanas → a W10 fica sobrecarregada e é o **gatilho provável das regras de corte** (fim do arquivo). A janela de revisão **não** se move.

**Custo do atraso (honestidade):** os marcos do núcleo escorregaram **~2 semanas** vs. 11/jun — cap. 4 de ~05/jul → **~19/jul**; cap. 5 de ~19/jul → **~02/ago**. O colchão entre a entrega do cap. 5 e a parede caiu de ~6 para **~4 semanas**. Ainda dentro do limite duro, mas **sem nova folga a queimar**.

## Premissas

- **Janela:** de 09/jun (ter) a 31/ago (seg) ≈ **12 semanas de calendário** ≈ **10 sábados de escrita nova + 2 semanas de revisão**. A escrita fica **sem folga** até o congelamento (~15/ago) — qualquer atraso come a revisão (ver tabela e riscos).
- **Dedicação:** parcial — segunda, quarta e quinta à noite + sábado de manhã ≈ **4 blocos/semana (~10–12 h)**. **Divisão de trabalho (refinada 11/jun):** *sábado de manhã* = **escrever seção nova** (é o motor de produção); *noites* = **incorporar o feedback do Icaro + planejar o sábado + ler o cap. 2** — não produzem seção nova. Logo o **throughput de conteúdo novo é ~1 seção/semana**, limitado pelo sábado. Seções leves/mecânicas (cap. 6, cap. 7, pré-textuais) podem caber em noites e **não** devem consumir um sábado.
- **Orientador:** Icaro. Acompanhamento **semanal (às vezes quinzenal)** → **loop de feedback rápido**: o que é entregue volta com observações que o Matheus **incorpora nas noites da mesma semana**, antes de escrever a próxima seção no sábado. Vantagem: corrige rota cedo e reduz retrabalho tardio — o que mais ameaça a parede de 31/ago. Continua valendo: **enviar cada parte do núcleo assim que fechar** (cap. 4 ~19/jul; cap. 5 ~02/ago).
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

Datas ancoradas ao calendário real (semana = seg–dom; **hoje é dom 21/jun**, fim da W2). Ajustar conforme o andamento.

> **Premissa da tabela (revisada 21/jun):** **~1 seção/semana** (uma subseção-cluster como 4.3.3 ou 4.4; pós-qual 4.5–4.7 são mais leves e emparelham). Noites = incorporar feedback do Icaro + planejar + ler cap. 2; sábado = escrever novo. Seções leves (cap. 6, cap. 7, pré-textuais) saem em **noites**, não em sábados. **8 semanas de escrita (W3–W10) + 2 de revisão (W11–W12).**

| Sem. | Período | Foco (escrever novo) | Saída esperada |
|---|---|---|---|
| ~~Atual~~ **W2** (fechada) | 15–21 jun | §4.3 — abertura + 4.3.1 + 4.3.2. | ✅ feito e revisado (18/jun). **4.3.3 e 4.4 não entraram** (a tabela antiga previa "4.3+4.4 num sábado" — irreal). |
| ~~**W3**~~ ✅ | 22–28 jun | **4.3.3** (21/jun) → §4.3 completa **+ 4.4.1 + 4.4.2** (26/jun) → **núcleo analítico obj 1–3 completo**. Absorveu a W4 (~1 sem. adiantado). | §4.3 e §4.4 redigidas e revisadas; resta acabamento |
| ~~**W4**~~ ✅ | 29 jun–05 jul | **§4.5 completa** (4.5.1 + 4.5.2 + 4.5.3, fechada 04/jul) — Aule como veículo (forward/`Signal` + ponto-de-virada). Previa "4.5 + 4.6"; a §4.5 virou 3 subseções e consumiu a W4 — **4.6 escorregou p/ W5**. | §4.5 redigida e revisada |
| **W5** | 06–12 jul | **4.6** (protocolo do experimento — obj 5–7; herda plan-only + `forbid` da §4.5). *Sozinha nesta semana (decisão 06/jul: não emparelhar 4.6+4.7).* | 4.6 escrita |
| **W6** | 13–19 jul | **4.7** (verificação por tipos vs C+MISRA+sanitizers) → **cap. 4 completo. Enviar ao Icaro** (~19/jul). | **Cap. 4 completo** |
| **W7** | 20–26 jul | **Cap. 5 — casos 1 e 2** (setpoint escalar; ISR/DMA→buffer) como código compila/não-compila. | 2 casos escritos |
| **W8** | 27 jul–02 ago | **Cap. 5 — caso 3** (estado composto estimador↔ctrl) **+ estado da Aule + limitações** → **cap. 5 completo. Enviar ao Icaro** (~02/ago). *(protocolo do experimento vive em 4.6 — Arquitetura B; não duplicar.)* | **Cap. 5 completo** |
| **W9** | 03–09 ago | **Cap. 3 (núcleo enxuto):** classes de bug de memória + ownership/borrow/lifetimes + modelo de memória (3.3: DR formal, happens-before, C11/Rust) + A&OC mínimo + `no_std`/embedded. (Regra de corte nº 1: não inflar.) | Cap. 3 completo |
| **W10** | 10–16 ago | **Cap. 2 (Relacionados) + tabela comparativa + Cap. 1 lapidado** (intro + incidentes + 1.3). Cap. 6, cap. 7 e pré-textuais já em noites. **Travar a escrita ~15/ago.** *(Semana sobrecarregada — colchão consumido pelo escorregão de 06/jul; gatilho provável das regras de corte.)* | **Documento textualmente completo** |
| **W11** | 17–23 ago | **Revisão integral:** consistência entre capítulos, os 5 eixos transversais, `\ref`/`\label` quebrados, fluxo do argumento, compilação limpa; incorporar o feedback final do Icaro. | Draft completo e coeso |
| **W12** | 24–31 ago | **Revisão fina + margem dura:** prosa, figuras, tabelas, `.bib` (completo e citado — ver pendências), siglas, PDF final. **31/ago = entrega. Sem folga depois.** | PDF final pronto pra banca |

> **Onde os cortes batem primeiro (W10):** com o desmembramento 4.6/4.7 (06/jul), o colchão da W10 sumiu e a W10 voltou a acumular **cap. 2 + cap. 1** — é o ponto frágil. Se estourar, acionar as regras de corte — **cap. 2 a 1 subseção/abordagem + a tabela resolve o resto; cap. 3 ao mínimo dos casos.** Nunca encolher W11–W12.

> **Sobre a "leitura bibliográfica para o cap. 2":** é a leitura dos *trabalhos* que o cap. 2 (Relacionados) vai comparar. Roda **de fundo** ao longo de W3–W8 (não em bloco) — ler + escrever na mesma semana estoura. Para cada trabalho, anotar *que classe de bug elimina e em que momento* (compilação / análise estática / runtime / teste) → vira direto a tabela comparativa. A busca é **do Matheus** (Regra 7); registrar as fontes em `leitura_futura.md` / `referencias.bib`.

## Marcos de controle (datas que disparam alarme se passarem)

- **~19 jul (W6):** **cap. 4 fechado e enviado ao Icaro.** *(era ~12/jul; devolveu ~1 semana ao desmembrar 4.6/4.7 em 06/jul — volta ao patamar de antes do adianto da §4.4.)*
- **~02 ago (W8):** **cap. 5 fechado e enviado ao Icaro.** *(era ~26/jul.)* Margem antes da parede de volta a **~4 semanas** (o adianto da §4.4 foi gasto no desmembramento 4.6/4.7) — sem folga a queimar.
- **~15 ago (W10):** **documento textualmente completo + congelamento de conteúdo** (todos os capítulos + pré-textuais, sem `\lipsum`). A partir daqui só revisão — nada de seção nova.
- **31 ago:** entrega. Parede.

A escrita **não tem folga** até ~15/ago: se o cap. 4 (~19/jul) ou o cap. 5 (~02/ago) escorregar mais de ~4 dias, acionar **imediatamente** as regras de corte abaixo — com o colchão já em ~4 semanas, atraso na escrita come a janela de revisão e não há margem para absorvê-lo.

## Sincronização com o Icaro

- Acompanhamento **semanal (às vezes quinzenal)**: levar a cada reunião o que fechou desde a anterior.
- **Incorporar o feedback nas noites da mesma semana** — não acumular para um mutirão depois; o loop rápido só rende se a correção entra antes da próxima seção.
- **Enviar cada parte do núcleo assim que fechar:** cap. 4 ~19/jul, cap. 5 ~02/ago — não esperar o fim; é o que mais pode pedir retrabalho.
- Se ele sinalizar mudança de rumo, ajustar o escopo *antes* de avançar — retrabalho tardio é o que fura a parede de 31/ago.

## Definição de "pronto" para a qualificação (mínimo defensável)

- [ ] Pergunta de pesquisa + objetivos claros (cap. 1)
- [ ] Metodologia completa, incluindo o protocolo do experimento (cap. 4)
- [ ] **≥ 1 caso demonstrativo completo** (idealmente os 3) mostrando bug-C-que-não-compila-em-Rust (cap. 5)
- [ ] Estado atual da Aule documentado (cap. 5)
- [ ] Fundamentação enxuta cobrindo só o que o núcleo usa (cap. 3)
- [ ] Relacionados com tabela comparativa por abordagem de garantia (cap. 2)
- [ ] Cronograma da dissertação — trabalho pós-qualificação (cap. 6)
- [ ] Pré-textuais reais (sem `\lipsum`, sem siglas herdadas do template)
- [ ] Compila limpo (`latexmk`)

## Riscos e regras de corte (se atrasar)

Com a parede dura em 31/ago, o objetivo dos cortes é **proteger as ~2 semanas de revisão (sem. 9–11)**. Ordem de sacrifício — cortar de cima pra baixo:

1. **Fundamentação inflando** → podar para o mínimo dos casos. (risco nº 1)
2. **Relacionados crescendo** → 1 subseção por abordagem; a tabela resolve o resto.
3. **Casos demonstrativos** → se faltar tempo, **1 caso completo e profundo > vários rasos**. Garantir o do *setpoint escalar compartilhado* (mais simples e didático; ver [`cap_4_metodologia.md`](cap_4_metodologia.md)).

**Nunca cortar** (é o que define a qualificação sob enquadramento B): pergunta de pesquisa clara, protocolo do experimento, ≥ 1 caso demonstrativo, e o eixo "fronteira do que Rust não garante" (honestidade). **Nem encolher a janela de revisão** — se a escolha for entre revisão e mais uma seção periférica, corta-se a seção.

> Atenção: o **cap. 6 da tese** (Cronograma de Execução) planeja o trabalho *pós-qualificação* (implementar o experimento, MPC/IMC, verificação formal, **bloco out-of-box da Aule para concorrência `ISR↔DMA`** — ver abaixo) — é diferente **deste** arquivo, que é o cronograma de *escrita da qualificação*.
>
> **Bloco out-of-box `ISR↔DMA` (decisão 30/mai):** o *exemplo demonstrativo* do data race ISR↔tarefa entra **na qualificação** como código **fora da Aule** (Rust puro: RTIC / atomic / `Send`-`Sync`) — é a evidência da classe de memory safety da tese. O *bloco reutilizável da Aule* que encapsula esse padrão de forma ergonômica é **trabalho pós-qualificação**, a ser proposto no cap. 6. Ter o **esboço do mecanismo** (como expor o recurso compartilhado de forma safe) pronto para a defesa, mesmo sem implementar. Ver `recorte_tese.md`.

## Manutenção deste roadmap

- Atualizar o status no início de cada semana (feito / atrasado / replanejado).
- Se uma semana estourar, empurrar e cortar do **periférico** (regras acima), nunca da janela de revisão nem do núcleo.
- Registrar desvios — serve de insumo honesto pro cap. 6 (estimar o ritmo real ajuda a planejar a dissertação).
