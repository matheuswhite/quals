---
author: Claude (claude-opus-4-8)
created: 2026-07-22
modified:
  - 2026-07-22: Claude (claude-opus-4-8) — registrou o achado sobre custo de AtomicU32 no Xtensa (S32C1I) e o caminho de verificacao por disassembly
  - 2026-07-23: Claude (claude-opus-4-8) — micro-exemplos do caso P1 adicionados e testados no host (a pedido do Matheus): src/p1/setpoint.c (compila/roda; TSan aponta o DR em g_setpoint), setpoint_safe.rs (recusa com E0277 -- `Cell<f32>` nao e Sync), setpoint_atomic.rs (compila/roda). Sao andaimes: o Matheus testa/adapta na toolchain dele e salva a mensagem real do rustc. Pendencia de snippet abaixo atualizada.
  - 2026-07-23: Claude (claude-opus-4-8) — confirmada a pendencia "como o setpoint aparece na Aule" (l. 81): achado em tier1/sync/mirror.rs (`Mirror<T>`) e tier1/sync/channel.rs (`Channel`). setpoint_atomic.rs migrado de `static AtomicU32` p/ `Arc<AtomicU32>` (a pedido do Matheus) p/ prefigurar `Mirror::Primitive32`; recompilado/rodado no host.
---

<!-- LTeX: enabled=false -->

# Cap. 5 — Resultados Parciais: esqueleto + roteiro do caso setpoint (P1)

Andaime de planejamento (Regra 4): estrutura e roteiro do que cada seção **cobre** — não contém prosa da tese. Companheiro de [`outline_geral.md`](outline_geral.md) e [`roadmap_escrita.md`](roadmap_escrita.md).

## Decisões que moldam o capítulo

- **Arquitetura B** (fechada 2026-06-11): o cap. 5 fica com os resultados **materiais** (código que compila/não-compila, estado da Aule); os resultados *conceituais* (taxonomia, fronteira, espaço de design) já estão no cap. 4. Linha de corte: conceitual (cap. 4) × material/artefato (cap. 5).
- **Corte 20/jul (roadmap):** **1 caso demonstrativo, profundo — setpoint escalar (P1)**. Intocável. Os demais padrões (P2/P3) viram trabalho pós-qual (cap. 6).
- **Narrativa (outline):** metade 1 = estado da Aule (Ato 2, "a tentativa funciona") → metade 2 = evidência + honestidade (Ato 3).

## Esqueleto `.tex` sugerido (rótulos — transcrever no `.tex`; sem prosa aqui)

> Substitui o `\section{Análise de Eficiência}` atual (o outline já marcou "eficiência" como estreito demais). Usar `\section`/`\subsection` normais dentro do `\mychapter` (nunca `\mychapter` de novo — convenção da classe).

```
\mychapter{Resultados Parciais}{cap:Resultados Parciais}
\label{cap:experiment}      % satisfaz \ref{cap:experiment} da 4.6.1 (l.333) — ver nota abaixo

\section{Estado atual da biblioteca Aule}
\label{sec:aule-state}

\section{Caso demonstrativo: setpoint escalar compartilhado (P1)}
\label{sec:case-setpoint}
  \subsection{Cenario e o padrao P1}          \label{subsec:setpoint-scenario}
  \subsection{O data race em C}                \label{subsec:setpoint-c}
  \subsection{A recusa do compilador em Rust safe} \label{subsec:setpoint-reject}
  \subsection{A forma segura com atomic}       \label{subsec:setpoint-atomic}
  \subsection{Leitura do caso como evidencia}  \label{subsec:setpoint-evidence}

\section{Limitacoes conhecidas}
\label{sec:partial-limitations}
```

### ⚠️ Ponto a ajustar na §4.6.1 (revisão 22/jul — CORRIGIDA; a versão anterior errava a localização e a natureza)

**Onde:** `Metodologia_Proposta.tex` **l. 333, §4.6.1 (Planta e plataforma)** — NÃO na 4.3.2 (erro da nota anterior).

