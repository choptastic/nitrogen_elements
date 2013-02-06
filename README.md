Nitrogen Elements
=================

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

1. clone / build rebar from here: https://github.com/basho/rebar
2. include nitrogen_elements dependency to your rebar.config
3. clone the project from https://github.com/RomanShestakov/nitrogen_elements.git
4. or include "Nitrogen Elements" as dependency for your project in rebar.config

e.g.
{deps, [
    {nitrogen_elements, ".*", {git, "git@github.com:RomanShestakov/nitrogen_elements.git", "HEAD"}}
]}.

5. add nitrogen_elements.hrl to your modules:
    -include_lib("nitrogen_elements/include/nitrogen_elements.hrl").

Examples:
---------

The best way to get familiar with Nitrogen_Elements is to clone
Nitrogen_Elements_Example project which shows practical usage :

1. git clone https://github.com/RomanShestakov/nitrogen_elements_examples.git
2. cd nitrogen_elements_examples;make
3. ./start.sh
4. in browser go to locahost:8000
