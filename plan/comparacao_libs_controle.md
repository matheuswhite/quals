---
author: Claude (claude-opus-4-8)
created: 2026-07-27
modified:
  - 2026-07-27: Claude (claude-opus-4-8) — metodo de busca verificado na API do GitHub (chaves, funil, cortes, ruidos) + decisao de formato das tabelas da 5.x.2 (grade PID no apendice via csvsimple; grade control hibrida/prosa por familia)
---

<!-- LTeX: enabled=false -->

# Comparacao: bibliotecas de controle em Rust vs Aule

Andaime de planejamento (Regra 4): dados, dossies e analise de posicionamento para a secao
`sec:control-repos` (cap. 5). **Nao contem prosa da tese** — tabelas, bullets factuais e gap
analysis para o Matheus ler e redigir. Companheiro de [`cap_5_resultados.md`](cap_5_resultados.md).

## O que e / honestidade para a banca (Regra 7)

- **Amostra:** 6 repositorios de "sistemas de controle" (nao-PID) trazidos pelo Matheus como
  "os mais maduros que achei" (CSV `Control Rust Libraries - Control Systems.csv`). **Selecao do
  Matheus, nao busca sistematica** — ver o risco de amostra a dedo na secao "Furos de banca".
- **Como foram analisados (27/07/2026):** 6 subagentes de IA (Claude) inspecionaram cada repo via
  web/GitHub (landing, README, `Cargo.toml`, `src/`). Verificacao **no codigo-fonte**, nao so no
  README. Itens nao confirmaveis marcados "ND" (nao determinado).
- **Aule:** caracterizada por leitura direta do codigo em `origin/main` (commit `4fb7d35`, lido
  27/07). Atencao: o working tree local estava na branch `arduino_fix` (usa `faer`, desatualizada);
  a `main` usa **nalgebra 0.34 em modo `no_std`**.
- **Apropriacao pendente:** o Matheus deve reabrir cada repo que for citar e confirmar. "Uma IA
  achou" nao e defesa; "eu li e conferi" e.

## Panorama em uma frase

O ecossistema Rust de bibliotecas de controle (fora PID) e **raso e bifurcado**: ou ferramentas de
**analise LTI offline estilo MATLAB** (nao embarcadas), ou **prototipos de composicao/execucao de
blocos** imaturos e abandonados. Nenhuma cobre o cruzamento `no_std` + execucao + concorrencia que a
Aule ocupa, e **nenhuma toca data race** — o eixo da tese.

---

## Tabela A — Identidade e maturidade

| Repo | Tipo | crates.io | Stars | Ult. atividade | Licenca | Docs | CI | Testes | Exemplos | Benches |
|---|---|---|---|---|---|---|---|---|---|---|
| rdesarz/control-sys-rs | lib | ND (`control-sys 0.1.0`) | 11 | ND (pequeno) | MIT | medio | sim | sim | 4 | nao |
| TorBorve/Control-Systems-TorBox | lib | **sim** (`control_systems_torbox 0.2.1`) | 8 | ND (~122 commits) | MIT | bom (badges) | sim | sim (codecov) | 2 | ND |
| pekpuglia/control_systems | lib | nao | 1 | abr/2024 (inativo) | ND | fraca (sem README) | minimo | sim | 1 | nao |
| Josue-Herrera/control_systems | **bin** ("learning") | nao | 1 | abandonado (2 commits) | nenhuma | ~nula | nao | nao | nao | nao |
| Hixos/control-systems-rs | workspace (lib) | ND | 1 | jan/2024 (parado) | nenhuma | nenhuma | nao | ND | 1 | nao |
| AlbertoFoti/Control-Systems-Algorithms | lib+bin | nao | 1 | set/2022 (abandonado) | MIT | fraca | nao | nao | 0 (demo=bin) | nao |
| **Aule** | **lib (`no_std`)** | nao (ainda) | — (objeto) | ativa (mestrado) | — | ND | ND | sim | 5 | ND |

## Tabela B — Territorio da tese (o que mais importa)

