ERL = $(shell which erl)
REBAR=$(shell which rebar)

APP := erlang_playground

.PHONY: all deps clean distclean docs

all: deps
	$(REBAR) compile

deps:
	$(REBAR) get-deps

clean:
	$(REBAR) clean

distclean: clean
	$(REBAR) delete-deps

docs:
	@erl -noshell -run edoc_run application '$(APP)' '"."' '[]'

