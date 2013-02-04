% Nitrogen Elements
% Copyright (c) Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(menubar.action_menubar).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(MENU_ELEMENT, #menubar{}).

render_action(#menubar_event_off{target = Target, type = Type}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Type]);
render_action(#menubar_event_on{target = Target, type = Type, postback = Postback}) ->
    #event{type = Type, postback = Postback, delegate = ?MENU_ELEMENT#menubar.module}.
