echo(off),
{ok, PropOld} = application:get_env(msync, user),

PoolSize = proplists:get_value(pool_size, PropOld),


ProcName =
fun(Integer) ->
        list_to_atom(lists:flatten(io_lib:format("~p_~p", [msync_user,Integer])))
end,

lists:foreach(
      fun(N) ->
	      Name = ProcName(N),
              {state, Servers, Workers, LstConnectTime}  = sys:get_state(Name),
	      io:format("~p workers in ~s~n", [ queue:len(Workers), Name ])
      end, lists:seq(0, PoolSize -1)),


ok.
