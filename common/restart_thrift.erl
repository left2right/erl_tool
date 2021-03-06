IsEjabberd =
fun() ->
        case lists:keysearch(ejabberd, 1, application:which_applications()) of
            {Value, _} ->
                true;
            _ ->
                false
        end
end,


case IsEjabberd() of
    true ->
        X0 = ejabberd_config:load_file("/data/apps/opt/ejabberd/etc/ejabberd/ejabberd.yml"),
        io:format("reload parameter => ~p~n",[X0]),
        X1 = restart_module:restart_login(),
        io:format("restart_module:restart_login() => ~p~n",[X1]),
        X2 = extauth_rpc:stop(<<"easemob.com">>),
        io:format("extauth_rpc:stop => ~p~n",[X2]),
        X3 = (catch ets:delete_all_objects(extauth_opts)),
        io:format("ets:delete_all_objects => ~p~n",[X3]),
        X4 = extauth_rpc:start(<<"easemob.com">>),
        io:format("ets:delete_all_objects => ~p~n",[X4]);
    false ->
        io:format("TODO: msync does not support it yet~n",[])
end,
ok.


