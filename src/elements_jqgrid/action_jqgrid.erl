-module(action_jqgrid).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(JQGRID_ELEMENT, #jqgrid{}).

%% $('#list').jqGrid('setGridParam', { onSelectRow: function(id){ alert(id); } } );
render_action(#jqgrid_event{type = 'onSelectRow', target = Target}) ->
    %% PickledPostbackInfo = wf_event:serialize_event_context('onSelectRow', Target, Target, ?JQGRID_ELEMENT#jqgrid.module),
    wf:f("document.addEventListener(\"myEvent\", eventHandler, false);
         function eventHandler(e){
           jQuery(obj('~s')).jqGrid('setGridParam', { onSelectRow: function(id) {alert(id);}});}", [Target]).

%% render_action(#jqgrid_event{type = 'onSelectRow', target = Target}) ->
%%     %% PickledPostbackInfo = wf_event:serialize_event_context('onSelectRow', Target, Target, ?JQGRID_ELEMENT#jqgrid.module),
%%     wf:f("jQuery(obj('~s')).jqGrid('setGridParam', { onSelectRow: function(id) {alert(id);}})", [Target]).


%% render_action(#jqgrid_event{type = 'onSelectRow', target = Target}) ->
%%     PickledPostbackInfo = wf_event:serialize_event_context('onSelectRow', Target, Target, ?JQGRID_ELEMENT#jqgrid.module),
%%     wf:f("jQuery(obj('~s')).jqGrid('setGridParam', { onSelectRow: function(id) {
%%            Nitrogen.$queue_event('~s', '~s', \"&id=\" + id); } } )", [Target, Target, PickledPostbackInfo]).