**O P3 ali está CORRETO — não trocar por P1.** O contexto é a planta do experimento de custo (pêndulo Furuta, 2 encoders → bloco coerente ⟨θ,α⟩ atualizado junto = célula ⟨ISR-Tarefa, Struct, Leitor-Escritor⟩, fixada em P3 na 4.6.1). Trocar P3→P1 quebraria a descrição (o setpoint P1 é escalar, sem ISR↔encoders).

**A tensão real é na expressão**, não no padrão. A frase "esta interação é utilizada no **caso central do capítulo** `\ref{cap:experiment}`" conflaciona o **experimento de custo** (P3, protocolo pós-qual) com o **caso demonstrativo central** da qualificação (P1/setpoint, único caso material — corte 20/jul). O cap. 5 (`cap:experiment`) tem os dois, com papéis distintos. Ajuste (redação/referência, mantendo P3):
- **(recomendado)** trocar "utilizada no caso central do capítulo `\ref{cap:experiment}`" por algo que nomeie o **experimento de custo** (ex.: "...é o padrão avaliado no experimento de custo, cujo protocolo está na seção `\ref{sec:experiment-proc}`") — mantém P3, tira o "central" (que pertence ao P1);
- reservar "caso central/demonstrativo" para o P1 (setpoint) dentro do cap. 5;
- o `\label{cap:experiment}` no capítulo evita o `??` no build enquanto isso.

## Roteiro do caso setpoint escalar (P1) — imagem + 6 campos

**Imagem:** a prova de bancada mínima da tese — o menor exemplo real em que *o bug que compila em C não compila em Rust safe*. Um escalar (setpoint) compartilhado entre a tarefa de comunicação (escreve) e o loop de controle (lê); em C compila/roda com o data race latente, em Rust safe o compilador recusa e força `AtomicU32`. É o P1 da taxonomia instanciado em código compilável (evidência por construção). É o caso **limpo**: P1 fecha 100% em safe (sem `unsafe` residual — contraste com P2).

**Missão:** entregar a evidência por construção central da qualificação — em código compilável e reproduzível, o DR do P1 passa em C e é recusado pelo compilador Rust safe; a forma atomic é a única que compila. Qualitativo; independe do experimento de custo.

**Perguntas que responde:** cenário real (quem escreve/lê o setpoint); como o bug se manifesta em C (compila, roda, valor obsoleto); o que o Rust safe recusa e por qual mecanismo/mensagem (`Send`/`Sync`, `static mut`, aliasing de `&mut`); qual a forma que compila (`AtomicU32` + `Ordering`) e por que o DR fica inexprimível; por que é evidência (não anedota); como amarra ao cap. 4.

**Blocos (ordem de escrita):**
1. **Cenário + o padrão P1** (`subsec:setpoint-scenario`) — setpoint escalar; tarefa comm (escreve) × loop controle (lê); Aule como veículo; `\ref{sec:taxonomy}` (este é o P1).
2. **O data race em C** (`subsec:setpoint-c`) — trecho C mínimo: compartilhado sem sincronização; compila e roda; hazard (valor obsoleto → sinal de controle errado); nenhum erro do compilador.
3. **A recusa em Rust safe** (`subsec:setpoint-reject`) — o mesmo padrão não compila; mecanismo (`Send`/`Sync`, `static mut`, `&mut` cross-context) + mensagem do `rustc` (`E0277`); reusar o critério da 4.3.2 via `\ref` (não re-derivar). Evidência primária.
4. **A forma segura com atomic** (`subsec:setpoint-atomic`) — `AtomicU32` (`store`/`load` + `Ordering`); compila; DR inexprimível; materializa a garantia "atomic load/store" que a 4.2 deu ao P1.
5. **Leitura como evidência** (`subsec:setpoint-evidence`) — o que demonstra (deslocamento da verificação p/ o tipo); P1 inteiramente safe, sem `unsafe` residual (contraste P2); é o trio da 4.7.2 (`subsec:dim-inst`) preenchido para P1; amarra à fronteira (`sec:border`).
6. **(opcional) fechar o trio** — TSan sobre o C no host detecta se exercitado; MISRA disciplina, não força → honestidade. Núcleo = par compila/não-compila; o 3º elemento é aprofundamento (não obrigatório sob o corte).

