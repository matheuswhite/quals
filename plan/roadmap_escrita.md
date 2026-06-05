---
author: Claude (claude-opus-4-7)
created: 2026-05-28
modified:
  - 2026-05-30: Claude (claude-opus-4-8) — anotado o bloco out-of-box da Aule p/ ISR↔DMA como trabalho pós-qualificação (cap. 6)
  - 2026-06-04: Claude (claude-opus-4-8) — semanas 1-2 realinhadas à estrutura método-por-objetivo do cap. 4 (4.1–4.4 = obj 1–3; 4.5–4.7 = pós-qual); ver cap_4_metodologia.md
---

<!-- LTeX: enabled=false -->

# Roadmap de escrita — qualificação (até final de julho/2026)

Plano de *quando* escrever *o quê*. Não contém prosa da tese — só metas e sequência. Companheiro de [`outline_geral.md`](outline_geral.md) (que diz o que cada seção cobre).

## Premissas

- **Prazo:** final de julho/2026. **Janela:** 1 bloco de arranque (sáb 30/mai — a semana atual só tem ele, pois hoje é quinta à noite) + **8 semanas cheias** (jun–jul) + margem final. Buffer de ~2 semanas preservado (semana 8 = revisão; fim de jul = margem).
- **Dedicação:** parcial — segunda, quarta e quinta à noite + sábado de manhã ≈ **4 blocos/semana (~10–12 h)**. Sábado é o bloco longo.
- **Orientador:** Icaro. Reuniões semanais informais, sem checkpoint formal de entrega → usar como **feedback contínuo** (levar o capítulo da semana).
- **Estado de partida:** capítulos em esqueleto; experimento de segurança = só protocolo; Aule já madura ([`aule_roadmap.md`](aule_roadmap.md)).
- **Escopo:** ver [`outline_geral.md`](outline_geral.md) §"Decisões fechadas". Qualificação = **proposta + resultados parciais + protocolo**.

## Estratégia

- **Núcleo primeiro.** Cap. 4 (metodologia) + cap. 5 (casos demonstrativos) são a contribuição B e o que a banca mais escrutina. Maior fatia de tempo.
- **Fundamentação calibrada DEPOIS do núcleo** — escrever só o que os casos/metodologia usam. Inflar a fundamentação é o **risco nº 1 de estouro**.
- **Relacionados em paralelo** — leitura contínua nas primeiras semanas; redação concentrada quando a leitura amadurecer.
- **Introdução em dois tempos** — rascunho cedo (fixa pergunta de pesquisa, objetivos, estrutura); lapidação no fim.
- **Escrita é iterativa** — a ordem é a de *foco*, não exclusiva. Voltar e ajustar é esperado.
- **Padrão de uso dos blocos:** sábado de manhã = redigir seção nova (precisa de fôlego); noites = avançar/revisar/ler (tarefas menores).
- **Sem fase de preparação dedicada:** o esqueleto `.tex` de cada capítulo é montado no início da semana daquele capítulo (o `outline_geral.md` já é o esqueleto conceitual). Só a pergunta de pesquisa + objetivos vem antes de tudo (bloco de arranque), porque orienta a direção.

## Plano semana a semana

Datas aproximadas — ajustar ao calendário real.

