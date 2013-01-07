-ifndef(NITROGEN_ELEMENTS_HRL).
-define(NITROGEN_ELEMENTS_HRL, ok).

%% NOTE: set the include path bellow to your nitrogen installation location
-include_lib("nitrogen_core/include/wf.inc").

%% Elements
-record(tabs, {?ELEMENT_BASE(element_tabs), tabs=[], options=[], tag}).
-record(tab, {id=wf:temp_id(), title="No Title", class="", style="", body=[], tag, url}).
-record(dialog, {?ELEMENT_BASE(element_dialog), title = "", body="", width="auto", height="auto", show_cancel=false ,buttons=[]}).
-record(jqgrid, {?ELEMENT_BASE(element_jqgrid), options=[]}).

%% Actions
-define(EVENT_TABS_INIT_COMPLETED, 'tabs_init_completed').

-record(tab_destroy, {?ACTION_BASE(action_tabs_methods)}).
-record(tab_disable, {?ACTION_BASE(action_tabs_methods), tab=-1}).
-record(tab_enable, {?ACTION_BASE(action_tabs_methods), tab=-1}).
-record(tab_option, {?ACTION_BASE(action_tabs_methods), key, value}).
-record(tab_add, {?ACTION_BASE(action_tabs_methods), url, label, index}).
-record(tab_remove, {?ACTION_BASE(action_tabs_methods), tab}).
-record(tab_select, {?ACTION_BASE(action_tabs_methods), tab}).
-record(tab_load, {?ACTION_BASE(action_tabs_methods), tab}).
-record(tab_url, {?ACTION_BASE(action_tabs_methods), tab, url}).
%-record(tab_length, {?ACTION_BASE(action_tabs_methods)}).
-record(tab_abort, {?ACTION_BASE(action_tabs_methods)}).
-record(tab_rotate, {?ACTION_BASE(action_tabs_methods), ms, continuing=false}).
-record(tab_event_on, {?ACTION_BASE(action_tabs_methods), event}).
-record(tab_event_off, {?ACTION_BASE(action_tabs_methods), event}).

-record(jqgrid_event, {?ACTION_BASE(action_jqgrid), type}).
-define(ONSELECTROW, onSelectRow).

-endif.
