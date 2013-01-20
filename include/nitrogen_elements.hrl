-ifndef(NITROGEN_ELEMENTS_HRL).
-define(NITROGEN_ELEMENTS_HRL, ok).

%% NOTE: set the include path bellow to your nitrogen installation location
-include_lib("nitrogen_core/include/wf.inc").

%% Dialog
-record(dialog, {?ELEMENT_BASE(element_dialog), title = "", body="", width="auto",
		 height="auto", show_cancel=false, buttons=[]}).

%% progress bar
-record(progressbar, {?ELEMENT_BASE(element_progressbar), options=[]}).
-record(progressbar_value, {?ACTION_BASE(action_progressbar), value}).
-record(progressbar_disable, {?ACTION_BASE(action_progressbar)}).
-record(progressbar_enable, {?ACTION_BASE(action_progressbar)}).
-record(progressbar_event_on, {?ACTION_BASE(action_progressbar), event, postback}).
-record(progressbar_event_off, {?ACTION_BASE(action_progressbar), event}).

%% tabs
-define(EVENT_TABS_ACTIVATE, 'tabsactivate').
-define(EVENT_TABS_BEFORE_ACTIVATE, 'tabsbeforeactivate').
-define(EVENT_TABS_BEFORE_LOAD, 'tabsbeforeload').
-define(EVENT_TABS_CREATE, 'tabscreate').
-define(EVENT_TABS_LOAD, 'tabsload').
-record(tabs, {?ELEMENT_BASE(element_tabs), tabs=[], options=[], tag}).
-record(tab, {id=wf:temp_id(), title="No Title", class="", style="", body=[], tag, url}).
-record(tab_destroy, {?ACTION_BASE(action_tabs_methods)}).
-record(tab_disable, {?ACTION_BASE(action_tabs_methods), tab}).
-record(tab_enable, {?ACTION_BASE(action_tabs_methods), tab}).
-record(tab_option, {?ACTION_BASE(action_tabs_methods), key, value}).
-record(tab_add, {?ACTION_BASE(action_tabs_methods), url, title}).
-record(tab_remove, {?ACTION_BASE(action_tabs_methods), tab}).
-record(tab_select, {?ACTION_BASE(action_tabs_methods), tab}).
-record(tab_event_on, {?ACTION_BASE(action_tabs_methods), type, postback}).
-record(tab_event_off, {?ACTION_BASE(action_tabs_methods), type}).

%% jqgrid
-record(jqgrid, {?ELEMENT_BASE(element_jqgrid), options=[]}).
-record(jqgrid_event, {?ACTION_BASE(action_jqgrid), type}).
-define(ONSELECTROW, onSelectRow).

%% menu
-record(menu, {?ELEMENT_BASE(element_menu), items=[], options=[]}).
-record(item, {id=wf:temp_id(), title="No Title", class="", style="", items=[]}).

-endif.
