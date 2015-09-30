ERL = $(shell which erl)

APP := erlang_playground

.PHONY: all deps clean distclean docs

all: deps
	@./rebar compile

deps:
	@./rebar get-deps

clean:
	@./rebar clean

distclean: clean
	@./rebar delete-deps

shell:
	@./rebar shell

docs:
	@erl -noshell -run edoc_run application '$(APP)' '"."' '[]'

