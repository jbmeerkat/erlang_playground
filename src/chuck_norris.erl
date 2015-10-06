-module(chuck_norris).
-export([start/0, start/1, loop/1, get_joke/1]).


%% @doc starts a process named after Chuck Norris
%% ```
%% > Pid = chuck_norris:start().
%% <0.40.0>
%% > Pid ! {self(), get_joke}.
%% '''
start() ->
  start(default_category()).
start(Category) ->
  inets:start(),
  spawn(?MODULE, loop, [Category]).

loop(Category) ->
  receive
    {Pid, get_joke} -> Pid ! {joke, get_joke(Category)};
    {Pid, _} -> Pid ! {invalid_message}
  end,
  ?MODULE:loop(Category).

%% @doc returns a random joke about Chuck Norris
get_joke(Category) ->
  Url = api_endpoint(Category),
  io:format(Url),
  case httpc:request(api_endpoint(Category)) of
    {ok, {_, _, Body}} ->
      Json = jsx:decode(list_to_binary(Body)),
      extract_by_path(Json, [<<"value">>, <<"joke">>]);
    _ -> fail
  end.

%% @private
%% @doc recursively searches for the value by path
extract_by_path(Val, []) -> Val;
extract_by_path(Json, [H|T]) ->
  extract_by_path(proplists:get_value(H, Json, []), T).

%% @private
api_endpoint(Category) ->
  lists:append(["http://api.icndb.com/jokes/random?limitTo=[", Category, "]"]).

%% @private
default_category() -> "nerdy".