| Repo | `no_std` / embarcado | Generico no escalar | Backend alg. linear | Concorrencia / data race |
|---|---|---|---|---|
| rdesarz/control-sys-rs | ✗ (std + plotters) | ✗ (`f64` fixo) | nalgebra 0.33 (std) | ✗ nenhuma |
| TorBorve/...-TorBox | ✗ (SLICOT/LAPACK + egui) | ✗ (`f64` fixo) | nalgebra 0.33 + netlib/SLICOT | ✗ nenhuma (rayon so dev-dep) |
| pekpuglia/control_systems | ✗ (heap + solver) | ✗ (`f64` fixo) | nalgebra =0.32.3 + eqsolver | ✗ nenhuma |
| Josue-Herrera/control_systems | ✗ | ✗ (`f64` fixo) | nalgebra `*` | ✗ nenhuma |
| Hixos/control-systems-rs | ✗ (std/HashMap/petgraph) | ~ (blocos `f32/f64`; nucleo `f64`) | nalgebra 0.32.3 + petgraph | ✗ nucleo; exemplo usa thread+mpsc so p/ GUI |
| AlbertoFoti/...-Algorithms | ✗ (std + paho-mqtt) | ✗ (`f64` fixo) | **caseiro** (`Vec3D` 3-comp) | ✗ nenhuma |
| **Aule** | **✓ `no_std`-first; bridge SWD p/ HW real** | **✓ (`Signal<T>`/`Block<T>`; foco f32/f64, complexos, matrizes)** | **nalgebra 0.34 `no_std`** (`default-features=false`, `libm`) + num-complex | **em desenvolvimento** (eixo da tese; unica do conjunto a abordar) |

## Tabela C — Capacidades de controle

Legenda: ✓ sim · ✗ nao · ~ parcial · ND nao determinado

| Repo | TF | SS | Discreto | Solver ODE | Sim. loop | Controlador | Ident. | Freq (Bode/Nyq) | Filtros | c2d |
|---|---|---|---|---|---|---|---|---|---|---|
| control-sys-rs | ~ (so em teste) | ✓ | ✓ | ✗ (recorrencia `x[k+1]=Ax+Bu`) | ✓ | **README diz LQR/pole; ausente no codigo** | ✗ | ✗ | ✗ | ✓ (ZOH exato) |
| ...-TorBox | ✓ | ✓ | ~ | ✗ | **✗ (diz "simulating"; sem loop)** | ✗ (PI manual como TF) | ✗ | ~ (Bode/Nyq sim; margens nao) | ✗ | ND/nao |
| pekpuglia | ✗ | ✓ | ✗ | ✗ (`xdot()` exposto; integra fora) | ✗ (avaliacao pontual) | ✗ (so plantas + feedback) | ✗ | ✗ | ~ (`Exp`=LP 1a ordem) | ✗ |
| Josue-Herrera | ✗ | ✗ | ✗ | ✗ | ✗ | ✗ | ✗ | ✗ | ~ (1 passo Kalman, nem chamado) | ✗ |
| Hixos | ✗ | ✗ | ✓ | **✓ (RK4 + Euler, `f64`)** | ✓ (toposort) | ~ (so PID) | ✗ | ✗ | ✗ (so Delay) | ✗ |
| AlbertoFoti | ✗ | ✗ | ~ | ~ (Euler ad-hoc por planta) | ✓ | ✗ (feedback = stub zero) | ✗ | ✗ | ✗ | ✗ |
| **Aule** | **✓** | **✓** | **✓ (DTf/DSS)** | **✓ (Euler + RK4 proprios, `no_std`)** | **✓ (`Simulation` Iterator)** | **✓ (PID c/ anti-windup, saturation, delay, observer)** | **✓ (5: Smith, ZN, Mollenkamp, Hagglund, SundaresanKrishnaswamy)** | ✗ (fora de prioridade) | **✓ (8 filtros 1a/2a ordem)** | ~ (discreto sim; c2d explicito ND) |

## Tabela D — Abstracao central (como cada uma modela/compoe)

| Repo | Modelo |
|---|---|
| control-sys-rs | Matrix-centric A/B/C/D; traits `StateSpaceModel`/`Discrete`/`Pole`; **sem** composicao de blocos |
| ...-TorBox | Algebra de sistemas LTI: structs `Tf`/`Ss` + sobrecarga de operador (`*`, `.feedback()`); **sem** pipeline de blocos |
| pekpuglia | **Composicao type-safe**: trait `DynamicalSystem` (`xdot`/`y`) + `Series`/`NegativeFeedback`/`Parallel`; builder `.series()`; feedback via Newton-Raphson. **Sem** operador `*` |
| Josue-Herrera | **Nenhuma** (2 aliases + 2 funcoes num `main`) |
| Hixos | **Diagrama de blocos**: trait `Block` (`step`) + `ControlSystemBuilder`; grafo petgraph + toposort; feedback so via bloco com `delay()>0`. Composicao por grafo/nomes de sinal |
| AlbertoFoti | Traits `Plant`/`ControlAlgorithm`; plantas EDO nao-lineares (pendulum, Lorenz, Chua, Van der Pol); **sem** matriz/builder/pipeline |
| **Aule** | **Forward composition**: trait `Block` (Input/Output assoc.) + `Signal<T>` com operador `*` encadeando `&mut dyn Block`; `Simulation` e `Iterator<Item=SimulationState>`; feedback explicito via `last_output()`; `Pack`/`Unpack` p/ sinais compostos |

---

