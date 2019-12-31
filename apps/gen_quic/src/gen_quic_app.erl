%%%-------------------------------------------------------------------
%% @doc gen_quic public API
%% @end
%%%-------------------------------------------------------------------

-module(gen_quic_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    gen_quic_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
