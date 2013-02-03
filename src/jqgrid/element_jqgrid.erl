% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

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
    Options = common:options_to_js(Record1#jqgrid.options),

    %% there is a problem with the order of execution of javascript which Nitrogen generates.
    %% e.g. you might have an event that you want to wire during creation of the custom element
    %% it might be a call to jQuery function which actully builds the element.
    %% and you also might want to wire another event to the instance of your custom element
    %% the second event should only be fired when custom element is fully built.
    %% the problem is Nitrogen might output javascript for your events in the wrong order, so
    %% your *second* event gets fired *before* your first event which builds control is executed.
    %% the only way around this problem I can think of is to use custom events to control the order
    %% of execution.

    %% create grid
    wf:wire(ID, wf:f("$(function(){$(obj('~s')).jqGrid(~s);})", [ID, Options])),
    %% fire jquery custom event to mark the completion of jsgrid init
    wf:wire(ID, wf:f("$(obj('~s')).trigger('jqgrid_init')", [ID])),

    #panel{body = [
	#table{html_id = TableHtmlID, id = ID, rows = [#tablerow{cells = []}]},
	#panel{html_id = PagerID}
    ]}.

event({?ONSELECTROW, Postback}) ->
    ?PRINT({jqgrid_event, ?ONSELECTROW}),
    RowId = wf:q(rowid),
    Status = wf:q(status),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, Status}});
event({?ONCELLSELECT, Postback}) ->
    ?PRINT({jqgrid_event, ?ONCELLSELECT}),
    RowId = wf:q(rowid),
    ICol = wf:q(iCol),
    Cellcontent = wf:q(cellcontent),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, ICol, Cellcontent}}).
%% event(Event) ->
%%     ?PRINT({jqgrid_event_elem, Event}),
%%     %% RowId = wf:q(rowid),
%%     %% ICol = wf:q(iCol),
%%     %% Cellcontent = wf:q(cellcontent),
%%     Module = wf:page_module(),
%%     Module:event(Event).

