%% -*- coding: utf-8 -*-

%% @copyright 2013 Roman Shestakov
%% @author Roman Shestakov <romanshestakov@yahoo.co.uk>
%% See MIT-LICENSE for licensing information.

%% @doc Nitrogen Elements
%% This is a <em>very</em> useful module. It is ...
%% @end

-module(element_viz).

-include ("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, viz).

render_element(Record) ->
    ID = Record#viz.id,

    %% get data, should be binary string in dot format
    Data = Record#viz.data,

    %% generate graph html and append to panel placeholder
    wf:wire(ID, wf:f("$(function(){jQuery(obj('~s')).html(Viz('~s', \"svg\"));})", [ID, Data])),

    %% add jquery.graphviz
    wf:wire(ID, wf:f("$(function(){jQuery(obj('~s')).find(\"svg\").graphviz({status: true});})", [ID])),

    %% create html markup
    #panel{id = ID}.

%% not used yet
event(Event) ->
    ?PRINT({viz_event, Event}),
    Module = wf:page_module(),
    Module:event(Event).
