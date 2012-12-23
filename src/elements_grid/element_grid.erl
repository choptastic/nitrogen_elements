-module (element_grid).
-include ("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, grid).

render_element(#datagrid{id = ID} = Record) ->
    Id = wf:temp_id(),

    %% init jqGrid control with specified options
    Options = options_to_js(Record#datagrid.options),
    %%wf:wire(ID, wf:f("$(function(){$(obj('~s')).jqGrid(~s)})", [Id, Options])),
    %% wf:wire(ID, wf:f("$(function(){$('#grid_id').jqGrid(~s)})", [Options])),
    wf:wire(ID, wf:f("$(function(){$('~s').jqGrid(~s)})", [wf:f('#~s', [Id]), Options])),

    #panel{
	id = ID,
	body = [#table{html_id = Id, rows = [#tablerow{cells = []}]}]
    }.

%% tab_link(#tab{url = undefined, id = Id, title = Title}) when is_atom(Id) ->
%%     #link{url = "#" ++ wf:html_encode(atom_to_list(Id)), body = Title};
%% tab_link(#tab{url = undefined, id = Id, title = Title}) when is_list(Id) ->
%%     #link{url = "#" ++ wf:html_encode(Id), body = Title};
%% tab_link(#tab{url=Url, id=Id, title=Title}) ->
%%     #link{url=Url, title = wf:html_encode(Id), body=Title}.

%% event(Event) ->
%%     ?PRINT({tabsevent, Event}),
%%     EventType = wf:q(event),
%%     TabsID = wf:q(tabs_id),
%%     TabIndex = wf:q(index),
%%     Module = wf:page_module(),
%%     Module:tabs_event(list_to_atom(EventType), TabsID, TabIndex).

%% %% Options is a list of {Key,Value} tuples
%% options_to_js(Options) ->
%%     F = fun({Key, Value}, F1) ->
%%         if
%%             is_list(Value) andalso is_tuple(hd(Value)) ->
%%                 wf:f("~s: '~s'", [Key, F1(Value, F1)]);
%%             is_list(Value) ->
%%                 wf:f("~s: '~s'", [Key, wf:js_escape(Value)]);
%%             is_atom(Value) andalso (Value == true orelse Value == false) ->
%%                 wf:f("~s: ~s", [Key, Value]);
%%             is_atom(Value) ->
%%                 wf:f("~s: '~s'", [Key, Value]);
%%             true ->
%%                 wf:f("~s: ~p", [Key, Value])
%%         end
%%     end,
%%     Options1 = [F(X, F) || X <- Options],
%%     Options2 = string:join(Options1, ","),
%%     wf:f("{ ~s }", [Options2]).


parse(Value) when is_list(Value) ->
    Opts = [parse(X) || X <- Value],
    Opts1 = string:join(Opts, ", "),
    wf:f("~s", [Opts1]);
parse({Key, Value}) when is_list(Value) andalso is_tuple(hd(Value)) ->
    Opts = [parse(X) || X <- Value],
    Opts1 = string:join([wf:f("{~s}", [X]) || X <- Opts], ","),
    wf:f("~s: [ ~s ]", [Key, Opts1]);
parse({Key, Value}) when is_list(Value) andalso is_list(hd(Value)) ->
    Opts = [parse(X) || X <- Value],
    Opts1 = string:join([wf:f("{~s}", [X]) || X <- Opts], ","),
    wf:f("~s: [ ~s ]", [Key, Opts1]);
parse({Key, Value}) when is_list(Value) ->
    wf:f("~s: '~s'", [Key, wf:js_escape(Value)]);
parse({Key, Value}) when is_atom(Value) andalso (Value == true orelse Value == false) ->
    wf:f("~s: ~s", [Key, Value]);
parse({Key, Value}) when is_atom(Value) ->
    wf:f("~s: '~s'", [Key, Value]);
parse({Key, Value}) ->
    wf:f("~s: ~p", [Key, Value]).


options_to_js(Options) ->
    Options1 = [parse(X) || X <- Options],
    Options2 = string:join(Options1, ","),
    wf:f("{ ~s }", [Options2]).
