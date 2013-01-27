ERL					?= erl
ERLC				= erlc
EBIN_DIRS		:= $(wildcard deps/*/ebin)
APPS				:= $(shell dir apps)

.PHONY: rel deps

all: deps compile

compile:
	rebar compile

deps:
	rebar get-deps

clean:
	rebar clean

realclean: clean
	rebar delete-deps

test: all
	rebar skip_deps=true eunit
