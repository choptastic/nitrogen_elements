# Nitrogen Elements #

A collection of useful Web UI controls to be used with Nitrogen Web Framework.

Build instructions:

1. clone / build rebar from here: https://github.com/basho/rebar
2. include nitrogen_elements dependency to your rebar.config

e.g.

{deps, [
    {nitrogen_elements, ".*", {git, "git@github.com:RomanShestakov/nitrogen_elements.git", "HEAD"}}
]}.

3. include nitrogen_elements.hrl to your modules:
    -include_lib("nitrogen_elements/include/nitrogen_elements.hrl").

for usage examples see Nitrogen_Elements_Examples project at git@github.com:RomanShestakov/nitrogen_elements_examples.git

