% Nitrogen Elements
% Copyright (c) Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_tabs).
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
render_action(#tab_option{target = Target, key = undefined, value = undefined, postback = Postback}) ->
    ExtraParam = wf:f("(function(){var opt = jQuery(obj('~s')).tabs(\"option\");
                       return \"options=\" + jQuery.param(opt);})()", [Target]),
    #event{postback = Postback, delegate = ?TABS_ELEMENT#tabs.module, extra_param = ExtraParam};
render_action(#tab_option{target = Target, key = Key, value = undefined, postback = Postback}) ->
    ExtraParam = wf:f("\"~s=\"+jQuery(obj('~s')).tabs(\"option\", \"~w\")", [Key, Target, Key]),
    #event{postback = Postback, delegate = ?TABS_ELEMENT#tabs.module, extra_param = ExtraParam};
render_action(#tab_event_off{target = Target, type = Type}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Type]);
render_action(#tab_event_on{target = Target, type = Type, postback = Postback}) ->
    #event{target = Target, type = Type, postback = Postback, delegate = ?TABS_ELEMENT#tabs.module}.
    %% #event{type = Type, postback = Postback, delegate = ?TABS_ELEMENT#tabs.module, extra_param = "\"index=\" + arguments[1]"}.
