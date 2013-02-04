% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(progressbar.action_progressbar).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(PROGRESSBAR_ELEMENT, #progressbar{}).

render_action(#progressbar_value{target = Target, value = Value}) ->
    wf:f("jQuery(obj('~s')).progressbar({value : ~w});", [Target, Value]);
render_action(#progressbar_disable{target = Target}) ->
    wf:f("jQuery(obj('~s')).progressbar({disabled, true);", [Target]);
render_action(#progressbar_enable{target = Target}) ->
    wf:f("jQuery(obj('~s')).progressbar({disabled, false);", [Target]);
render_action(#progressbar_event_on{target = Target, event = Event, postback = Postback}) ->
    #event{type = Event, postback = Postback, delegate = ?PROGRESSBAR_ELEMENT#progressbar.module};
render_action(#progressbar_event_off{target = Target, event = Event}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Event]).
