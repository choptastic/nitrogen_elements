-module (element_formbox5).
-include_lib ("nitrogen_elements.hrl").
-compile(export_all).

reflect() -> record_info(fields, textbox).

render_element(Record) -> 
    ID = Record#formbox5.id,
    Anchor = Record#formbox5.anchor,
    case Record#formbox5.next of
        undefined -> ignore;
        Next -> 
            Next1 = wf_render_actions:normalize_path(Next),
            wf:wire(Anchor, #event { type=enterkey, actions=wf:f("Nitrogen.$go_next('~s');", [Next1]) })
    end,

   
    case Record#formbox5.postback of
        undefined -> ignore;
        Postback -> wf:wire(Anchor, #event { type=enterkey, postback=Postback, validation_group=ID, delegate=Record#formbox5.delegate })
    end,

    Value = wf:html_encode(Record#formbox5.text, Record#formbox5.html_encode),
    wf_tags:emit_tag(input, [
			     {type, Record#formbox5.type}, 
			     {class, [textbox, Record#formbox5.class]},
			     {style, Record#formbox5.style},
			     {value, Value},
			     {autocomplete, Record#formbox5.autocomplete},
			     {placeholder, Record#formbox5.placeholder}
			     
    ]).

