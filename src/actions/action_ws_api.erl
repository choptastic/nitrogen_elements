% Nitrogen Elements
% Copyright (c) Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

% simple websocket api
-module(action_ws_api).
-include("nitrogen_elements.hrl").
-compile(export_all).

render_action(#ws_open{server = Server, func = OnOpen}) ->
    [
     wf:f("$(function() { var websocket;
           websocket = new WebSocket('~s');window.websocket = websocket;", [Server]),
           on_open_script(OnOpen),
           ";})"
    ];
render_action(#ws_message{func = OnMessage}) -> on_message_script(OnMessage);
render_action(#ws_error{func = OnError}) -> on_error_script(OnError);
render_action(#ws_close{func = OnClose}) -> on_close_script(OnClose).

on_open_script("") ->
    "websocket.onopen = function(event){console.log('close');};";
on_open_script(OnOpen) ->
    wf:f("websocket.onopen = ~s", [OnOpen]).

on_close_script("") ->
    wf:f("$(function(){window.websocket.close();console.log('close');});");
on_close_script(OnClose) ->
    wf:f("websocket.onclose = ~s", [OnClose]).

on_message_script("") ->
    "window.websocket.onmessage = function(event){console.log(event.data)};";
on_message_script(OnMessage) ->
    wf:f("websocket.onmessage = ~s", [OnMessage]).

on_error_script("") ->
    "websocket.onerror = function(event){console.log(event.data)};";
on_error_script(OnError) ->
    wf:f("websocket.onerror = ~s", [OnError]).
