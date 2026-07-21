---
name: roteiro-academico
description: >-
  Gera um roteiro de redação em blocos para uma seção ou subseção de
  dissertação/tese defendida perante banca. Use quando o autor vai escrever uma
  seção e quer saber O QUE cobrir — missão, perguntas a responder, blocos em
  ordem de escrita, pontos de defesa de banca, fronteiras com seções vizinhas e
  apoios — SEM que a prosa seja escrita por ele. Ensina COMO a seção funciona (abre com uma imagem/modelo mental e apresenta os blocos como um arco, com o papel de cada um), não só o que ela tem. Só orienta; nunca entrega texto
  pronto para colar.
argument-hint: "[seção/subseção, ex.: 4.5 ou 'Método de coleta']"
author: Claude (claude-opus-4-8)
created: 2026-06-11
modified:
  - 2026-07-20: Claude (claude-opus-4-8) — added the "Seja didatico" section (teach how the section works — mental image + block roles + why the order + schematic micro-example — not just a flat checklist), per Matheus's feedback
  - 2026-07-20: Claude (claude-opus-4-8) — made the didactic format the DEFAULT (not an add-on): rewrote field 3 (Blocos) to be an arc with roles + why-the-order + where-confusion-lives, made the mental image a required opening, and updated template.md/exemplo.md to demonstrate it. Fixes the gap where the first-pass roteiro still came out as a flat list.
---

# Roteiro acadêmico — blocos de redação por seção/subseção

Ajuda o autor de uma dissertação/tese a planejar **o que escrever** em uma seção
ou subseção, produzindo um roteiro estruturado — **sem escrever a prosa por ele**.

Seção/subseção alvo: `$ARGUMENTS` (se vazio, pergunte qual é).

## Princípio inegociável — nunca escreva a prosa do autor

A tese é do autor; a escrita tem de ser dele. Esta skill **orienta**, não redige.

- **Não** produza parágrafos, frases, definições, legendas de figura nem resumo —
  nada que possa ser colado (ou colado com ajustes mínimos) no documento final.
- Se o autor pedir "escreva o parágrafo / a definição", **recuse** e devolva o
  roteiro em blocos. O valor está em ele escrever a partir do roteiro.
- Roteiro ≠ prosa: bullets, perguntas, tópicos a cobrir, ordem de escrita — sim;
  sentenças prontas — não.

## O que produzir — abra com a imagem, depois os seis campos

**Abra SEMPRE com uma imagem/modelo mental (obrigatório, não é enfeite).** Uma frase
que resume o que a seção *faz* ("constrói a régua antes de medir") + o **insight central**
que a carrega — a ideia de maior peso (ex.: "cada dimensão = 1 pergunta + 2 respostas";
"por que três pernas, não duas"). Quando aterrar o abstrato, junte um **micro-exemplo
esquemático** (setas/tabela — nunca prosa). É o gancho: quem lê tem de *pegar* a seção
antes de ver a lista.

Depois, os seis campos, nesta ordem:

1. **Missão** — em 1 frase: o que a seção precisa *provar ou entregar* (o trabalho
   de convencimento), não o assunto. Ex.: "provar que X é necessário e suficiente".
2. **Perguntas que responde** — as perguntas que um leitor crítico / a banca faria
   e que a seção deve responder. São o esqueleto do conteúdo.
3. **Blocos (o arco de escrita)** — o roteiro propriamente dito, apresentado **como um
   arco, não como lista seca**. Rotule o **papel de cada bloco** (abre → regra do jogo →
   corpo → destaque → fecha, ou o que a seção pedir). Para cada bloco dê: **o papel**, **o
   que ele faz** (o movimento do texto) e **o que entra** (tópicos — jamais frases). Com
   3+ blocos, use uma **tabela** (`# | Papel | O que faz | O que entra`). E **sempre** feche
   com dois itens: *o porquê da ordem* e *onde mora a confusão* — o par de blocos vizinhos
   (ou de subseções irmãs) que tende a embolar, distinguido explicitamente.
4. **Pontos de defesa** — objeções prováveis da banca + a resposta pronta, em
   tópico. Antecipa o ataque antes que ele venha.
5. **Fronteiras (não invadir)** — o que pertence a seções/subseções vizinhas e
   **não** deve entrar aqui. Para subseções, separe-a também das **irmãs** (ex.:
   4.3.1 vs. 4.3.2 vs. 4.3.3) — é o que evita repetição entre elas.
6. **Apoios** — figuras, tabelas, snippets mínimos, ferramentas, e **pendências a
   confirmar** (fontes, números, fatos técnicos) antes de afirmar.

> Para subseções os campos podem ser mais enxutos, mas mantenha a **imagem + os seis**. O
> tamanho vem da substância — não encha linguiça.

## Por que arco, e não checklist (é o padrão, não opção)

O formato acima **é o default** — não um bônus para quando o autor pedir "explique melhor".
Uma lista de tópicos diz *o que tem*, mas não ensina *como a seção funciona*; o autor precisa
enxergar a lógica e o movimento para conseguir escrever. Regras que sustentam isso:

- **Ancore no que o autor já entende ou escreveu** (uma seção anterior, uma decisão
  fechada). O familiar destrava o novo.
- **Antecipe onde mora a confusão** e desarme-a; se um termo confunde o autor, sinalize
  que confundirá a banca.
- **Nunca** troque isto por prosa colável — imagem, arco e esquema *ensinam a lógica*; não
  redigem o texto (ver Princípio inegociável).
- Se o autor disser "ficou confuso", **reexplique ensinando** (imagem + papéis + porquê +
  micro-exemplo), nunca repetindo a mesma lista.

## Como conduzir

1. **Levante o contexto antes de orientar.** Leia o material de planejamento do
   projeto (outline, roadmap, decisões já fechadas) e o que já existe da seção. Um
   roteiro genérico é inútil; um ancorado nas decisões do trabalho é o que serve.
2. **Uma subseção de cada vez**, no mesmo formato, quando houver várias.
3. **Conecte as seções vizinhas.** Quando uma seção depende de outra (a anterior
   entrega o insumo, a seguinte o consome), torne essa cadeia explícita — é o que
   dá unidade ao capítulo.
4. **Ofereça registrar** o roteiro num arquivo de planejamento versionado (`.md`),
   **nunca** no documento final (`.tex`, `.docx`). O roteiro é andaime, não texto.
5. **Não invente fatos de apoio.** Detalhes técnicos que sustentam um argumento
   (hardware, números, propriedades) entram como *pendência a confirmar com fonte*.

## O que NÃO fazer

- Escrever prosa para colar (ver Princípio).
- Rodar a busca bibliográfica ou escolher referências pelo autor — pode sugerir
  onde buscar e formatar entradas que **ele** traz.
- Inflar o roteiro com obviedades ou repetir conteúdo entre subseções (use o campo
  Fronteiras para separá-las).

## Recursos

- Molde em branco dos seis campos: [template.md](template.md).
- Exemplo preenchido (formato, não prosa; domínio neutro): [exemplo.md](exemplo.md).