## Posicionamento da Aule (o argumento — bullets, nao prosa)

1. **Unica no territorio da tese.** 0/6 sao `no_std`/embarcadas; a Aule e `no_std`-first e ainda
   tem ponte SWD (probe-rs) p/ hardware real. Usa a *mesma* nalgebra que a maioria (5/6), porem em
   modo `no_std` — mesmo ferramental, territorio diferente.
2. **Reune o que nas outras esta disperso e incompleto:** composicao de blocos (como pekpuglia /
   Hixos) + solver ODE Euler/RK4 (como Hixos) + representacoes TF/SS/discretas (como control-sys-rs /
   TorBox) + PID/filtros/identificacao/metricas (que quase ninguem tem) — num so artefato `no_std`.
3. **Diferenciais quase-exclusivos:** identificacao de sistemas (5 metodos) = **0/6**; filtros reais
   = **0/6**; genericidade no escalar de verdade = **0/6**.
4. **O eixo da tese nao tem par:** 0/6 tocam concorrencia / data race. A Aule e o veiculo unico para
   mapear a fronteira safe/`unsafe` de data races em controle concorrente.
5. **Duas familias, propositos diferentes** (usar para nao comparar maca com laranja):
   - **Analise LTI offline (estilo MATLAB):** control-sys-rs, TorBox — projetam/analisam no PC
     (TF/SS, Bode/Nyquist, c2d). **Nao executam controle, nao embarcam.** Contexto, nao concorrente.
   - **Composicao/execucao de blocos:** pekpuglia (type-safe), Hixos (diagrama/grafo), AlbertoFoti
     (plantas EDO). Mesma familia da Aule — porem todas `std`-bound, imaturas/abandonadas, sem o
     rigor de engenharia da Aule e sem `no_std`/concorrencia.
6. **Vizinhos mais proximos** (para nao ignorar na defesa):
   - **pekpuglia** e o mais proximo em *espirito* (composicao type-safe de sistemas) — mas sem
     execucao/simulacao, sem solver, imaturo (1 star, inativo).
   - **Hixos** e o mais proximo em *arquitetura* (trait `Block` + diagrama + solver RK4/Euler + PID)
     — mas via grafo/nomes (nao forward por tipos), `std`, sem README/CI, abandonado.

## Furos de banca (revisor — sem misericordia)

1. **Amostra a dedo.** As 6 vieram como "as mais maduras que achei". Sem metodo de busca e criterio
   de inclusao declarados, "a Aule e a mais completa" e conclusao enviesada. **Amarrar a subsecao
   `subsec:control-repos-method`:** onde buscou (GitHub? crates.io? topics `control-systems`?), como
   filtrou, por que essas 6. Sem isso, a comparacao nao se sustenta na arguicao.
2. **Comparabilidade (maca x laranja).** Comparar a Aule (execucao, `no_std`) com control-sys-rs /
   TorBox (analise offline) na mesma coluna mistura propositos. Separar as duas familias (Tabela C ja
   sugere) e situar a Aule na familia de execucao.
3. **README x codigo.** control-sys-rs anuncia LQR/pole placement **inexistente** no fonte; TorBox
   diz "simulating" **sem** loop de simulacao. Se citar features dessas libs, citar o que o **codigo**
   tem — ou usar a lacuna como ponto (READMEs otimistas). Verificavel.
4. **Coerencia com a Arquitetura B.** O outline rebaixou "bibliotecas de controle" a contexto (nao
   eixo de comparacao). Manter a secao **curta** — situa o veiculo, nao vira vitrine competitiva.
5. **Verificacao por IA (Regra 7).** Reconfirmar cada repo citado; manter os "ND" honestos (crates.io
   de alguns, ano de ultimo commit, docs.rs, presenca de `tests/` na Hixos).

## Relacao com o levantamento de PIDs (o outro CSV)

Esta analise (6 libs de controle) e **complementar** ao levantamento de 59 repos de PID
(`Control Rust Libraries - PIDs.csv`, star list GitHub 09/jun/2025). Juntos cobrem os dois eixos do
ecossistema: o bloco isolado (PID, 59 repos, raso em infraestrutura — so 2 com benches, 1 com RK4) e
as bibliotecas de sistema (estas 6, bifurcadas e imaturas). Convergem no mesmo veredito: **espaco
aberto para uma lib `no_std`, composicional, com simulacao e — sobretudo — com tratamento de
concorrencia.**

## Divergencias factuais registradas (para citar com cuidado)

- **control-sys-rs:** README promete "SISO pole placement, Discrete/Continuous LQR, closed-loop
  A-BK" — identificadores ausentes de todo o `src/` inspecionado.
- **TorBox:** descricao "designing, analysing, **simulating** and implementing" — sem loop de
  simulacao temporal no codigo (o exemplo faz tuning no dominio da frequencia).
