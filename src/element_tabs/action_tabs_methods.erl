% Nitrogen Web Framework for Erlang
% Copyright (c) 2009 Andreas Stenius
% See MIT-LICENSE for licensing information.

-module(action_tabs_methods).
-include("nitrogen_elements.hrl").
-compile(export_all).

%% render_action(Record) ->
%%     {Script, Target} =
%% 	case element(1, Record) of
%% 	    tab_destroy -> {"'destroy'", Record#tab_destroy.target};
%% 	    tab_disable ->
%% 		{"'disable'" ++
%% 		     case Record#tab_disable.tab of
%% 			 -1 -> "";
%% 			 Idx -> wf:f(", ~w", [Idx])
%% 		     end,
%% 		 Record#tab_disable.target};
%% 	    tab_enable ->
%% 		{"'enable'" ++
%% 		     case Record#tab_enable.tab of
%% 			 -1 -> "";
%% 			 Idx -> wf:f(", ~w", [Idx])
%% 		     end,
%% 		 Record#tab_enable.target};
%% 	    tab_option -> {wf:f("'option', '~s', ~s", [Record#tab_option.key, value_to_js(Record#tab_option.value)]),
%% 			   Record#tab_option.target};
%% 	    tab_add ->
%% 		{wf:f("'add', '~s', '~s'", [Record#tab_add.url, Record#tab_add.label])
%% 		 ++
%% 		     case Record#tab_add.index of
%% 			 undefined -> "";
%% 			 Idx -> wf:f(", ~w", [Idx])
%% 		     end,
%% 		 Record#tab_add.target};
%% 	    tab_remove -> {wf:f("'remove', ~w", [Record#tab_remove.tab]), Record#tab_remove.target};
%% 	    tab_select -> {wf:f("'select', ~w", [Record#tab_select.tab]), Record#tab_select.target};
%% 	    tab_load -> {wf:f("'load', ~w", [Record#tab_load.tab]), Record#tab_load.target};
%% 	    tab_url -> {wf:f("'url', ~w, '~s'", [Record#tab_url.tab, Record#tab_url.url]), Record#tab_url.target};
%% 	    tab_abort -> {"'abort'", Record#tab_abort.target};
%% 	    tab_rotate ->{wf:f("'rotate', ~w, ~s", [Record#tab_rotate.ms, Record#tab_rotate.continuing]), Record#tab_rotate.target}
%% 	end,
%%     wf:f("jQuery(obj('~s')).tabs(~s);",  [wf:to_js_id(Target), Script]).

render_action(#tab_destroy{target = Target}) ->
    wf:f("jQuery(obj('~s')).tabs('destroy');", [wf:to_js_id(Target)]);
render_action(#tab_disable{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('disable', '~s');", [wf:to_js_id(Target), Index]);
render_action(#tab_enable{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('enable;, '~s');", [wf:to_js_id(Target), Index]);
render_action(#tab_add{target = Target, url = Url, label = Label}) ->
    wf:f("jQuery(obj('~s')).tabs('add', '~s', '~s');", [wf:to_js_id(Target), Url, Label]);
render_action(#tab_remove{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('remove', '~s');", [wf:to_js_id(Target), Index]);
render_action(#tab_select{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('select', ~w);", [Target, Index]).


value_to_js(Value) when is_list(Value) ->
    wf:f("'~s'", [wf_utils:js_escape(Value)]);
value_to_js(Value) when Value == true; Value == false ->
    wf:f("~s", [Value]);
value_to_js(Value) when is_atom(Value) ->
    wf:f("'~s'", [Value]);
value_to_js(Value) -> wf:f("~p", [Value]).

