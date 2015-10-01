-module(higher_order_functions).
-export([map/2, lc_map/2, reduce/3, filter/2, lc_filter/2]).

%% @doc map the given function onto each element of the list
map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

%% @doc same as map, but implemented using list comprehensions
lc_map(F, L) -> [ F(I) || I <- L].

%% @doc reduce the elements of the list using given function and accumulator value
reduce(_, Acc, []) -> Acc;
reduce(F, Acc, [H|T]) -> reduce(F, F(Acc, H), T).

%% @doc return items for which predicate is true
filter(Pred, L) -> filter(Pred, L, []).
filter(_, [], Acc) -> lists:reverse(Acc);
filter(Pred, [H|T], Acc) ->
  case Pred(H) of
    true -> filter(Pred, T, [H|Acc]);
    false -> filter(Pred, T, Acc)
  end.

%% @doc same as filter, but implemented using list comprehensions
lc_filter(Pred, L) -> [X || X <- L, Pred(X)].
