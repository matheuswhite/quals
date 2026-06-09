---
author: Claude (claude-opus-4-7)
created: 2026-05-28
modified:
  - 2026-05-30: Claude (claude-opus-4-8) — anotado o bloco out-of-box da Aule p/ ISR↔DMA como trabalho pós-qualificação (cap. 6)
  - 2026-06-04: Claude (claude-opus-4-8) — semanas 1-2 realinhadas à estrutura método-por-objetivo do cap. 4 (4.1–4.4 = obj 1–3; 4.5–4.7 = pós-qual); regra de corte atualizada (delay line → setpoint escalar); ver cap_4_metodologia.md
  - 2026-06-09: Claude (claude-opus-4-8) — replanejamento integral para o novo prazo (fim de agosto/2026, parede dura). Recalibrado ao estado real (só 4.1 + rascunho de 1.2 escritos) e ao ritmo observado (~1 seção/semana). Janela reorganizada em 11 semanas de escrita + bloco final de revisão/feedback sem folga depois de 31/ago.
---

<!-- LTeX: enabled=false -->

# Roadmap de escrita — qualificação (até **final de agosto/2026**)

Plano de *quando* escrever *o quê*. Não contém prosa da tese — só metas e sequência. Companheiro de [`outline_geral.md`](outline_geral.md) (que diz o que cada seção cobre).

## O que mudou (replanejamento de 09/jun)

- **Prazo:** era fim de julho → agora **fim de agosto/2026 (seg 31/ago)**. Esse é o **limite duro**: depois dele não há parede, folga nem prorrogação. O mês a mais **não é tempo livre** — ele absorve (a) o atraso já acumulado e (b) o ciclo de revisão + feedback do Icaro, que no plano antigo era apertado.
- **Atraso acumulado:** o plano antigo previa 4.1–4.4 fechados até 07/jun. Em 09/jun só **4.1** está escrito (+ rascunho de 1.2). Ritmo real desde 30/mai ≈ **1 seção por semana** de escrita. O plano abaixo já parte desse ritmo realista, não do otimista.
- **Consequência de estratégia:** com a parede em 31/ago, a regra deixa de ser "escrever até o fim e revisar se sobrar" e passa a ser **"travar a escrita ~15/ago e blindar 2 semanas de revisão + feedback"**. Se algo atrasar, corta-se do periférico (regras no fim do arquivo) para proteger a janela de revisão — nunca o contrário.

## Premissas

- **Janela:** de 09/jun (ter) a 31/ago (seg) ≈ **12 semanas de calendário**. Descontando a semana atual (parcial) e o bloco final de revisão, são **~10 semanas cheias de escrita + ~2 de revisão/feedback**.
- **Dedicação:** parcial — segunda, quarta e quinta à noite + sábado de manhã ≈ **4 blocos/semana (~10–12 h)**. Sábado é o bloco longo.
- **Orientador:** Icaro. Reuniões semanais informais, sem checkpoint formal → usar como **feedback contínuo** (levar o capítulo da semana). **Mudança neste plano:** enviar o **núcleo (cap. 4–5) bem mais cedo** (até ~fim de junho) para haver tempo de incorporar antes da parede.
- **Estado de partida (09/jun):** 4.1 escrito; 1.2 em rascunho; todo o resto em esqueleto ou vazio. Experimento de segurança = só protocolo. Aule já madura ([`aule_roadmap.md`](aule_roadmap.md)).
- **Escopo:** ver [`outline_geral.md`](outline_geral.md) §"Decisões fechadas". Qualificação = **proposta + resultados parciais + protocolo**.

## Estratégia

- **Núcleo primeiro.** Cap. 4 (metodologia) + cap. 5 (casos demonstrativos) são a contribuição B e o que a banca mais escrutina. Maior fatia de tempo e enviados ao Icaro primeiro.
- **Fundamentação calibrada DEPOIS do núcleo** — escrever só o que os casos/metodologia usam. Inflar a fundamentação é o **risco nº 1 de estouro**.
- **Relacionados em paralelo** — leitura contínua nas primeiras semanas; redação concentrada quando a leitura amadurecer.
- **Introdução em dois tempos** — o rascunho de 1.2 (pergunta + objetivos) já existe e fixa a direção; lapidação da intro inteira no fim.
- **Escrita é iterativa** — a ordem é a de *foco*, não exclusiva. Voltar e ajustar é esperado.
- **Padrão de uso dos blocos:** sábado de manhã = redigir seção nova (precisa de fôlego); noites = avançar/revisar/ler (tarefas menores).
- **Esqueleto `.tex` montado no início da semana daquele capítulo** (o `outline_geral.md` já é o esqueleto conceitual).

## Plano semana a semana

Datas ancoradas ao calendário real (semana = seg–dom; a atual começa numa terça). Ajustar conforme o andamento.

