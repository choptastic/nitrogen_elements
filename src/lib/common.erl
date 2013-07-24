
-module(common).
-export([options_to_js/1]).
%% -compile(export_all).

options_to_js(Options) ->
    wf:f("{ ~s }", [string:join([parse(X) || X <- Options], ",")]).

parse({Key,Value}) when Key==formatoptions orelse Key ==editoptions ->
    Js = options_to_js(Value),    
    wf:f("~s: ~s ", [Key, Js]);

parse({Key,{function,Value}}) ->
  
 Js = wf:f("~s: ~p", [Key, Value]),
 Js2 =re:replace(Js, "\"", "", [global, {return,list}]),
 Test=re:replace(Js2, "#", "\\\\", [global, {return,list}]),
 Test2=re:replace(Test, "\%", "\"", [global, {return,list}]),
 Test2;


parse({Key, Value}) when is_list(Value) andalso is_tuple(hd(Value)) ->
    Opts = string:join([wf:f("{~s}", [X]) || X <- [parse(X) || X <- Value]], ","),
    wf:f("~s: [ ~s ]", [Key, Opts]);
parse({Key, Value}) when is_list(Value) andalso is_list(hd(Value)) ->
    Opts = string:join([wf:f("{~s}", [X]) || X <- [parse(X) || X <- Value]], ","),
    wf:f("~s: [ ~s ]", [Key, Opts]);
parse({Key, Value}) when is_list(Value) ->
    Opts = string:join([parse(X) || X <- Value], ","),
    wf:f("~s: [ ~s ]", [Key, Opts]);
parse({Key, Value}) when is_tuple(Value) ->
    Opts = string:join([parse(X) || X <- tuple_to_list(Value)], ","),
    wf:f("~s: { ~s }", [Key, Opts]);
parse({Key, Value}) when is_binary(Value) ->
    wf:f("~s: '~s'", [Key, wf:js_escape(binary_to_list(Value))]);
parse({Key, Value}) when is_atom(Value) andalso (Value == true orelse Value == false) ->
    wf:f("~s: ~s", [Key, Value]);
parse({Key, Value}) when is_atom(Value) ->
    wf:f("~s: '~s'", [Key, Value]);
parse({Key, Value}) ->
    wf:f("~s: ~p", [Key, Value]);
parse(Value) when is_list(Value) ->
    Opts = string:join([parse(X) || X <- Value], ", "),
    wf:f("~s", [Opts]);
parse(Value) when is_integer(Value) ->
    wf:f("~p", [Value]);
parse(Value) when is_atom(Value) andalso (Value == true orelse Value == false) ->
    wf:f("~s", [Value]);
parse(Value) when is_atom(Value) ->
    wf:f("'~s'", [Value]);
parse(Value) when is_binary(Value) ->
    wf:f("'~s'", [wf:js_escape(binary_to_list(Value))]).
