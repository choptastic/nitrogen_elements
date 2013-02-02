% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_jqgrid).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(JQGRID_ELEMENT, #jqgrid{}).

%% render_action(#jqgrid_event{type = ?ONCELLSELECT, event_name=EventName, target = Target}) ->
%%     PickledPostbackInfo = wf_event:serialize_event_context(?ONCELLSELECT, Target, Target, ?JQGRID_ELEMENT#jqgrid.module),
%%     wf:f("document.addEventListener('~s', function(e) {
%%               jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, iCol, cellcontent, e) {
%%               Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&iCol=\" + iCol +
%%               \"&cellcontent=\" + cellcontent);}})}, false)",
%% 	 [EventName, Target, ?ONSELECTROW, Target, PickledPostbackInfo]);
%% render_action(#jqgrid_event{type = ?ONSELECTROW, event_name=EventName, target = Target}) ->
%%     PickledPostbackInfo = wf_event:serialize_event_context(?ONSELECTROW, Target, Target, ?JQGRID_ELEMENT#jqgrid.module),
%%     wf:f("document.addEventListener('~s', function(e) {
%%               jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, status, e) {
%%               Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&status=\" + status);}})}, false)",
%% 	 [EventName, Target, ?ONSELECTROW, Target, PickledPostbackInfo]).

render_action(#jqgrid_event{trigger = Trigger, target = Target, type = ?ONSELECTROW}) ->
    PickledPostbackInfo = wf_event:serialize_event_context(?ONSELECTROW, Target, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'custom', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, status, e) {
              Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&status=\" + status);}})",
	 [Target, ?ONSELECTROW, Target, PickledPostbackInfo])}.

%% render_action(#jqgrid_event{type = Type, target = Target, postback = Postback}) ->
%%     #event{target = Target, type = Type, postback = Postback, delegate = ?JQGRID_ELEMENT#jqgrid.module}.
