-module(gen_quic_server).

-behaviour(gen_server).

%% API
-export([start/1, start_link/1, stop/1]).

-export([code_change/3, handle_call/3, handle_cast/2,
	 handle_info/2, init/1, terminate/2]).

-record(state, {socket}).

start(Name) -> supervisor:start_child(Name).

stop(Name) -> gen_server:call(Name, stop).

start_link(Name) ->
    gen_server:start_link({local, Name}, ?MODULE, [], []).

init([Port]) ->
    {ok, Socket} = gen_udp:open(Port),
    
    {ok, #state{socket = Socket}};
init([{Port, Opts}, {DstIp, DstSrc}]) ->
    {ok, Socket} = gen_udp:open(Port, Opts),
    {ok, #state{socket = Socket}}.

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
