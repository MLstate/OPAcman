.PHONY: all clean run plugins $(EXE)

OPA ?= opa
OPA_PLUGIN ?= opa-plugin-builder
EXE = opacman.exe

all: $(EXE)

plugins: plugins/mindwave/mindwave.js
	$(OPA_PLUGIN) --js-validator-off plugins/mindwave/mindwave.js -o mindwave.opp
	$(OPA) $(OPA_OPT) plugins/mindwave/mindwave.opa mindwave.opp

$(EXE): plugins src/*.opa resources/*
	opa --parser classic src/*.opa *.opp -o $(EXE)

run: all
	./$(EXE) $(RUN_OPT) || true

clean:
	rm -Rf *.opx* *.opp*
	rm -Rf *.exe _build _tracks *.log **/#*#
