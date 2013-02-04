% Nitrogen Elements
% Copyright (c) Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(accordion.action_accordion).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(ACCORDION_ELEMENT, #accordion{}).

render_action(#accordion_destroy{target = Target}) ->
    wf:f("jQuery(obj('~s')).accordion('destroy');", [Target]);
render_action(#accordion_disable{target = Target}) ->
    wf:f("jQuery(obj('~s')).accordion(\"disable\");", [Target]);
render_action(#accordion_enable{target = Target}) ->
    wf:f("jQuery(obj('~s')).accordion('enable');", [Target]);
render_action(#accordion_event_off{target = Target, type = Type}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Type]);
render_action(#accordion_event_on{target = Target, type = Type, postback = Postback}) ->
    #event{target = Target, type = Type, postback = Postback, delegate = ?ACCORDION_ELEMENT#accordion.module}.
