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

    %% add extra options
    Record1 = Record#jqgrid{options = [{pager, list_to_binary(wf:f('#~s', [PagerID]))}|GridOptions]},
    %% init jqGrid control with specified options
    Options = options_to_js(Record1#jqgrid.options),

    %% there is a problem with the order of execution of javascript which Nitrogen generates.
    %% e.g. you might have an event that you want to wire during creation of the custom element
    %% it might be a call to jQuery function which actully builds the element.
    %% and you also might want to wire another event to the instance of your custom element
    %% the second event should only be fired when custom element is fully built.
    %% the problem is Nitrogen might output javascript for your events in the wrong order, so
    %% your *second* event gets fired *before* your first event which builds control is executed.
    %% the only way around this problem I can think of is to use custom events to control the order
    %% of execution.
    wf:wire(ID, wf:f("$(function(){$(obj('~s')).jqGrid(~s);var evt = document.createEvent('Event');
                      evt.initEvent(\"myEvent\", true, true);document.dispatchEvent(evt);})", [ID, Options])),

    #panel{body = [
	#table{html_id = TableHtmlID, id = ID, rows = [#tablerow{cells = []}]},
	#panel{html_id = PagerID}
    ]}.

event(EventType) ->
    %% ?PRINT({jqgrid_event, EventType}),
    RowId = wf:q(id),
    Module = wf:page_module(),
    Module:jqgrid_event(EventType, RowId).

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
