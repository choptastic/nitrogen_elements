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
    %% ?PRINT({hit_tabs_event, disable_some_tabs}),
    wf:f("jQuery(obj('~s')).tabs(\"option\", \"disabled\", ~w);", [Target, Indexes]);
render_action(#tab_enable{target = Target}) ->
    wf:f("jQuery(obj('~s')).tabs('enable');", [Target]);

%% render_action(#tab_enable{target = Target, tab = Index}) ->
%%     wf:f("jQuery(obj('~s')).tabs('enable', '~s');", [Target, Index]));

%% render_action(#tab_add{target = Target, url = Url, label = Label}) ->
%%     ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('add', '~s', '~s');",
%% 							     [wf:to_js_id(Target), Url, Label]));
%% render_action(#tab_remove{target = Target, tab = Index}) ->
%%     ?TAB_EVENT_HOOK(?EVENT_TABS_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).tabs('remove', '~s');",
%% 							     [wf:to_js_id(Target), Index]));
render_action(#tab_select{target = Target, tab = Index}) ->
    wf:f("jQuery(obj('~s')).tabs(\"option\", \"active\", ~w);", [Target, Index]);
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
