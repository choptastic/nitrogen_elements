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
    %% Options = action_jquery_effect:options_to_js(Record#tabs.options),
    %% wf:wire(TabsID, wf:f("jQuery(obj('~s')).tabs(~s)", [TabsID, Options])),

    wf:wire(wf:f("$(function() {
	var tabs = jQuery(obj('~s')),
	tab_a_selector = 'ul.ui-tabs-nav a';
	tabs.tabs({ event: 'change' });
	tabs.find( tab_a_selector ).click(function(){
	var state = {},
	id = $(this).closest( '~s' ).attr( 'id' ),
	idx = $(this).parent().prevAll().length;
	state[ id ] = idx;
	$.bbq.pushState( state );
	});
	$(window).bind( 'hashchange', function(e) {
	tabs.each(function() {
	var idx = $.bbq.getState(this.id, true) || 0;
	$(this).find( tab_a_selector ).eq(idx).triggerHandler( 'change' );
        }); })
	$(window).trigger( 'hashchange' ); })",
	[TabsID, TabsID])),

    %% %% wire standard tabs events to the element, instance of tabs element needs to be tagged to receive events
    %% case Record#tabs.tag of
    %% 	underfined -> skip;
    %% 	TabsTag ->
    %% 	    PickledPostbackInfo = wf_event:serialize_event_context(tabsevent, TabsID, TabsID, ?MODULE),
    %% 	    [wf:wire(TabsID, wf:f("jQuery(obj('~s')).bind('~s', function(e, ui) {
    %% 		Nitrogen.$queue_event('~s','~s',\"event=\" + e.type + \"&tabs_tag=\" + '~s' + \"&tab=\" + ui.tab + \
    %% 		\"&panel=\" + ui.panel + \"&index=\" + ui.index)})",
    %% 		[TabsID, Event, TabsID, PickledPostbackInfo, TabsTag])) ||
    %% 		Event <- ['tabsselect', 'tabsload', 'tabsshow', 'tabsadd', 'tabsremove', 'tabsenable', 'tabsdisable']]
    %% end,

                %% window.location.href = window.location.protocol + '//' + window.location.hostname + \
                %% window.location.pathname + ui.tab.hash;


    %% %% wire standard tabs events to the element, instance of tabs element needs to be tagged to receive events
    %% case Record#tabs.tag of
    %% 	underfined -> skip;
    %% 	TabsTag ->
    %% 	    PickledPostbackInfo = wf_event:serialize_event_context(tabsevent, TabsID, TabsID, ?MODULE),
    %% 	    wf:wire(TabsID, wf:f("jQuery(obj('~s')).bind('~s', function(e, ui) { \
    %%             window.location.href = window.location.protocol + '//' + window.location.hostname + \
    %%             window.location.pathname + ui.tab.hash;
    %% 		Nitrogen.$queue_event('~s','~s',\"event=\" + e.type + \"&tabs_tag=\" + '~s' + \"&tab=\" + ui.tab + \
    %% 		\"&panel=\" + ui.panel + \"&index=\" + ui.index)})",
    %% 		[TabsID, 'tabselect', TabsID, PickledPostbackInfo, TabsTag]))
    %% 		%Event <- ['tabsselect', 'tabsload', 'tabsshow', 'tabsadd', 'tabsremove', 'tabsenable', 'tabsdisable']]
    %% end,

    #panel{
	id = TabsID,
	html_id = "tabs1",
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
    ?PRINT({tabsevent, Event}).
    %% EventType = wf:q(event),
    %% TabsTag = wf:q(tabs_tag),
    %% TabAnchor = wf:q(tab),
    %% TabPanel = wf:q(panel),
    %% TabIndex = wf:q(index),
    %% Module = wf:page_module(),
    %% Module:tabs_event(EventType, TabsTag, TabAnchor, TabPanel, TabIndex).
