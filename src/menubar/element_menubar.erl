% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

%% http://stackoverflow.com/questions/12944364/how-to-make-jquery-ui-nav-menu-horizontal

-module(menubar.element_menubar).
-include("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, menubar).

render_element(Record) ->
    ID = Record#menubar.id,

    %% %% init control with specified options
    Options = action_jquery_effect:options_to_js(Record#menubar.options),
    wf:wire(ID, wf:f("$(function(){jQuery(obj('~s')).menubar(~s);})", [ID, Options])),

    %% %% create html markup
    #panel{
    	body = [
	    #list{
		id = ID,
	        html_id = wf:temp_id(),
		class = wf:to_list(Record#menubar.class),
		style = wf:to_list(Record#menubar.style),
		body = [#listitem{body = item_link(Item)} || Item <- Record#menubar.body]
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
    Module = wf:page_module(),
    Module:event(Event).
