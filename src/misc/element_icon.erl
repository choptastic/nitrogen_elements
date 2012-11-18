-module(element_icon).
-compile(export_all).

-include("nitrogen_elements.hrl").
% -record(icon, {?ELEMENT_BASE(element_icon), kind, type, url="", body=[]}).

reflect() -> record_info(fields, icon).

render_element(Record) ->
    Item = lists:concat(["icon-", Record#icon.type]),
    Group = lists:concat(["container-", Record#icon.kind]),
    Icon =
    #tablecell {
	style = "border: 0;",
	body = #panel{class=Group, body=#link{class=Item, url=Record#icon.url}}
    },

    Body =
    case Record#icon.body of
	[] -> [];
	_ -> #tablecell{body = Record#icon.body}
    end,

    #singlerow
    {
	id = Record#icon.id,
	class = Record#icon.class,
	style = Record#icon.style,
	cells = [Icon, Body]
    }.
