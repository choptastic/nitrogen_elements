% Nitrogen Web Framework for Erlang
% Copyright (c) 2009 Andreas Stenius
% See MIT-LICENSE for licensing information.

-module(action_tabs_methods).
-include("nitrogen_elements.hrl").
-compile(export_all).

render_action(#tab_destroy{target = Target}) ->
    wf:f("jQuery(obj('~s')).tabs('destroy');", [wf:to_js_id(Target)]);
render_action(#tab_disable{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('disable', '~s');", [wf:to_js_id(Target), Index]);
render_action(#tab_enable{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('enable;, '~s');", [wf:to_js_id(Target), Index]);
render_action(#tab_add{target = Target, url = Url, label = Label}) ->
    wf:f("jQuery(obj('~s')).tabs('add', '~s', '~s');", [wf:to_js_id(Target), Url, Label]);
render_action(#tab_remove{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('remove', '~s');", [wf:to_js_id(Target), Index]);
render_action(#tab_select{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('select', ~w);", [Target, Index]);
render_action(#tab_load{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs('load', ~w);", [Target, Index]);
render_action(#tab_url{target = Target, tab = Index, url = Url}) ->
    wf:f("jQuery(obj('~s')).tabs('load', ~w, '~s' );", [Target, Index, Url]);
render_action(#tab_abort{target = Target}) ->
    wf:f("jQuery(obj('~s')).tabs('abort');", [Target]);
render_action(#tab_rotate{target = Target, ms = Ms, continuing = IsContinuing}) ->
    wf:f("jQuery(obj('~s')).tabs('rotate', ~w, ~s);", [Target, Ms, IsContinuing]);
render_action(#tab_event_off{target = Target, event = Event}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Event]);
render_action(#tab_event_on{target = Target, event = Event}) ->
    PickledPostbackInfo = wf_event:serialize_event_context(tabsevent, Target, Target, 'element_tabs'),
    wf:f("jQuery(obj('~s')).bind('~s', function(e, ui) {
           Nitrogen.$queue_event('~s','~s',\"event=\" + e.type + \"&tabs_id=\" + '~s' + \"&index=\" + ui.index)})",
	 [Target, Event, Target, PickledPostbackInfo, Target]).
