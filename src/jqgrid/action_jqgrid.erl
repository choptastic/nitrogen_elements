% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_jqgrid).
-include("nitrogen_elements.hrl").
-compile(export_all).

%% jqgrid events are documented here:
%% http://www.trirand.com/jqgridwiki/doku.php?id=wiki:events

-define(JQGRID_ELEMENT, #jqgrid{}).
-define(EVENT_CTX(Event, Target, Delegate), wf_event:serialize_event_context(Event, Target, Target, Delegate)).

render_action(#jqgrid_event{target = Target, type = ?BEFORESELECTROW, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?BEFORESELECTROW, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, e) {
               Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&event=\" + e);}})",
		    [Target, ?BEFORESELECTROW, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?ONSELECTROW, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?ONSELECTROW, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, status, e) {
               Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&status=\" + status);}})",
		    [Target, ?ONSELECTROW, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?ONCELLSELECT, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?ONCELLSELECT, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, iCol, cellcontent, e) {
                    Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&iCol=\" + iCol +
                    \"&cellcontent=\" + cellcontent);}})",
		    [Target, ?ONCELLSELECT, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?AFTERINSERTROW, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?AFTERINSERTROW, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, rowdata, rowelem) {
                    Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&rowdata=\" + jQuery.param(rowdata) +
                    \"&rowelem=\" + rowelem);}})",
		    [Target, ?AFTERINSERTROW, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?BEFOREPROCESSING, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?BEFOREPROCESSING, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(data, status, xhr) {
                    Nitrogen.$queue_event('~s', '~s', \"&data=\" + jQuery.param(data) + \"&status=\" + status +
                    \"&xhr=\" + xhr);}})",
		    [Target, ?BEFOREPROCESSING, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?BEFOREREQUEST, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?BEFOREREQUEST, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function() {
                    Nitrogen.$queue_event('~s', '~s');}})",
		    [Target, ?BEFOREREQUEST, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?ONDBLCLICKROW, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?ONDBLCLICKROW, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, iRow, iCol, e) {
               Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&iRow=\" + iRow + \"&iCol=\" + iCol);}})",
		    [Target, ?ONDBLCLICKROW, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?ONHEADERCLICK, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?ONHEADERCLICK, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(gridstate) {
               Nitrogen.$queue_event('~s', '~s', \"&gridstate=\" + gridstate);}})",
		    [Target, ?ONHEADERCLICK, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?ONRIGHTCLICKROW, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?ONRIGHTCLICKROW, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function(rowid, iRow, iCol, e) {
               Nitrogen.$queue_event('~s', '~s', \"&rowid=\" + rowid + \"&iRow=\" + iRow + \"&iCol=\" + iCol);}})",
		    [Target, ?ONRIGHTCLICKROW, Target, PostbackInfo])}.
