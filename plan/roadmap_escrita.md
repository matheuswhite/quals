---
author: Claude (claude-opus-4-7)
created: 2026-05-28
---

<!-- LTeX: enabled=false -->

# Roadmap de escrita — qualificação (até final de julho/2026)

Plano de *quando* escrever *o quê*. Não contém prosa da tese — só metas e sequência. Companheiro de [`outline_geral.md`](outline_geral.md) (que diz o que cada seção cobre).

## Premissas

- **Prazo:** final de julho/2026. Janela ≈ **9 semanas** (Matheus já embutiu ~2 semanas de buffer nessa contagem).
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

## Plano semana a semana

Datas aproximadas — ajustar ao calendário real.

| Sem. | Período aprox. | Foco principal | Saída esperada |
|---|---|---|---|
| **1** | fim de mai (parcial) | **Preparação.** Transformar o `outline_geral.md` em esqueleto `.tex` (headings + bullets do que cada seção cobre). Rascunhar pergunta de pesquisa + objetivos (1.2). Iniciar leitura do cap. 2. | Esqueleto de todos os capítulos no `.tex`; 1.2 em rascunho |
| **2** | início jun | **Cap. 4 (1ª parte):** caracterização, requisitos, arquitetura da solução (4.1–4.3). Ancorar no forward/`Signal` + ponto-de-virada. | 4.1–4.3 escritos |
| **3** | jun | **Cap. 4 (2ª parte):** implementação, validação/testes, critérios + **protocolo do experimento** (4.4–4.6). | Cap. 4 completo |
| **4** | jun | **Cap. 5 (núcleo):** estado da Aule + casos demonstrativos (delay line, ISR↔DMA, MPC workspace). | Casos demonstrativos escritos |
| **5** | fim jun | Fechar cap. 5 (limitações) + **Cap. 3 (1ª parte):** classes de bug + ownership/borrow/lifetimes (seção dedicada). | Cap. 5 completo; cap. 3 começado |
| **6** | fim jun / início jul | **Cap. 3 (2ª parte):** A&OC mínimo, `no_std`/embedded, controle mínimo + **Cap. 2:** consolidar leitura na taxonomia por abordagem de garantia. | Cap. 3 completo; cap. 2 em rascunho |
| **7** | jul | **Cap. 1** lapidar (intro completa, narrativa de incidentes) + **Cap. 2** fechar + tabela comparativa. | Caps. 1 e 2 completos |
| **8** | jul | **Cap. 6** (cronograma da dissertação) + **Cap. 7** (conclusão) + **pré-textuais** (resumo, abstract, palavras-chave, trocar lista de siglas herdada). | Documento textualmente completo |
| **9** | fim jul | **Revisão integral:** consistência entre capítulos, os 5 eixos transversais presentes, incorporar feedback do Icaro, compilação final. Buffer. | PDF final pronto pra banca |

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

> Atenção: o **cap. 6 da tese** (Cronograma de Execução) planeja o trabalho *pós-qualificação* (implementar o experimento, MPC/IMC, verificação formal) — é diferente **deste** arquivo, que é o cronograma de *escrita da qualificação*.

## Manutenção deste roadmap

- Atualizar o status no início de cada semana (feito / atrasado / replanejado).
- Se uma semana estourar, empurrar e cortar do **periférico** (regras acima), nunca do núcleo.
- Registrar desvios — serve de insumo honesto pro cap. 6 (estimar o ritmo real ajuda a planejar a dissertação).
