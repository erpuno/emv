-module (emv_server).
-compile(export_all).

validate(SessID, Env, _Input) ->
    N = dict:fetch(query_string, dict:from_list(Env)),
    Output = io_lib:format("~p~n", [{emv:type(N), N, emv:is_valid(N)}]),
    mod_esi:deliver(SessID, Output).
