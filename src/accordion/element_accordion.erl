% Nitrogen Elements
% Copyright (c) 2009 Andreas Stenius
% Contributions from Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module (element_accordion).
-include ("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, accordion).

render_element(Record) ->
    ID = Record#accordion.id,
    %% init jQuery tabs control with specified options
    Options = common:options_to_js(Record#accordion.options),
    wf:wire(ID, wf:f("$(function(){jQuery(obj('~s')).accordion(~s);})", [ID, Options])),
    %% create html markup
    #panel{
	id = ID,
	body = [
	    [ [ #h3 { text = Panel#panel.text }, #panel{ body = Panel#panel.body } ] || Panel <- Record#accordion.body ]
	]}.

event(Event) ->
    Module = wf:page_module(),
    Module:event(Event).
