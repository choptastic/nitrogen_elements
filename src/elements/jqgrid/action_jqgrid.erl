% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(action_jqgrid).
-include("nitrogen_elements.hrl").
-compile(export_all).


%% jqgrid events are documented here:
%% http://www.trirand.com/jqgridwiki/doku.php?id=wiki:events

-define(JQGRID_ELEMENT, #jqgrid{}).

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
    #event{target = Target, type = ?BEFOREREQUEST, postback = {?BEFOREREQUEST, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module};
render_action(#jqgrid_event{target = Target, type = ?ONDBLCLICKROW, postback = Postback}) ->
    #event{target = Target, type = ?ONDBLCLICKROW, postback = {?ONDBLCLICKROW, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&rowid=\" + arguments[1] +
               \"&iRow=\" + arguments[2] + \"&iCol=\" + arguments[3]"};
render_action(#jqgrid_event{target = Target, type = ?ONHEADERCLICK, postback = Postback}) ->
    #event{target = Target, type = ?ONHEADERCLICK, postback = {?ONHEADERCLICK, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&gridstate=\" + arguments[1]"};
render_action(#jqgrid_event{target = Target, type = ?ONLOADCOMPLETE, postback = Postback}) ->
    #event{target = Target, type = ?ONLOADCOMPLETE, postback = {?ONLOADCOMPLETE, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&data=\" + JSON.stringify(arguments[1])"};
render_action(#jqgrid_event{target = Target, type = ?ONPAGESIZECHANGE, postback = Postback}) ->
    %% this is custom event to simplify getting details of the currect page size
    #event{target = Target, type = ?ONLOADCOMPLETE, postback = {?ONPAGESIZECHANGE, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&page=\" + arguments[1].page + \"&total=\" +
	arguments[1].total +\"&records=\" + arguments[1].records"};
render_action(#jqgrid_event{target = Target, type = ?ONRIGHTCLICKROW, postback = Postback}) ->
    #event{target = Target, type = ?ONRIGHTCLICKROW, postback = {?ONRIGHTCLICKROW, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&rowid=\" + arguments[1] +
               \"&iRow=\" + arguments[2] + \"&iCol=\" + arguments[3]"};
render_action(#jqgrid_event{target = Target, type = ?ONTOOLBARAFTERSEARCH, postback = Postback}) ->
    #event{target = Target, type = ?ONTOOLBARAFTERSEARCH, postback = {?ONTOOLBARAFTERSEARCH, Postback},
       delegate = ?JQGRID_ELEMENT#jqgrid.module};
render_action(#jqgrid_event{target = Target, type = ?ONSORTCOL, postback = Postback}) ->    
    #event{target = Target, type = ?ONSORTCOL, postback = {?ONSORTCOL, Postback},
	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&index=\" + arguments[1] +
               \"&iCol=\" + arguments[2] + \"&sortorder=\" + arguments[3]"}.
%% render_action(#jqgrid_event{target = Target, type = ?BEFOREPROCESSING, postback = Postback}) ->
%%     #event{target = Target, type = ?BEFOREPROCESSING, postback = {?BEFOREPROCESSING, Postback},
%% 	   delegate = ?JQGRID_ELEMENT#jqgrid.module, extra_param="\"&data=\" + arguments[1] + \"&status=\" + arguments[2] +
%% 	\"&xhr=\" + arguments[3]"}.
