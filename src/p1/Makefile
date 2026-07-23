CC        ?= clang
RUSTC     ?= rustc
SRC       ?= setpoint.c
BIN       ?= setpoint
RS_SAFE   ?= setpoint_safe.rs
RS_ATOMIC ?= setpoint_atomic.rs
FEED_SH   ?= feed_setpoints.sh

CFLAGS    ?= -g -O1 -pthread -Wall -Wextra
TSANFLAGS ?= -fsanitize=thread
RUSTFLAGS ?= -O

TSAN_OPTIONS ?= halt_on_error=1 history_size=7 second_deadlock_stack=1
export TSAN_OPTIONS

TIMEOUT ?= 3
RUN_TIMEOUT = perl -e 'alarm shift @ARGV; exec @ARGV' $(TIMEOUT)

OUT_DIR    ?= out
OUT_PLAIN  ?= $(OUT_DIR)/setpoint_plain.txt
OUT_TSAN   ?= $(OUT_DIR)/setpoint_tsan.txt
OUT_SAFE   ?= $(OUT_DIR)/setpoint_safe.txt
OUT_ATOMIC ?= $(OUT_DIR)/setpoint_atomic.txt

.PHONY: all outputs \
        tsan plain atomic \
        run run-plain run-atomic run-safe \
        clean clean-outputs distclean help

all: outputs

$(BIN)-tsan: $(SRC)
	$(CC) $(CFLAGS) $(TSANFLAGS) $< -o $@
tsan: $(BIN)-tsan

$(BIN)-plain: $(SRC)
	$(CC) $(CFLAGS) $< -o $@
plain: $(BIN)-plain

setpoint_atomic: $(RS_ATOMIC)
	$(RUSTC) $(RUSTFLAGS) $< -o $@
atomic: setpoint_atomic

run: $(BIN)-tsan
	./$(BIN)-tsan

run-plain: $(BIN)-plain
	./$(BIN)-plain

run-atomic: setpoint_atomic
	./setpoint_atomic

run-safe: $(RS_SAFE)
	-$(RUSTC) $(RS_SAFE) -o /dev/null

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_PLAIN): $(BIN)-plain $(FEED_SH) | $(OUT_DIR)
	@echo "==> [C plain] alimentando setpoints por ate $(TIMEOUT)s; saida -> $@"
	-sh $(FEED_SH) | $(RUN_TIMEOUT) ./$(BIN)-plain > $@ 2>&1

$(OUT_TSAN): $(BIN)-tsan $(FEED_SH) | $(OUT_DIR)
	@echo "==> [C TSan] alimentando setpoints por ate $(TIMEOUT)s; saida -> $@"
	-sh $(FEED_SH) | $(RUN_TIMEOUT) ./$(BIN)-tsan > $@ 2>&1

$(OUT_SAFE): $(RS_SAFE) | $(OUT_DIR)
	@echo "==> [Rust safe] compilando (esperado FALHAR: E0277); saida -> $@"
	-$(RUSTC) $(RS_SAFE) -o /dev/null > $@ 2>&1

$(OUT_ATOMIC): setpoint_atomic $(FEED_SH) | $(OUT_DIR)
	@echo "==> [Rust atomic] alimentando setpoints por ate $(TIMEOUT)s; saida -> $@"
	-sh $(FEED_SH) | $(RUN_TIMEOUT) ./setpoint_atomic > $@ 2>&1

outputs: $(OUT_PLAIN) $(OUT_TSAN) $(OUT_SAFE) $(OUT_ATOMIC)
	@echo "==> saidas .txt geradas em $(OUT_DIR)/:"
	@echo "      $(OUT_PLAIN)   (C plain)"
	@echo "      $(OUT_TSAN)    (C TSan -- DR se exercitado)"
	@echo "      $(OUT_SAFE)    (Rust safe -- E0277)"
	@echo "      $(OUT_ATOMIC)  (Rust atomic)"

clean:
	rm -f $(BIN)-tsan $(BIN)-plain setpoint_atomic
	rm -rf *.dSYM

clean-outputs:
	rm -rf $(OUT_DIR)

distclean: clean clean-outputs

help:
	@echo "Alvos principais:"
	@echo "  make               (= make outputs) gera as 4 saidas .txt"
	@echo "  make outputs       gera todas as saidas em $(OUT_DIR)/"
	@echo ""
	@echo "As saidas que rodam (plain, tsan, atomic) recebem os setpoints de"
	@echo "  $(FEED_SH) via stdin e sao limitadas a $(TIMEOUT)s (var TIMEOUT)."
	@echo ""
	@echo "Saidas .txt (uma por caso, na pasta $(OUT_DIR)/):"
	@echo "  $(OUT_PLAIN)   <- C plain (DR latente: compila/roda)"
	@echo "  $(OUT_TSAN)    <- C TSan (report do data race, se exercitado)"
	@echo "  $(OUT_SAFE)    <- Rust safe (recusa do rustc: E0277)"
	@echo "  $(OUT_ATOMIC)  <- Rust atomic (forma segura Arc<AtomicU32>)"
	@echo ""
	@echo "Rodar interativo (voce digita os setpoints, Ctrl-C p/ sair):"
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
	@echo "  CC=$(CC)  RUSTC=$(RUSTC)  TIMEOUT=$(TIMEOUT)  FEED_SH=$(FEED_SH)"
	@echo "  ex.: make outputs TIMEOUT=6"