**Por que a ordem:** cenário → bug que passa em C → recusa (clímax compila×não-compila) → forma que compila → leitura. É a sequência de um experimento (montagem → controle → resultado → leitura).

**Pontos de defesa:** "compila/não-compila é evidência?" → por construção (4.1 exploratória), reproduzível; "escolheu o exemplo?" → P1 derivado sistematicamente no cap. 4 + é o mais simples (se falha no trivial em C...); "dev C usaria atomic também" → em C é opcional/disciplina, o Rust safe TORNA obrigatório; "por que 1 caso?" → corte (profundidade > amplitude), P1 didático, P2/P3 pós-qual.

**Fronteiras (não invadir):** cap. 4 (taxonomia/fronteira/método = `\ref`, não re-derivar); metade 1 do cap. 5 (estado da Aule é `sec:aule-state`, aqui a Aule é só veículo); §4.6 (sem números/ciclos — este caso é qualitativo); `sec:partial-limitations` (a honestidade geral é lá; aqui, no máximo, "P1 é o caso limpo").

## Pendências antes do sábado (W7)

- **Snippets: andaimes prontos e testados no host** (`src/p1/`, adicionados por Claude 23/jul; par compila×não-compila conferido) — `setpoint.c` (compila/roda/DR latente; `make run-plain`), `setpoint_safe.rs` (recusa com `E0277`, `Cell<f32>` não é `Sync`), `setpoint_atomic.rs` (agora `Arc<AtomicU32>`; compila/roda). **Restam do Matheus:** rodar na própria toolchain e **salvar a mensagem real do `rustc`** num arquivo p/ colar no sábado; rodar `make run` (TSan) e salvar a saída; adaptar o cenário se quiser (ex.: nomes, `Ordering`).
- Snippet é **novo (P1/setpoint)** — `src/p2_snippet.rs` é do **P2**, não serve. `src/**/target/` já está no `.gitignore` (l. 82) → versionar `src/` não arrasta o build. **Cuidado:** `make clean` **não** remove os bundles `*.dSYM` do macOS (gerados por `-g`) — apagar à mão antes de commitar (ou não commitar binários).
- **Confirmado (23/jul, lendo `../aule`):** o setpoint tem casa nativa na Aule via `src/tier1/sync/mirror.rs` — `Mirror<T>`, variante `Primitive32 { data: Arc<AtomicU32> }` (escalares ≤ 4 bytes; `Compose { Arc<Mutex<T>> }` p/ tipos maiores). `Mirror` implementa `Block` e faz o mesmo `f32`↔`u32` do exemplo, via `T: Into<AtomicU32>`. Ou seja: `Mirror::Primitive32` **é** o `setpoint_atomic.rs` elevado a `Block` — é onde a Aule instancia a forma que a linguagem forçou. `src/tier1/sync/channel.rs` (`Channel<T, N>`, SPSC `heapless` + `atomic_wait`) é a alternativa por troca de mensagens (não é P1 — é outro ponto da taxonomia).
  - **Onde entra na narrativa:** metade 1 (`sec:aule-state`) e bloco 1 (cenário/veículo). **NÃO** na evidência: o par compila×não-compila (blocos 2–4) fica sem a lib de propósito — senão a banca pergunta "é o Rust garantindo, ou o design da sua lib forçando?". A Aule entra *ao lado* da prova, como veículo que a materializa.
  - **Nota do `Arc`:** `Mirror::Primitive32` usa `Arc<AtomicU32>` (exige `alloc`). Por isso o `setpoint_atomic.rs` foi migrado de `static` (core puro, igualmente válido) p/ `Arc` — para prefigurar o `Mirror`. Detalhe a ter pronto p/ a banca: por que aqui é `Arc` e não `static`.
  - *(O item "`AtomicU32` barato no Xtensa" foi pesquisado em 22/jul — ver a seção "Achado" abaixo; a conclusão **nuança** o "sem custo" e ainda pede verificação no disassembly.)*
