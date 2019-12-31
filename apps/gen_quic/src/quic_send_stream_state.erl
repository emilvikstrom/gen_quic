-module(quic_send_statem).
-behaviour(gen_statem).
-export([init/1,
        callback_mode/0,
        handle_event/3]).

%%Callbacks
-export([ready/3, send/3, data_sent/3, data_recvd/3, reset_recvd/3, reset_sent/3]).

init([]) ->
    State = ready,
    Data = #{},
    {ok, State, Data}.

ready(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

send(EventType,EventContent,Data) ->
    handle_event(EventType, EventContent, Data).

data_sent(EventType,EventContent,Data) ->
    handle_event(EventType, EventContent, Data).

data_recvd(EventType,EventContent,Data) ->
    handle_event(EventType, EventContent, Data).

reset_sent(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

reset_recvd(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

callback_mode() -> state_functions.
handle_event(_,_,Data) ->
    {keep_state, Data}.