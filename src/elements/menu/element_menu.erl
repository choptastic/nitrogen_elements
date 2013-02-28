% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module(element_menu).
-include("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, menu).

render_element(Record) ->
    ID = Record#menu.id,

    %% %% init jQuery control with specified options
    Options = common:options_to_js(Record#menu.options),
    wf:wire(ID, wf:f("$(function(){jQuery(obj('~s')).menu(~s);})", [ID, Options])),

    %% create html markup
    #panel{
    	body = [
	    #list{
		id = ID,
	        html_id = wf:temp_id(),
		class = wf:to_list(Record#menu.class),
		style = wf:to_list(Record#menu.style),
		body = [#listitem{body = item_link(Item)} || Item <- Record#menu.body]
	    }
    	]
    }.

item_link(#item{postback = Postback, url = "#", title = Title, body = []}) ->
    #link{postback = Postback, body = Title};
item_link(#item{url = Url, postback = undefined, title = Title, body = []}) ->
    #link{url = Url, body = Title};
item_link(#item{url = Url, postback = undefined, title = Title, body = Items}) ->
    [#link{url = Url, body = Title}, #list{body = [#listitem{body = item_link(Item)} || Item <- Items]}].

event(Event) ->
    %% ?PRINT({menu_event, Event}),
    Module = wf:page_module(),
    Module:event(Event).