| Sem. | Período aprox. | Foco principal | Saída esperada |
|---|---|---|---|
| **Arranque** | sáb 30/mai (1 bloco) | Rascunhar **pergunta de pesquisa + objetivos (1.2)** — o que destrava a direção de tudo. Cabe num bloco. | 1.2 em rascunho |
| **1** | 1–7 jun | **Cap. 4 (1ª parte) — métodos da qualificação (obj 1–3):** caracterização da pesquisa (4.1) + método da taxonomia de padrões de data race (4.2), da fronteira safe/unsafe (4.3) e do espaço de design (4.4). Esqueleto detalhado em [`cap_4_metodologia.md`](cap_4_metodologia.md); montar o `.tex` a partir dele. Iniciar a **leitura bibliográfica para o cap. 2** (ver nota abaixo). | 4.1–4.4 escritos; leitura começada |
| **2** | 8–14 jun | **Cap. 4 (2ª parte) — pós-qualificação como plano (obj 4–8):** Aule como veículo (4.5, onde vivem o forward/`Signal` + ponto-de-virada) + protocolo do experimento de custo (4.6) + protocolo da comparação de verificação vs C+MISRA (4.7). | Cap. 4 completo |
| **3** | 15–21 jun | **Cap. 5 (núcleo):** estado da Aule + casos demonstrativos (delay line, ISR↔DMA, MPC workspace). | Casos demonstrativos escritos |
| **4** | 22–28 jun | Fechar cap. 5 (limitações) + **Cap. 3 (1ª parte):** classes de bug + ownership/borrow/lifetimes (seção dedicada). | Cap. 5 completo; cap. 3 começado |
| **5** | 29 jun–5 jul | **Cap. 3 (2ª parte):** A&OC mínimo, `no_std`/embedded, controle mínimo + **Cap. 2:** consolidar leitura na taxonomia por abordagem de garantia. | Cap. 3 completo; cap. 2 em rascunho |
| **6** | 6–12 jul | **Cap. 1** lapidar (intro completa, narrativa de incidentes) + **Cap. 2** fechar + tabela comparativa. | Caps. 1 e 2 completos |
| **7** | 13–19 jul | **Cap. 6** (cronograma da dissertação) + **Cap. 7** (conclusão) + **pré-textuais** (resumo, abstract, palavras-chave, trocar lista de siglas herdada). | Documento textualmente completo |
| **8** | 20–26 jul | **Revisão integral:** consistência entre capítulos, os 5 eixos transversais presentes, incorporar feedback do Icaro, compilação final. Buffer. | PDF final pronto pra banca |
| _margem_ | 27–31 jul | Folga / imprevistos / últimos ajustes. | — |

> **Sobre a "leitura bibliográfica para o cap. 2":** é a leitura dos *trabalhos* que o cap. 2 (Relacionados) vai comparar — não a leitura do capítulo. Começa na semana 1 e roda **de fundo** ao longo das semanas 1–5 (não em bloco), porque não dá pra escrever Relacionados sem ter lido antes, e ler + escrever na mesma semana estoura. Para cada trabalho, anotar *que classe de bug elimina e em que momento* (compilação / análise estática / runtime / teste) → vira direto a tabela comparativa. Registrar as fontes em `leitura_futura.md` / `referencias.bib`.

## Sincronização com o Icaro

- Levar a cada reunião semanal o capítulo da semana anterior.
- **Pedir leitura do núcleo (cap. 4–5) com antecedência** (semanas ~4–5), pra haver tempo de incorporar antes da semana 9.
- Se ele sinalizar mudança de rumo, ajustar o escopo *antes* de avançar — retrabalho tardio é o que estoura prazo.

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

Ordem de sacrifício — cortar de cima pra baixo:

1. **Fundamentação inflando** → podar para o mínimo dos casos. (risco nº 1)
2. **Relacionados crescendo** → 1 subseção por abordagem; a tabela resolve o resto.
3. **Casos demonstrativos** → se faltar tempo, **1 caso completo e profundo > 3 rasos**. Garantir o da *delay line* (mais simples e didático).

**Nunca cortar** (é o que define a qualificação sob enquadramento B): pergunta de pesquisa clara, protocolo do experimento, ≥ 1 caso demonstrativo, e o eixo "fronteira do que Rust não garante" (honestidade).

> Atenção: o **cap. 6 da tese** (Cronograma de Execução) planeja o trabalho *pós-qualificação* (implementar o experimento, MPC/IMC, verificação formal, **bloco out-of-box da Aule para concorrência `ISR↔DMA`** — ver abaixo) — é diferente **deste** arquivo, que é o cronograma de *escrita da qualificação*.
>
> **Bloco out-of-box `ISR↔DMA` (decisão 30/mai):** o *exemplo demonstrativo* do data race ISR↔tarefa entra **na qualificação** como código **fora da Aule** (Rust puro: RTIC / atomic / `Send`-`Sync`) — é a evidência da classe de memory safety da tese. O *bloco reutilizável da Aule* que encapsula esse padrão de forma ergonômica é **trabalho pós-qualificação**, a ser proposto no cap. 6. Ter o **esboço do mecanismo** (como expor o recurso compartilhado de forma safe) pronto para a defesa, mesmo sem implementar. Ver `recorte_tese.md`.

## Manutenção deste roadmap

- Atualizar o status no início de cada semana (feito / atrasado / replanejado).
- Se uma semana estourar, empurrar e cortar do **periférico** (regras acima), nunca do núcleo.
- Registrar desvios — serve de insumo honesto pro cap. 6 (estimar o ritmo real ajuda a planejar a dissertação).
