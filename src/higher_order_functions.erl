-module(higher_order_functions).
-export([map/2, reduce/3]).

%% @doc map the given function onto each element of the list
map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

%% @doc reduce the elements of the list using given function and accumulator value
reduce(_, Acc, []) -> Acc;
reduce(F, Acc, [H|T]) -> reduce(F, F(Acc, H), T).
