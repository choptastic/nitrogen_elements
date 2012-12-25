-module (element_jqgrid).
-include ("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, jqgrid).

render_element(#jqgrid{options = GridOptions} = Record) ->
    %% define IDs, jqGrid depends on html_ids
    ID = Record#jqgrid.id,
    TableHtmlID = "grid_html_id_" ++ wf:temp_id(),
    PagerID = "pager_html_id_" ++ wf:temp_id(),

    %% ?PRINT({html_id, Record#datagrid.anchor}),

    %% add extra options
    Record1 = Record#jqgrid{options = [{pager, list_to_binary(wf:f('#~s', [PagerID]))}|GridOptions]},
    %% init jqGrid control with specified options
    Options = options_to_js(Record1#jqgrid.options),
    wf:wire(ID, wf:f("$(function(){$(obj('~s')).jqGrid(~s)})", [ID, Options])),
    #panel{body = [
	#table{html_id = TableHtmlID, id = ID, rows = [#tablerow{cells = []}]},
	#panel{html_id = PagerID}
    ]}.

%% event(Event) ->
%%     ?PRINT({tabsevent, Event}),
%%     EventType = wf:q(event),
%%     TabsID = wf:q(tabs_id),
%%     TabIndex = wf:q(index),
%%     Module = wf:page_module(),
%%     Module:tabs_event(list_to_atom(EventType), TabsID, TabIndex).

options_to_js(Options) ->
    wf:f("{ ~s }", [string:join([parse(X) || X <- Options], ",")]).

parse({Key, Value}) when is_list(Value) andalso is_tuple(hd(Value)) ->
    Opts = string:join([wf:f("{~s}", [X]) || X <- [parse(X) || X <- Value]], ","),
    wf:f("~s: [ ~s ]", [Key, Opts]);
parse({Key, Value}) when is_list(Value) andalso is_list(hd(Value)) ->
    Opts = string:join([wf:f("{~s}", [X]) || X <- [parse(X) || X <- Value]], ","),
    wf:f("~s: [ ~s ]", [Key, Opts]);
parse({Key, Value}) when is_list(Value) ->
    Opts = string:join([parse(X) || X <- Value], ","),
    wf:f("~s: [ ~s ]", [Key, Opts]);
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
parse(Value) when is_atom(Value) ->
    wf:f("'~s'", [Value]);
parse(Value) when is_binary(Value) ->
    wf:f("'~s'", [wf:js_escape(binary_to_list(Value))]).
