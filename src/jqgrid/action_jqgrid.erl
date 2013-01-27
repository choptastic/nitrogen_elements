% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_jqgrid).
-include("nitrogen_elements.hrl").
-compile(export_all).

-define(JQGRID_ELEMENT, #jqgrid{}).

render_action(#jqgrid_event{type = ?ONSELECTROW, target = Target}) ->
    PickledPostbackInfo = wf_event:serialize_event_context(?ONSELECTROW, Target, Target, ?JQGRID_ELEMENT#jqgrid.module),
    wf:f("document.addEventListener(\"myEvent\", eventHandler, false);
            function eventHandler(e){
              jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, status, e) {
              Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&status=\" + status);}})}",
	 [Target, ?ONSELECTROW, Target, PickledPostbackInfo]).
