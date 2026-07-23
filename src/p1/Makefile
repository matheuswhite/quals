# author: Claude (claude-opus-4-8)
# created: 2026-07-22
# modified:
#   2026-07-23 (Claude): adicionados os alvos Rust (run-safe / run-atomic) e a
#     geracao de saida em .txt para TODOS os casos (C plain, C TSan, Rust safe,
#     Rust atomic); alvo `outputs` gera as 4 saidas de uma vez; `clean` agora
#     remove tambem os bundles *.dSYM do macOS.
#   2026-07-23 (Claude): saidas .txt movidas p/ a pasta out/ (var OUT_DIR); a pasta
#     e criada sob demanda; `clean-outputs` agora remove a pasta out/ inteira.
#
# Caso P1 (setpoint escalar compartilhado) do cap. 5 -- build + geracao de saida
# dos micro-exemplos. Quatro casos, cada um com sua saida .txt:
#   C plain     -> compila e RODA: o data race COMPILA e roda (valor obsoleto latente)
#   C TSan      -> ThreadSanitizer: DETECTA o data race quando o caminho e exercitado
#   Rust safe   -> NAO COMPILA de proposito: rustc RECUSA (E0277, Cell<f32> nao e Sync)
#   Rust atomic -> compila e RODA: a forma segura (Arc<AtomicU32>)
#
# Ambiente: Linux, macOS ou WSL2. TSan NAO roda em Windows nativo (clang-cl/MSVC).
# Os arquivos-fonte sao do Matheus -- este Makefile so os compila/roda/captura.

CC        ?= clang
RUSTC     ?= rustc
SRC       ?= setpoint.c
BIN       ?= setpoint
RS_SAFE   ?= setpoint_safe.rs
RS_ATOMIC ?= setpoint_atomic.rs

CFLAGS    ?= -g -O1 -pthread -Wall -Wextra
TSANFLAGS ?= -fsanitize=thread
RUSTFLAGS ?= -O

# Opcoes de runtime do TSan (sobrescreva na linha de comando se quiser)
TSAN_OPTIONS ?= halt_on_error=1 history_size=7 second_deadlock_stack=1
export TSAN_OPTIONS

# Saidas -- TODAS em .txt (uma por caso), na pasta out/
OUT_DIR    ?= out
OUT_PLAIN  ?= $(OUT_DIR)/setpoint_plain.txt
OUT_TSAN   ?= $(OUT_DIR)/setpoint_tsan.txt
OUT_SAFE   ?= $(OUT_DIR)/setpoint_safe.txt
OUT_ATOMIC ?= $(OUT_DIR)/setpoint_atomic.txt

.PHONY: all outputs \
        tsan plain atomic \
        run run-plain run-atomic run-safe \
        clean clean-outputs distclean help

## Padrao: gera as 4 saidas .txt
all: outputs

## =====================================================================
## Build (so compila, nao roda)
## =====================================================================

# C -- variante instrumentada (detecta o DR)
$(BIN)-tsan: $(SRC)
	$(CC) $(CFLAGS) $(TSANFLAGS) $< -o $@
tsan: $(BIN)-tsan

# C -- variante limpa (compila e roda com o DR latente)
$(BIN)-plain: $(SRC)
	$(CC) $(CFLAGS) $< -o $@
plain: $(BIN)-plain

# Rust -- forma segura com atomic (Arc<AtomicU32>)
setpoint_atomic: $(RS_ATOMIC)
	$(RUSTC) $(RUSTFLAGS) $< -o $@
atomic: setpoint_atomic

## =====================================================================
## Rodar interativamente (imprime no terminal, sem salvar)
## =====================================================================

run: $(BIN)-tsan
	./$(BIN)-tsan

run-plain: $(BIN)-plain
	./$(BIN)-plain

run-atomic: setpoint_atomic
	./setpoint_atomic

# Rust safe: NAO compila de proposito -- mostra o E0277 no terminal.
# O `-` faz o make ignorar o exit code (a falha e o resultado esperado).
run-safe: $(RS_SAFE)
	-$(RUSTC) $(RS_SAFE) -o /dev/null

## =====================================================================
## Gerar saida em .txt (uma regra por caso; captura stdout + stderr)
## =====================================================================

