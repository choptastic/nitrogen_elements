-module (element_textbox5).
-include_lib ("nitrogen_elements.hrl").
-compile(export_all).

reflect() -> record_info(fields, textbox).

render_element(Record) -> 
    ID = Record#textbox5.id,
    Anchor = Record#textbox5.anchor,
    case Record#textbox5.next of
        undefined -> ignore;
        Next -> 
            Next1 = wf_render_actions:normalize_path(Next),
            wf:wire(Anchor, #event { type=enterkey, actions=wf:f("Nitrogen.$go_next('~s');", [Next1]) })
    end,

    case Record#textbox5.postback of
        undefined -> ignore;
        Postback -> wf:wire(Anchor, #event { type=enterkey, postback=Postback, validation_group=ID, delegate=Record#textbox5.delegate })
    end,

    Value = wf:html_encode(Record#textbox5.text, Record#textbox5.html_encode),
    wf_tags:emit_tag(input, [
			     {type, text}, 
			     {class, [textbox, Record#textbox5.class]},
			     {style, Record#textbox5.style},
			     {value, Value},
			     {autocomplete, Record#textbox5.autocomplete}
			     
    ]).
