% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(jqgrid.action_jqgrid).
-include("nitrogen_elements.hrl").
-compile(export_all).

%% jqgrid events are documented here:
%% http://www.trirand.com/jqgridwiki/doku.php?id=wiki:events

-define(JQGRID_ELEMENT, #jqgrid{}).
-define(EVENT_CTX(Event, Target, Delegate), wf_event:serialize_event_context(Event, Target, Target, Delegate)).

render_action(#jqgrid_event{target = Target, type = ?BEFORESELECTROW, postback = Postback}) ->
    #event{target = Target, type = ?BEFORESELECTROW, postback = {?BEFORESELECTROW, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module,
	   extra_param="\"&rowid=\" + arguments[1] + \"&event=\" + arguments[2]"};
render_action(#jqgrid_event{target = Target, type = ?ONSELECTROW, postback = Postback}) ->
    #event{target = Target, type = ?ONSELECTROW, postback = {?ONSELECTROW, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&rowid=\" + arguments[1] + \"&status=\" + arguments[2]"};
render_action(#jqgrid_event{target = Target, type = ?ONCELLSELECT, postback = Postback}) ->
    #event{target = Target, type = ?ONCELLSELECT, postback = {?ONCELLSELECT, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&rowid=\" + arguments[1] +
               \"&iCol=\" + arguments[2] + \"&cellcontent=\" + arguments[3]"};
render_action(#jqgrid_event{target = Target, type = ?AFTERINSERTROW, postback = Postback}) ->
    #event{target = Target, type = ?AFTERINSERTROW, postback = {?AFTERINSERTROW, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&rowid=\" + arguments[1] +
               \"&rowdata=\" + arguments[2] + \"&rowelem=\" + arguments[3]"};
render_action(#jqgrid_event{target = Target, type = ?BEFOREREQUEST, postback = Postback}) ->
    PostbackInfo = ?EVENT_CTX({?BEFOREREQUEST, Postback}, Target, ?JQGRID_ELEMENT#jqgrid.module),
    #event{target = Target, type = 'jqgrid_init', actions =
	       wf:f("jQuery(obj('~s')).jqGrid('setGridParam', {~s: function() {
                    Nitrogen.$queue_event('~s', '~s');}})",
		    [Target, ?BEFOREREQUEST, Target, PostbackInfo])};
render_action(#jqgrid_event{target = Target, type = ?ONDBLCLICKROW, postback = Postback}) ->
    #event{target = Target, type = ?ONDBLCLICKROW, postback = {?ONDBLCLICKROW, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&rowid=\" + arguments[1] +
               \"&iRow=\" + arguments[2] + \"&iCol=\" + arguments[3]"};
render_action(#jqgrid_event{target = Target, type = ?ONHEADERCLICK, postback = Postback}) ->
    #event{target = Target, type = ?ONHEADERCLICK, postback = {?ONHEADERCLICK, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&gridstate=\" + arguments[1]"};
render_action(#jqgrid_event{target = Target, type = ?ONRIGHTCLICKROW, postback = Postback}) ->
    #event{target = Target, type = ?ONRIGHTCLICKROW, postback = {?ONRIGHTCLICKROW, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&rowid=\" + arguments[1] +
               \"&iRow=\" + arguments[2] + \"&iCol=\" + arguments[3]"}.
