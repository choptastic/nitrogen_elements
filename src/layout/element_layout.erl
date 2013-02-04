
-module(element_layout).
-include_lib("nitrogen_core/include/wf.hrl").
-include("nitrogen_elements.hrl").
-compile(export_all).

%% Custom element to define a full screen north, south, east, west, center
%% style layout. Uses a JQuery layout library.
%% copied from SlideBlast project - https://github.com/rustyio/SlideBlast.git

% Required for a custom element.
reflect() -> record_info(fields, layout).

% Executes when the element is rendered.
render_element(#layout {
		  class=Class,
		  north=North,   north_options=NorthOpts,
		  south=South,   south_options=SouthOpts,
		  east=East,     east_options=EastOpts,
		  west=West,     west_options=WestOpts,
		  center=Center, center_options=CenterOpts }) ->

    %% Generate Javascript...
    Marker = wf:temp_id(),
    [NorthID, SouthID, EastID, WestID, CenterID] = [wf:temp_id() || _ <- lists:seq(1, 5)],
    wf:wire(Marker, wf:f("$(function(){jQuery(obj('body')).layout(
                             { north: ~s, south: ~s, east:  ~s, west : ~s, center : ~s });})",
			 [
			  make_layout_opts(NorthID, NorthOpts),
			  make_layout_opts(SouthID, SouthOpts),
			  make_layout_opts(EastID, EastOpts),
			  make_layout_opts(WestID, WestOpts),
			  make_layout_opts(CenterID, CenterOpts)
			 ])),

    %% Output the panels...
    [
     #panel { show_if=(North /= undefined),  class=[Class, " ", NorthID, "ui-layout-north"], body=North },
        #panel { show_if=(South /= undefined),  class=[Class, " ", SouthID, "ui-layout-south"], body=South },
        #panel { show_if=(East /= undefined),   class=[Class, " ", EastID, "ui-layout-east"], body=East },
        #panel { show_if=(West /= undefined),   class=[Class, " ", WestID, "ui-layout-west"], body=West },
        #panel { show_if=(Center /= undefined), class=[Class, " ", CenterID, "ui-layout-center"], body=Center },
        #span { id=Marker, style="display: none;" }
    ].

make_layout_opts(ID, Opts) ->
    PreOpts = [{paneSelector, list_to_binary("." ++ ID)}],
    common:options_to_js(PreOpts ++ Opts).
