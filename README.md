Nitrogen Elements - v.0.2
=========================

Nitrogen Elements is a collection of useful Web UI controls and
supposed to be used as an extention to Nitrogen Web Framework.
Most of the controls in the library are implemented as Nitrogen wrappers to corresponding jQuery UI widgets.

Implemented Elements:
--------------------

* Action Dialog
* Accordion
* Tabs
* Menu
* Menubar
* jsGrid
* Progressbar
* Layout


Build instructions:
-------------------

*  clone / build rebar from here: https://github.com/basho/rebar
*  include nitrogen_elements dependency to your rebar.config
*  clone the project from https://github.com/RomanShestakov/nitrogen_elements.git
*  or include "Nitrogen Elements" as dependency for your project in rebar.config

e.g.:

```erlang
  {deps, [
     {nitrogen_elements, ".*", {git, "git@github.com:RomanShestakov/nitrogen_elements.git", "HEAD"}}
  ]}.
```

*  add nitrogen_elements.hrl to your modules:
```erlang
    -include_lib("nitrogen_elements/include/nitrogen_elements.hrl").
```

* Please notice that your html template need to include the following references to css and javascript libs:

```javascript
<link rel='stylesheet' href='plugins/jquery-ui/css/jquery-ui-1.10.0.custom.min.css' type='text/css' media='screen' charset='utf-8'>
<script src='/plugins/jquery-ui/js/jquery-ui-1.10.0.custom.min.js' type='text/javascript' charset='utf-8'></script>
<script src='/plugins/history/html4_html5/jquery.history.js' type='text/javascript' charset='utf-8'></script>
<script src='/plugins/history/history_helper.js' type='text/javascript' charset='utf-8'></script>
<script src='/plugins/jqgrid/js/i18n/grid.locale-en.js' type='text/javascript'></script>
<script type="text/javascript">	jQuery.jgrid.no_legacy_api = true; </script>
<script src='/plugins/jqgrid/js/jquery.jqGrid.min.js' type='text/javascript'></script>
<script src='/plugins/layout/js/jquery.layout-latest.min.js' type='text/javascript'></script>
<script src='/plugins/menubar/jquery.ui.menubar.js' type='text/javascript' charset='utf-8'></script>
```

see for example priv/templates/onecolumn.html from
Nitrogen_Elements_Example project.

Examples:
---------

The best way to get familiar with Nitrogen_Elements is to clone
Nitrogen_Elements_Example project which shows practical usage :

1. git clone https://github.com/RomanShestakov/nitrogen_elements_examples.git
2. cd nitrogen_elements_examples;make
3. ./start.sh
4. in browser go to locahost:8000