# Cria a pasta de saida sob demanda (pre-requisito order-only, o `|`).
$(OUT_DIR):
	mkdir -p $(OUT_DIR)

# C plain: o run deve ter SUCESSO -> sem `-` (falha real aborta e aparece).
$(OUT_PLAIN): $(BIN)-plain | $(OUT_DIR)
	@echo "==> [C plain] rodando; saida -> $@"
	./$(BIN)-plain > $@ 2>&1

# C TSan: o report do data race vai p/ stderr e (halt_on_error=1) aborta com
# exit != 0 -- isso e ESPERADO, entao `-` p/ nao abortar o make (o redirect ja
# capturou a saida antes do abort). Deteccao e probabilistica (se exercitado).
$(OUT_TSAN): $(BIN)-tsan | $(OUT_DIR)
	@echo "==> [C TSan] rodando (DR se exercitado); saida -> $@"
	-./$(BIN)-tsan > $@ 2>&1

# Rust safe: a compilacao FALHA de proposito (E0277) -> exit != 0 ESPERADO -> `-`.
$(OUT_SAFE): $(RS_SAFE) | $(OUT_DIR)
	@echo "==> [Rust safe] compilando (esperado FALHAR: E0277); saida -> $@"
	-$(RUSTC) $(RS_SAFE) -o /dev/null > $@ 2>&1

# Rust atomic: o run deve ter SUCESSO -> sem `-`.
$(OUT_ATOMIC): setpoint_atomic | $(OUT_DIR)
	@echo "==> [Rust atomic] rodando; saida -> $@"
	./setpoint_atomic > $@ 2>&1

# Gera as 4 saidas de uma vez.
outputs: $(OUT_PLAIN) $(OUT_TSAN) $(OUT_SAFE) $(OUT_ATOMIC)
	@echo "==> saidas .txt geradas:"
	@echo "      $(OUT_PLAIN)   (C plain)"
	@echo "      $(OUT_TSAN)    (C TSan -- DR se exercitado)"
	@echo "      $(OUT_SAFE)    (Rust safe -- E0277)"
	@echo "      $(OUT_ATOMIC)  (Rust atomic)"

## =====================================================================
## Limpeza
## =====================================================================

# Remove binarios E os bundles *.dSYM do macOS (o `make clean` antigo NAO os removia).
clean:
	rm -f $(BIN)-tsan $(BIN)-plain setpoint_atomic
	rm -rf *.dSYM

# Remove a pasta de saidas out/ (evidencia) -- separado, p/ nao apagar sem querer.
clean-outputs:
	rm -rf $(OUT_DIR)

distclean: clean clean-outputs

help:
	@echo "Alvos principais:"
	@echo "  make               (= make outputs) gera as 4 saidas .txt"
	@echo "  make outputs       gera todas as saidas em $(OUT_DIR)/: C plain, C TSan, Rust safe, Rust atomic"
	@echo ""
	@echo "Saidas .txt (uma por caso, na pasta $(OUT_DIR)/):"
	@echo "  $(OUT_PLAIN)   <- C plain (DR latente: compila/roda)"
	@echo "  $(OUT_TSAN)    <- C TSan (report do data race, se exercitado)"
	@echo "  $(OUT_SAFE)    <- Rust safe (recusa do rustc: E0277)"
	@echo "  $(OUT_ATOMIC)  <- Rust atomic (forma segura Arc<AtomicU32>)"
	@echo ""
	@echo "Rodar no terminal (sem salvar):"
	@echo "  make run-plain     C limpo    |  make run        C com TSan"
	@echo "  make run-atomic    Rust atom  |  make run-safe   Rust safe (mostra o E0277)"
	@echo ""
	@echo "Build so (sem rodar): make plain | make tsan | make atomic"
	@echo ""
	@echo "Limpeza:"
	@echo "  make clean         remove binarios + *.dSYM (mantem a pasta $(OUT_DIR)/)"
	@echo "  make clean-outputs remove a pasta $(OUT_DIR)/ (as saidas .txt)"
	@echo "  make distclean     clean + clean-outputs"
	@echo ""
	@echo "Variaveis (sobrescreva com make VAR=valor):"
	@echo "  CC=$(CC)  RUSTC=$(RUSTC)  SRC=$(SRC)  BIN=$(BIN)"
	@echo "  ex.: make outputs CC=gcc"