| Sem. | Período | Foco principal | Saída esperada |
|---|---|---|---|
| **Atual** (parcial) | 09–14 jun | **Cap. 4, obj 1–3:** fechar 4.2 (taxonomia de padrões de data race), 4.3 (fronteira safe/unsafe) e 4.4 (espaço de design das garantias). Esqueleto detalhado em [`cap_4_metodologia.md`](cap_4_metodologia.md). Iniciar **leitura bibliográfica do cap. 2** (ver nota). | 4.2–4.4 escritos; leitura começada |
| **2** | 15–21 jun | **Cap. 4, obj 4–8 (pós-qual como plano):** 4.5 (Aule como veículo — forward/`Signal` + ponto-de-virada), 4.6 (protocolo do experimento de custo), 4.7 (verificação por tipos vs C+MISRA+sanitizers). | **Cap. 4 completo** |
| **3** | 22–28 jun | **Cap. 5 (núcleo):** estado atual da Aule + casos demonstrativos (setpoint escalar, ISR/DMA→buffer, estado composto estimador↔controlador) como código compila/não-compila. **Enviar cap. 4 ao Icaro.** | Casos demonstrativos escritos |
| **4** | 29 jun–05 jul | Fechar **cap. 5** (limitações + protocolo, sem dados) + iniciar **cap. 3 (1ª parte):** classes de bug de memória + ownership/borrow/lifetimes (seção dedicada). **Enviar cap. 5 ao Icaro.** | Cap. 5 completo; cap. 3 começado |
| **5** | 06–12 jul | **Cap. 3 (2ª parte):** A&OC mínimo, `no_std`/embedded, controle mínimo. Consolidar leitura do cap. 2 na taxonomia por abordagem de garantia. | Cap. 3 completo; cap. 2 em rascunho |
| **6** | 13–19 jul | **Cap. 2 (Relacionados):** fechar + **tabela comparativa** (que classe de bug cada abordagem elimina e em que momento). | Cap. 2 completo |
| **7** | 20–26 jul | **Cap. 1 lapidar** (intro completa, narrativa de incidentes, 1.3 visão geral) + **Cap. 6** (cronograma da *dissertação* — trabalho pós-qual). | Caps. 1 e 6 completos |
| **8** | 27 jul–02 ago | **Cap. 7** (conclusão) + **pré-textuais** (resumo, abstract, palavras-chave/keywords, trocar lista de siglas herdada do template, remover `\lipsum`). | **Documento textualmente completo** |
| **9** | 03–09 ago | **Revisão integral — 1ª passada:** consistência entre capítulos, os 5 eixos transversais presentes, fluxo do argumento, compilação limpa. Incorporar feedback do Icaro sobre cap. 4–5 (recebido nas sem. 3–5). | Draft completo e coeso |
| **10** | 10–16 ago | **Banca interna (autocrítica) + incorporar feedback final do Icaro:** buracos metodológicos, fragilidades, o protocolo se sustenta. **Travar a escrita ~15/ago.** | Conteúdo congelado |
| **11** | 17–23 ago | **Revisão fina:** prosa, figuras, tabelas, bibliografia (`.bib` completo e citado), siglas, compilação final. | PDF candidato |
| **12** | 24–31 ago | **Margem dura:** últimos ajustes e imprevistos. **31/ago = entrega. Sem folga depois.** | PDF final pronto pra banca |

> **Sobre a "leitura bibliográfica para o cap. 2":** é a leitura dos *trabalhos* que o cap. 2 (Relacionados) vai comparar. Começa na semana atual e roda **de fundo** ao longo das semanas 1–5 (não em bloco) — ler + escrever na mesma semana estoura. Para cada trabalho, anotar *que classe de bug elimina e em que momento* (compilação / análise estática / runtime / teste) → vira direto a tabela comparativa. A busca é **do Matheus** (Regra 7); registrar as fontes em `leitura_futura.md` / `referencias.bib`.

## Marcos de controle (datas que disparam alarme se passarem)

- **~30 jun:** cap. 4 e cap. 5 fechados e nas mãos do Icaro. (É o núcleo; precisa do maior tempo de incorporação.)
- **~02 ago:** documento textualmente completo (todos os capítulos + pré-textuais, sem `\lipsum`).
- **~15 ago:** **congelamento de conteúdo.** A partir daqui só revisão — nada de seção nova.
- **31 ago:** entrega. Parede.

Se o marco de 30/jun ou o de 02/ago escorregar mais de ~4 dias, acionar imediatamente as regras de corte abaixo — não esperar acumular.

## Sincronização com o Icaro

- Levar a cada reunião semanal o capítulo da semana anterior.
- **Pedir leitura do núcleo (cap. 4–5) já em fins de junho** (sem. 3–4), não no fim — é o que mais pode pedir retrabalho.
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
