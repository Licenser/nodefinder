%% @hidden

-module (nodefinder_sup).
-behaviour (supervisor).

-export ([ start_link/2, start_link/3, init/1 ]).

%-=====================================================================-
%-                                Public                               -
%-=====================================================================-

start_link (Addr, Port) ->
  start_link (Addr, Port, 1).

start_link (Addr, Port, Ttl) ->
  supervisor:start_link (?MODULE, [ Addr, Port, Ttl ]).

%-=====================================================================-
%-                         Supervisor callbacks                        -
%-=====================================================================-

init ([ Addr, Port, Ttl ]) ->
  { ok,
    { { one_for_one, 3, 10 },
      [ { nodefinder_srv,
          { nodefinder_srv, start_link, [ Addr, Port, Ttl ] },
          permanent,
          1000,
          worker,
          [ nodefinder_srv ]
        }
      ]
    }
  }.
