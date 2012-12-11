% Nitrogen Web Framework for Erlang
% Copyright (c) 2009 Andreas Stenius
% See MIT-LICENSE for licensing information.

-module (element_tabs).
-include ("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, tabs).

render_element(Record) ->
    TabsID =
	case Record#tabs.id of
	    undefined -> wf:temp_id();
	    Other -> Other
	end,

    %% init jQuery tabs control with specified options
    Options = action_jquery_effect:options_to_js(Record#tabs.options),
    wf:wire(TabsID, wf:f("jQuery(obj('~s')).tabs(~s)", [TabsID, Options])),

    #panel{
	id = TabsID,
	body = [
	    #list{
		class = wf:to_list(Record#tabs.class),
		body = [#listitem{body = tab_link(Tab)} || Tab <- Record#tabs.tabs]
	    },
	    [#panel{html_id = Tab#tab.id, body = Tab#tab.body} || Tab <- Record#tabs.tabs, Tab#tab.url =:= undefined]
	]
    }.

tab_link(#tab{url = undefined, id = Id, title = Title}) when is_atom(Id) ->
    #link{url = "#" ++ wf:html_encode(atom_to_list(Id)), body = Title};
tab_link(#tab{url = undefined, id = Id, title = Title}) when is_list(Id) ->
    #link{url = "#" ++ wf:html_encode(Id), body = Title};
tab_link(#tab{url=Url, id=Id, title=Title}) ->
    #link{url=Url, title = wf:html_encode(Id), body=Title}.

event(Event) ->
    ?PRINT({tabsevent, Event}),
    EventType = wf:q(event),
    TabsID = wf:q(tabs_id),
    TabIndex = wf:q(index),
    Module = wf:page_module(),
    Module:tabs_event(list_to_atom(EventType), TabsID, TabIndex).
