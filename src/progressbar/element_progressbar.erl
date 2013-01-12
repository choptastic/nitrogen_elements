% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(element_progressbar).
-include("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, progressbar).

render_element(Record) ->
    ID = Record#progressbar.id,
    HtmlID = wf:temp_id(),

    %% init jQuery progressbar control with specified options
    Options = action_jquery_effect:options_to_js(Record#progressbar.options),
    wf:wire(ID, wf:f("$(function(){jQuery(obj('~s')).progressbar(~s);
                          var evt = document.createEvent('Event');
                          evt.initEvent('~s', true, true);
                          document.dispatchEvent(evt);})", [ID, Options, ?EVENT_PROGRESSBAR_INIT_COMPLETED])),

    %% create html markup
    #panel{id = ID, html_id = HtmlID, style = Record#progressbar.style, class = Record#progressbar.class}.

event(Event) ->
    ?PRINT({progressbar_event, Event}),
    Module = wf:page_module(),
    Module:event(Event).
