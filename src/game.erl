-module(game).
-export([new_player/1, inspect_player/1]).
-include("game_records.hrl").

%% @doc return new player record
new_player(Name) -> #player{name=Name, inventory=[#item{name="Club", weight=2, cost=16},
                                                  #item{name="Dagger", weight=0.5, cost=23}]}.

%% @doc print player info
inspect_player(#player{name=Name, inventory=Inventory}) ->
  io:format("It's ~s~n", [Name]),
  Items = [I#item.name || I <- Inventory],
  io:format("Items in pockets: ~s~n", [string:join(Items, ", ")]).
