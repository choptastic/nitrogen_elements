-module(common_tests).
-compile([export_all]).
-include_lib("eunit/include/eunit.hrl").

options_to_js_test_() ->
    [
     ?_assertEqual("{ selected: 0 }", common:options_to_js([{selected, 0}]))
    ].