- **Decidir** a inconsistência `cap:experiment` P1×P3 (acima) — afeta se entra a seção de protocolo do experimento.

## Achado — custo de `AtomicU32` no Xtensa (`S32C1I`) [pesquisado 22/jul]

Origem: pesquisa técnica na web em 22/jul (papel de suporte técnico), **ainda não verificada no disassembly**. A "Ação" abaixo é o que precisa entrar nos Resultados (subsec:setpoint-atomic / sec:partial-limitations). Fontes ao final — confirmar ao citar (Regra 7).

**Conclusão — nuança o "sem custo":** não é um "sim" único; depende (a) da operação atômica e (b) do chip.

- `S32C1I` é a **única** instrução atômica do ISA Xtensa: um *conditional store* (CAS) via registrador especial `SCOMPARE1`. Um CAS custa **2 instruções** (setar `SCOMPARE1` + `S32C1I`), não uma.
- **`load`/`store`** (`Relaxed`/`Acquire`/`Release`): rebaixam para `L32AI`/`S32RI` (ou `L32I`/`S32I` no `Relaxed`) — custo ≈ acesso normal à memória → **barato**.
- **RMW** (`fetch_add`, `swap`, `compare_exchange`, ...): o Xtensa **não tem** RMW atômico dedicado → viram **laço de CAS** (`load → computa → S32C1I → repete se falhou`). Em uniprocessador quase nunca reitera, mas **não é uma única instrução**.

**Depende do chip:**

| Chip | Núcleo | Tem `S32C1I`? | `AtomicU32` no Rust |
|------|--------|---------------|---------------------|
| ESP32 | LX6, dual-core | Sim | Nativo: load/store baratos, RMW = laço-CAS |
| ESP32-S3 | LX7, dual-core | Sim | Igual — nativo |
| ESP32-S2 | LX7, single-core | **Não** | target usa `+forced-atomics` → **libcall** (`__atomic_*`, software) → não é barato |

**Impacto no argumento do P1 (setpoint):** o P1 usa **`store`/`load`** (não RMW) — justamente as operações baratas. Logo o claim "P1 é safe **e** sem custo" **se sustenta no ESP32 / ESP32-S3** (instrução nativa), mas **precisa de ressalva no ESP32-S2** (vira libcall). Afirmar "sem custo" sem qualificar o chip é frágil para a banca.

**Ação (o lembrete):**
1. Desmontar o binário por target e conferir o que sai de fato:
   - `cargo build --release --target xtensa-esp32-none-elf` → `xtensa-esp32-elf-objdump -d ...` → procurar `S32C1I` / `L32AI` / `S32RI`.
   - Repetir com `--target xtensa-esp32s2-none-elf` → procurar chamadas `__atomic_*`.
2. Confirmar o conjunto exato de instruções por `Ordering` (não afirmar `L32AI`/`S32RI` sem ver no disassembly).
3. Ajustar a redação: "sem custo" → qualificado por chip (nativo no ESP32/S3; libcall no S2).

**Fontes (candidatas — confirmar ao citar):**
- Xtensa ISA Summary (Cadence) — semântica de `S32C1I` / `SCOMPARE1`.
- rustc target spec `xtensa_esp32s2_none_elf.rs` — `max_atomic_width: Some(32)` + `+forced-atomics`.
- `esp-rs/xtensa-atomic-emulation-trap` — emulação de atômico em alvos sem CAS nativo.
- Zephyr #21800 — `SCOMPARE1` não salvo no context switch (nota de *soundness*, não de custo).
