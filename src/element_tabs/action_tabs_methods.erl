% Nitrogen Elements
% Copyright (c) 2009 Andreas Stenius
% Contributions from Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_tabs_methods).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(TABS_ELEMENT, #tabs{}).

render_action(#tab_destroy{target = Target}) ->
    wf:f("jQuery(obj('~s')).tabs('destroy');", [Target]);
render_action(#tab_disable{target = Target, tab = undefined}) ->
    wf:f("jQuery(obj('~s')).tabs('disable');", [Target]);
render_action(#tab_disable{target = Target, tab = Index}) when is_integer(Index) ->
    wf:f("jQuery(obj('~s')).tabs('disable', ~w);", [Target, Index]);
render_action(#tab_disable{target = Target, tab = Indexes}) when is_list(Indexes) ->
    wf:f("jQuery(obj('~s')).tabs(\"option\", \"disabled\", ~w);", [Target, Indexes]);
render_action(#tab_enable{target = Target}) ->
    wf:f("jQuery(obj('~s')).tabs('enable');", [Target]);
render_action(#tab_remove{target = Target, tab = Index}) ->
    wf:f("(function(){var tab = jQuery(obj('~s')).find(\".ui-tabs-nav li:eq(~w)\").remove();
           var panelId = tab.attr(\"aria-controls\");
           $(\"#\" + panelId).remove();
           jQuery(obj('~s')).tabs( \"refresh\");})();", [Target, Index, Target]);
render_action(#tab_add{target = Target, url = Url, title = Title}) ->
    wf:f("(function(){$(\"<li><a href='~s'> ~s </a></li>\").appendTo(jQuery(obj(\"~s .ui-tabs-nav\")));
           jQuery(obj('~s')).tabs( \"refresh\");})();", [Url, Title, Target, Target]);
render_action(#tab_select{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs(\"option\", \"active\", ~w);", [Target, Index]);
render_action(#tab_option{target = Target, key = Key, value = undefined}) ->
    PickledPostbackInfo = wf_event:serialize_event_context('option', Target, Target, ?TABS_ELEMENT#tabs.module),
    ExtraParam = wf:f("\"option=\"+jQuery(obj('~s')).tabs(\"option\", \"~w\")", [Target, Key]),
    wf:f("Nitrogen.$queue_event('~s', '~s', ~s);", [Target, PickledPostbackInfo, ExtraParam]);
render_action(#tab_option{target = Target}) ->
    PickledPostbackInfo = wf_event:serialize_event_context('option', Target, Target, ?TABS_ELEMENT#tabs.module),
    ExtraParam = wf:f("\"option=\"+jQuery(obj('~s')).tabs(\"option\")", [Target]),
    wf:f("Nitrogen.$queue_event('~s', '~s', ~s);", [Target, PickledPostbackInfo, ExtraParam]);

%% render_action(#tab_load{target = Target, tab = Index}) ->
%%     ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('load', ~w);", [Target, Index]));
%% render_action(#tab_url{target = Target, tab = Index, url = Url}) ->
%%     ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target,	wf:f("jQuery(obj('~s')).tabs('load', ~w, '~s' );", [Target, Index, Url]));
%% render_action(#tab_abort{target = Target}) ->
%%     ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('abort');", [Target]));
%% render_action(#tab_rotate{target = Target, ms = Ms, continuing = IsContinuing}) ->
%%     ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('rotate', ~w, ~s);",
%% 							     [Target, Ms, IsContinuing]));
render_action(#tab_event_off{target = Target, type = Type}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Type]);
render_action(#tab_event_on{target = Target, type = Type, postback = Postback}) ->
    #event{type = Type, postback = Postback, delegate = ?TABS_ELEMENT#tabs.module}.

%% render_action(#tab_event_on{target = Target, event = Event}) ->
%%     PickledPostbackInfo = wf_event:serialize_event_context(Event, Target, Target, ?TABS_ELEMENT#tabs.module),
%%     ?EVENT_LISTENER(?EVENT_TABS_INIT_COMPLETED, wf:f("jQuery(obj('~s')).bind('~s', function(e, ui) {
%%            Nitrogen.$queue_event('~s','~s',\"event=\" + e.type + \"&tabs_id=\" + '~s' + \"&index=\" + ui.index)})",
%% 						[Target, Event, Target, PickledPostbackInfo, Target])).

%% generate_postback_script(undefined, _Anchor, _ValidationGroup, _Delegate, _ExtraParam) -> [];
%% generate_postback_script(Postback, Anchor, ValidationGroup, Delegate, ExtraParam) ->
%%     PickledPostbackInfo = serialize_event_context(Postback, Anchor, ValidationGroup, Delegate),
%%     wf:f("Nitrogen.$queue_event('~s', '~s', ~s);", [ValidationGroup, PickledPostbackInfo, ExtraParam]).
