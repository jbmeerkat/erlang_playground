-module(calc).
-export([rpn/1]).

-spec rpn([char()]) -> number().
%% @doc evaluates reverse polish notation expressions
%% ```
%% > calc:rpn("2 2 2 + *").
%% 8
%% '''
%% @end
rpn(Expr) ->
  [Res] = lists:foldl(fun rpn/2, [], string:tokens(Expr, " ")),
  Res.

rpn("+", [X,Y|Stack]) -> [Y+X|Stack];
rpn("-", [X,Y|Stack]) -> [Y-X|Stack];
rpn("*", [X,Y|Stack]) -> [Y*X|Stack];
rpn("/", [X,Y|Stack]) -> [Y/X|Stack];
rpn("^", [X,Y|Stack]) -> [math:pow(Y, X)|Stack];
rpn(Num, Stack) -> [list_to_integer(Num)|Stack].
