% Nitrogen Elements
% Copyright (c) Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_ajax_load).
-include("nitrogen_elements.hrl").
-compile(export_all).

%% -define(TABS_ELEMENT, #tabs{}).

render_action(#ajax_load{target = Target, url = Url}) ->
    wf:f("jQuery(obj('~s')).load('~s');", [Target, Url]).
