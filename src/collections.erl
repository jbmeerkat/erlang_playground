-module(collections).
-export([length/1, reverse/1, duplicate/2, zip/2, quicksort/1]).

-spec length(list()) -> integer().
%% @doc returns list length
length(L) when is_list(L) -> length(L, 0).
length([], Acc) -> Acc;
length([_|T], Acc) -> length(T, Acc + 1).

-spec reverse(list()) -> list().
%% @doc reverts list
reverse(L) -> reverse(L, []).
reverse([], Acc) -> Acc;
reverse([H|T], Acc) -> reverse(T, [H|Acc]).

-spec duplicate(any(), integer()) -> list().
%% @doc repeats specified symbols
duplicate(_, 0) -> [];
duplicate(Term, N) when N > 0 -> duplicate(Term, N, []).
duplicate(_, 0, Acc) -> Acc;
duplicate(Term, N, Acc) -> duplicate(Term, N - 1, [Term|Acc]).

-spec zip(list(), list()) -> list().
%% @doc zips two lists
zip([], _) -> [];
zip(_, []) -> [];
zip([X|Xs], [Y|Ys]) -> [{X, Y}|zip(Xs, Ys)].

-spec quicksort(list()) -> list().
%% @doc naive quicksort
quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
  {Smaller, Bigger} = partition(Pivot, Rest, [], []),
  quicksort(Smaller) ++ [Pivot] ++ quicksort(Bigger).

-spec partition(integer(), list(), list(), list()) -> {list(), list()}.
%% @private
%% @doc splits list in two lists - smaller and bigger than specified pivot
partition(_, [], Smaller, Bigger) -> {Smaller, Bigger};
partition(Pivot, [H|Rest], Smaller, Bigger) ->
  if
    H < Pivot ->
      partition(Pivot, Rest, [H|Smaller], Bigger);
    H >= Pivot ->
      partition(Pivot, Rest, Smaller, [H|Bigger])
  end.
