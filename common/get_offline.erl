Worker = cuesport:get_worker(index),
%%##AppKey = <<"51aigegou#aggrelease">>,
%%User = <<"17601597971">>, 

AppKey = <<"tusou001#v40">>,
User = <<"szygbd__18818773499">>,
{ok, R} = eredis:q(Worker, [hgetall, iolist_to_binary(["unread:", AppKey, "_" , User, "@easemob.com/mobile"])]),
io:format("~p~n",[R]),
lists:foreach(fun(M) ->
		      {ok, List} = eredis:q(Worker, [lrange, iolist_to_binary(["index:unread:", AppKey, "_", User, "@easemob.com/mobile:", M]), 0,-1]),
		      io:format("queue ~p ~n", [M]),
		      lists:foreach(
			fun(MID) ->
				io:format("       MID is ~p~n", [MID]),
				Meta = msync_msg:decode_meta(message_store:read(MID)),
				io:format("       BODY is ~p~n", [Meta ])
			end, List)
	      end, R).