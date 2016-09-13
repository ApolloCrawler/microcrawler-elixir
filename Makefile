.DEFAULT: all

.PHONY: all

all: build

build: mix_deps

mix_deps: mix_deps_get mix_deps_compile

mix_deps_compile:
	mix deps.compile

mix_deps_get:
	mix deps.get
