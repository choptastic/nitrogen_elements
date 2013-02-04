% Nitrogen Elements
% Copyright (c) Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(menu.action_menu).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(MENU_ELEMENT, #menu{}).

render_action(#menu_blur{target = Target}) ->
    wf:f("jQuery(obj('~s')).manu('blur');", [Target]);
render_action(#menu_option{target = Target, key = undefined, value = undefined, postback = Postback}) ->
    ExtraParam = wf:f("(function(){var opt = jQuery(obj('~s')).menu(\"option\");
                       return \"options=\" + jQuery.param(opt);})()", [Target]),
    #event{postback = Postback, delegate = ?MENU_ELEMENT#menu.module, extra_param = ExtraParam};
render_action(#menu_option{target = Target, key = Key, value = undefined, postback = Postback}) ->
    ExtraParam = wf:f("\"~s=\"+jQuery(obj('~s')).menu(\"option\", \"~w\")", [Key, Target, Key]),
    #event{postback = Postback, delegate = ?MENU_ELEMENT#menu.module, extra_param = ExtraParam};
render_action(#menu_event_off{target = Target, type = Type}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Type]);
render_action(#menu_event_on{target = Target, type = Type, postback = Postback}) ->
    #event{target = Target, type = Type, postback = Postback, delegate = ?MENU_ELEMENT#menu.module}.
