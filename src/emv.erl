-module(emv).
-author('Maxim Sokhatsky').
-compile(export_all).
-export([main/1]).

systems() -> [ inn_maestro,
               inn_mastercard,
               inn_visa,
               inn_electron ].

main([]) ->
    inets:start(),
    inets:start(httpd, [{proplist_file, "priv/server_config.erl"}]),
    io:format("Credit card validation server started.~n"),
    user_drv:start(),
    timer:sleep(infinity).

is_valid(N) -> sum_digits(lists:reverse(list_to_integers(N))) rem 10 =:= 0.
type(N) -> type_check(N, string:len(N)). 

sum_digits(N) -> sum_digits(N,0).
sum_digits([],Acc) -> Acc;
sum_digits([Odd], Acc) -> Acc + Odd;
sum_digits(List, Acc) ->
    [Odd|Tail] = List,
    [Even|Remainder] = Tail,
    sum_digits(Remainder, Acc + digital_root(Even * 2) + Odd).

card_check(Numbers) ->
    lists:foldl(fun(X,Acc) -> Acc + X end,0,
          lists:map(fun({A,Pos}) when Pos rem 2 == 0 -> list_to_integer([A]);
                       ({A,Pos}) -> case list_to_integer([A]) * 2 of
                                         X when X >= 10 -> X rem 10 + X div 10;
                                         X -> X end
    end, lists:zip(Numbers,lists:seq(1,length(Numbers))))) rem 10 == 0.

digital_root(N) -> 1 + (N-1) rem 9.
list_to_integers(N) -> lists:map(fun(E) -> list_to_integer([E]) end, N).

type_check(N,Len) ->
    case lists:foldl(fun(Module,Acc) -> 
        Prefixes = Module:info(prefix),
        case         lists:any(fun(X) -> lists:prefix(X,N) end,Prefixes) 
             andalso lists:member(Len,Module:info(length)) of
            true -> Module;
            _ -> Acc end
    end,[],systems()) of
        [] -> unknown;
         R -> R end.
