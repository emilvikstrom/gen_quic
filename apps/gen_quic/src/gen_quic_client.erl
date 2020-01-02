-module(gen_quic_client).

-behaviour(gen_server).

%% API
-export([start/1, start_link/1, stop/1]).

-export([code_change/3, handle_call/3, handle_cast/2,
	 handle_info/2, init/1, terminate/2]).

-include("../include/quic.hrl").
-record(state, {socket}).

start(Name) -> supervisor:start_child(Name).

stop(Name) -> gen_server:call(Name, stop).

start_link(Name) ->
    gen_server:start_link({local, Name}, ?MODULE, [], []).

init([Port, Dst]) ->
    {ok, Socket} = gen_udp:open(Port),
    init_connection(Socket, Dst);
init([{Port, Opts}, Dst]) ->
    {ok, Socket} = gen_udp:open(Port, Opts),
    init_connection(Socket, Dst).
    
handle_call(stop, _From, State) ->
    {stop, normal, stopped, State};
handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) -> {noreply, State}.

handle_info({udp, _Socket, _Ip, _Port, _Msg}, State) ->
    {noreply, State};
handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

init_connection(Socket, {DstIp, DstPort}) ->
    case gen_udp:send(Socket, {DstIp, DstPort}, ?INIT_CONNECTION) of
        ok ->
            {ok, #state{socket = Socket}};
        Error ->
            {stop, Error}
    end.
