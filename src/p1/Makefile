# author: Claude (claude-opus-4-8)
# created: 2026-07-22
#
# Caso P1 (setpoint escalar compartilhado) do cap. 5 -- build do snippet em C.
# Duas variantes:
#   plain -> sem sanitizer      : mostra que o data race COMPILA e RODA (valor obsoleto latente)
#   tsan  -> ThreadSanitizer     : DETECTA o data race quando o caminho e exercitado
#
# Ambiente: Linux, macOS ou WSL2. TSan NAO roda em Windows nativo (clang-cl/MSVC).
# O arquivo-fonte (setpoint.c) e do Matheus -- este Makefile so o compila.

CC        ?= clang
SRC       ?= setpoint.c
BIN       ?= setpoint

CFLAGS    ?= -g -O1 -pthread -Wall -Wextra
TSANFLAGS ?= -fsanitize=thread

# Opcoes de runtime do TSan (sobrescreva na linha de comando se quiser)
TSAN_OPTIONS ?= halt_on_error=1 history_size=7 second_deadlock_stack=1
export TSAN_OPTIONS

.PHONY: all tsan plain run run-plain clean help

all: tsan

## --- variante instrumentada (detecta o DR) ---
$(BIN)-tsan: $(SRC)
	$(CC) $(CFLAGS) $(TSANFLAGS) $< -o $@

tsan: $(BIN)-tsan

run: $(BIN)-tsan
	./$(BIN)-tsan

## --- variante limpa (compila e roda com o DR latente) ---
$(BIN)-plain: $(SRC)
	$(CC) $(CFLAGS) $< -o $@

plain: $(BIN)-plain

run-plain: $(BIN)-plain
	./$(BIN)-plain

clean:
	rm -f $(BIN)-tsan $(BIN)-plain

help:
	@echo "Alvos:"
	@echo "  make plain      compila sem sanitizer (DR latente: compila e roda)"
	@echo "  make run-plain  compila e roda a variante limpa"
	@echo "  make tsan       compila com ThreadSanitizer"
	@echo "  make run        compila e roda a variante com TSan (detecta o DR se exercitado)"
	@echo "  make clean      remove os binarios"
	@echo ""
	@echo "Variaveis (sobrescreva com make VAR=valor):"
	@echo "  CC=$(CC)   SRC=$(SRC)   BIN=$(BIN)"
	@echo "  ex.: make run CC=gcc            (usa gcc no lugar do clang)"
	@echo "  ex.: make run SRC=meu_caso.c    (outro arquivo-fonte)"
