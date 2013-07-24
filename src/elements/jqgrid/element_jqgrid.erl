% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module (element_jqgrid).
-include ("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).
-compile([{parse_transform, lager_transform}]).


reflect() -> record_info(fields, jqgrid).

render_element(#jqgrid{options = GridOptions} = Record) ->
    %% define IDs, jqGrid depends on html_ids
    ID = Record#jqgrid.id,
    TableHtmlID = "grid_html_id_" ++ wf:temp_id(),
    PagerID = "pager_html_id_" ++ wf:temp_id(),

    %% add extra options
    Record1 = Record#jqgrid{options = [{pager, list_to_binary(wf:f('#~s', [PagerID]))} | GridOptions]},
   
    %% init jqGrid control with specified options
%%      io:format("Record1#jqgrid.options:~p~n",[Record1#jqgrid.options]),    
    Options = common:options_to_js(Record1#jqgrid.options),
    FilterOptions = common:options_to_js(Record1#jqgrid.filter_options),
%%     io:format("Options:~p~n",[Options]),
%%         io:format("FilterOptions:~p~n",[FilterOptions]),
    %% create grid
jQuery("#gridid").jqGrid(
    case Record1#jqgrid.filter_toolbar of
        true ->
            wf:wire(ID, wf:f("$(function(){$(obj('~s')).jqGrid(~s); $('~s').jqGrid('filterToolbar', ~s);})", [ID, Options,ID,FilterOptions]));
        _ -> 
            wf:wire(ID, wf:f("$(function(){$(obj('~s')).jqGrid(~s);  })", [ID, Options]))
    end,
    
    %% output html markup
    #panel{body = [
	#table{html_id = TableHtmlID, id = ID, rows = [#tablerow{cells = []}]},
	#panel{html_id = PagerID}
    ]}.

event({?BEFORESELECTROW, Postback}) ->
    RowId = wf:q(rowid),
    Event = wf:q(event),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, Event}});
event({?ONSELECTROW, Postback}) ->
    RowId = wf:q(rowid),
    Status = wf:q(status),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, Status}});
event({?ONCELLSELECT, Postback}) ->
    RowId = wf:q(rowid),
    ICol = wf:q(iCol),
    Cellcontent = wf:q(cellcontent),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, ICol, Cellcontent}});
event({?AFTERINSERTROW, Postback}) ->
    RowId = wf:q(rowid),
    Rowdata = wf:q(rowdata),
    Rowelem = wf:q(rowelem),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, Rowdata, Rowelem}});
event({?BEFOREREQUEST, Postback}) ->
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {}});
event({?ONDBLCLICKROW, Postback}) ->
    RowId = wf:q(rowid),
    IRow = wf:q(iRow),
    ICol = wf:q(iCol),
    lager:debug("wf:q(rowid):~p",[wf:q(rowid)]),
    lager:debug("wf:q(iRow):~p",[wf:q(iRow)]),
    lager:debug("wf:q(iCol):~p",[wf:q(iCol)]),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, IRow, ICol}});
event({?ONRIGHTCLICKROW, Postback}) ->
    RowId = wf:q(rowid),
    IRow = wf:q(iRow),
    ICol = wf:q(iCol),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, IRow, ICol}});
event({?ONHEADERCLICK, Postback}) ->
    Gridstate = wf:q(gridstate),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Gridstate}});
event({?ONLOADCOMPLETE, Postback}) ->
    Data = wf:q(data),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Data}});
event({?ONPAGESIZECHANGE, Postback}) ->
    Page = wf:q(page),
    Total = wf:q(total),
    Records = wf:q(records),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Page, Total, Records}});
event({?BEFOREPROCESSING, Postback}) ->
    Data = wf:q(data),
    Status = wf:q(status),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Data, Status}});
event(Event) ->
    ?PRINT({jqgrid_event, Event}),
    Module = wf:page_module(),
    Module:jqgrid_event({Event, {}}).
