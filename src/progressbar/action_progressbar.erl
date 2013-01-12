% Nitrogen Elements Examples
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_progressbar).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(PROGRESSBAR_ELEMENT, #progressbar{}).

%% define a macro to attach action to event listener to make sure
%% the event is run only after tabs has been initialized
-define(PROGRESSBAR_EVENT_HOOK(EventName, Target, Func),
	wf:f("(function(){
                  if($(obj('~s')).is(':data(progressbar)'))
                    ~s
                  else {
                   function eventHandler(e){ ~s };
                   document.addEventListener('~s', eventHandler, false)}})();",
	     [Target, Func, Func, EventName])).

render_action(#progressbar_value{target = Target, value = Value}) ->
    ?PRINT({target, Target, Value}),
    wf:f("jQuery(obj('~s')).progressbar({value : ~w});", [Target, Value]);
render_action(#progressbar_disable{target = Target}) ->
    wf:f("jQuery(obj('~s')).progressbar({disabled, true);", [Target]);
render_action(#progressbar_enable{target = Target}) ->
    wf:f("jQuery(obj('~s')).progressbar({disabled, false);", [Target]);
render_action(#progressbar_event_on{target = Target, event = Event, postback = Postback}) ->
    PickledPostbackInfo = wf_event:serialize_event_context(Postback, Target, Target, ?PROGRESSBAR_ELEMENT#progressbar.module),
    ?PROGRESSBAR_EVENT_HOOK(?EVENT_PROGRESSBAR_INIT_COMPLETED, Target, wf:f("jQuery(obj('~s')).bind(\"~s\", function(e, ui) {
           Nitrogen.$queue_event('~s', '~s')});", [Target, Event, Target, PickledPostbackInfo]));
render_action(#progressbar_event_off{target = Target, event = Event}) ->
    wf:f("jQuery(obj('~s')).unbind('~s');", [Target, Event]).
