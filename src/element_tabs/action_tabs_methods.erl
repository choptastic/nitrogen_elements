% Nitrogen Elements
% Copyright (c) 2009 Andreas Stenius
% Contributions from Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_tabs_methods).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(TABS_ELEMENT, #tabs{}).

%% define a macro to attach action to event listener to make sure
%% the event is run only after tabs has been initialized
-define(TAB_EVENT_HOOK(EventName, Target, Func),
	wf:f("(function(){
                  // if tabs has been initiated
                  if($(obj('~s')).is(':data(tabs)'))
                    ~s
                  // otherwise, add event listener
                  else {
                   function eventHandler(e){ ~s };
                   document.addEventListener('~s', eventHandler, false)}})();",
	     [Target, Func, Func, EventName])).

render_action(#tab_destroy{target = Target}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('destroy');", [wf:to_js_id(Target)]));
render_action(#tab_disable{target = Target, tab = Index}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('disable', '~s');",
							     [wf:to_js_id(Target), Index]));
render_action(#tab_enable{target = Target, tab = Index}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target,	wf:f("jQuery(obj('~s')).tabs('enable', '~s');",
							     [wf:to_js_id(Target), Index]));
render_action(#tab_add{target = Target, url = Url, label = Label}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('add', '~s', '~s');",
							     [wf:to_js_id(Target), Url, Label]));
render_action(#tab_remove{target = Target, tab = Index}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('remove', '~s');",
							     [wf:to_js_id(Target), Index]));
render_action(#tab_select{target = Target, tab = Index}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('select', ~w);", [Target, Index]));
render_action(#tab_load{target = Target, tab = Index}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('load', ~w);", [Target, Index]));
render_action(#tab_url{target = Target, tab = Index, url = Url}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target,	wf:f("jQuery(obj('~s')).tabs('load', ~w, '~s' );", [Target, Index, Url]));
render_action(#tab_abort{target = Target}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('abort');", [Target]));
render_action(#tab_rotate{target = Target, ms = Ms, continuing = IsContinuing}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('rotate', ~w, ~s);",
							     [Target, Ms, IsContinuing]));
render_action(#tab_event_off{target = Target, event = Event}) ->
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Event]));
render_action(#tab_event_on{target = Target, event = Event}) ->
    PickledPostbackInfo = wf_event:serialize_event_context(Event, Target, Target, ?TABS_ELEMENT#tabs.module),
    ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).bind('~s', function(e, ui) {
           Nitrogen.$queue_event('~s','~s',\"event=\" + e.type + \"&tabs_id=\" + '~s' + \"&index=\" + ui.index)})",
						[Target, Event, Target, PickledPostbackInfo, Target])).
