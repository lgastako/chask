help:
	@cat Makefile

EXE=chask

build:
	stack build .

hlint:
	stack exec hlint .

install:
	stack install .

run:
	stack exec chask $(ARGS)

b: build
hl: hlint
r: run
