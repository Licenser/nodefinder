%% @doc Nodefinder service.
%% @end

-module(nodefinder_app).
-export([ discover/0 ]).
-behaviour(application).
-export([ start/0, start/2, stop/0, stop/1 ]).

%-=====================================================================-
%-                                Public                               -
%-=====================================================================-

%% @spec discover () -> ok
%% @doc Initiate a discovery request.  Nodes will respond asynchronously
%% and be added to the erlang node list subsequent to this call returning.
%% @end

discover () ->
  nodefinder_srv:discover ().

%-=====================================================================-
%-                        application callbacks                        -
%-=====================================================================-

%% @hidden

start () ->
  crypto:start (),
  application:start (nodefinder).

%% @hidden

start (_Type, _Args) ->
    io:format("1~n"),
    { ok, Addr } = application:get_env (nodefinder, addr),
    io:format("2~n"),
    { ok, Port } = application:get_env (nodefinder, port),
    io:format("3~n"),
    { ok, Ttl } = application:get_env (nodefinder, multicast_ttl),
    io:format("4~n"),
    nodefinder_sup:start_link (Addr, Port, Ttl).

%% @hidden

stop () ->
  application:stop (nodefinder).

%% @hidden

stop (_State) ->
  ok.
