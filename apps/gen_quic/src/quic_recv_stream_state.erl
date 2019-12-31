-module(quic_recv_stream_state).
-behaviour(gen_statem).
-export([init/1,
        callback_mode/0,
        handle_event/3]).
-include("../include/quic.hrl").

-export([idle/3 ,recv/3, size_known/3, data_recvd/3, reset_recvd/3, data_read/3, reset_read/3]).

init([Port]) ->
    UdpSocket = gen_udp:open(Port),
    State = recv,
    Data = #{},
    {ok, State, Data#{socket => UdpSocket}}.


idle(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

recv(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

size_known(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

data_recvd(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

reset_recvd(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

data_read(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

reset_read(EventType, EventContent, Data) ->
    handle_event(EventType, EventContent, Data).

callback_mode() -> state_functions.
handle_event(_,_,Data) ->
    {keep_state, Data}.