- **CLAUDE.md / working tree:** o CLAUDE.md diz "continuous/discrete need alloc (nalgebra)" — correto
  na `main`. O working tree local (branch `arduino_fix`) estava com `faer`; divergencia de branch,
  nao do CLAUDE.md.

## Metodo de busca — VERIFICADO na API do GitHub (27/07/2026)

Chaves confirmadas contra a lista curada do Matheus (search API, `language:rust`):

- **PID:** chave `pid`. Cobre a lista (13/13 dos PIDs testados no top 100 por estrelas). Traz ruido
  "Process IDentity" do Linux (init systems / pidfiles: `fpco/pid1-rs`, `carllerche/pidfile-rust`,
  `minit`, `rinit`...). Chave mais limpa = `pid controller` (55 hits, sem ruido) mas perde recall
  (`idsp`, `guv` nao tem "pid" no nome).
- **Sistemas de controle:** chave `"control system"` (frase exata, singular) — **6/6** no top 100.
  Variantes NAO reproduzem: `control` (8213, ruido massivo), `control-system(s)` (afogam em version
  control), `"control toolbox"` (1 hit), `"system control"` (13, outro dominio), `control theory`
  (14, 0/6), `topic:control-systems` (2144, 0/6 — topics vazios em 5 dos 6).

Funil (totais de 27/07/2026 — a busca muda no tempo; numero exato NAO reproduzivel):

    pid              340 --(>=1 estrela)--> 165 --(falso positivo)--> 59   (-175 sem estrela, -106 FP)
    "control system" 347 --(>=1 estrela)--> 125 --(falso positivo)-->  6   (-222 sem estrela, -119 FP ~95%)
    total            687                    290                       65

- Corte 1 = **>=1 estrela** (elimina 175 no `pid`, 222 no `"control system"`).
- Corte 2 = **falso positivo manual** (`pid`: Process IDentity + irrelevantes; `"control system"`:
  version/source control, ~95% de FP pela colisao de "control").
- **Insight de honestidade:** as duas chaves colidem com termos de DevOps (Process IDentity ↔
  version control) → a **curadoria manual E o metodo real** (defesa Regra 7), nao a keyword.
- **Recall imperfeito** (assumir): a chave exige a palavra no nome/desc/topics → exclui relevantes
  como `idsp`. Ja registrado no §53 do `.tex`.

## Decisao de formato das tabelas na 5.x.2 (recomendacao salva 27/07 — retomar amanha)

Nao e "tabela OU prosa"; e **dividir por natureza do dado**:

- **Grade PID (59 x 18) -> APENDICE.** Grande/ilegivel inline; e dado de auditoria. No corpo entra so
  a **sintese** (contagens `yes/59`, ou o funil de features `32->17->9->5->3`). Gerar do CSV com
  **`csvsimple`** (pacote a ADICIONAR — evita transcrever ~1000 celulas e some quando a planilha
  mudar). `ic.cls` ja tem `booktabs`, `tabularx`, `rotating` (`sidewaystable` p/ girar); falta so
  `csvsimple` (e `longtable` se passar de 1 pagina landscape).
- **Grade control (6 x 7, + Aule) -> HIBRIDO inline:**
  - **micro-tabela de sinal** (✓/✗), 6 linhas, para os eixos que PROVAM a lacuna (no_std,
    concorrencia, generico, crates.io, maturidade) → o "0/6" salta aos olhos;
  - **prosa por FAMILIA** (analise offline × execucao/composicao) para o descritivo (backend,
    capacidades, abstracao) — texto le melhor que celula.
  - Matheus prefere prosa. Se **zero-tabela**: prosa por familia + **1 frase-sintese** cravando
    `0/6 no_std` e `0/6 concorrencia` + `itemize` de fecho. NUNCA 6 paragrafos-catalogo (cansa +
    parece avaliar projetos alheios, foge do escopo B).
  - A Aule entra como quem **preenche** a lacuna (linha final / fecho), sem comparar feature-a-feature.

## Pendencias / decisoes para o Matheus

- [x] ~~Declarar o metodo de busca~~ — FEITO na §5.x.1 (chaves + funil + cortes; verificados acima).
- [ ] Escrever a **5.x.2** (panorama) — roteiro imagem+6 campos oferecido, ainda nao montado.
- [ ] Formato final da grade control: hibrido (recomendado) vs zero-tabela.
- [ ] Recorte de colunas da sintese PID inline (corpo × apendice).
- [x] ~~`anti-windup` / genericidade 3 niveis~~ — JA corrigidos no `.tex` (27/07).
- [ ] Reconfirmar os repos citados (Regra 7) e resolver os "ND".
- [ ] Confirmar `c2d` e estado dos blocos de sync na Aule (branches `sync`/`number_generic`).
