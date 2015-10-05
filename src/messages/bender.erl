-module(bender).
-export([say/0]).

%% @doc simple Bender simulator
say() ->
  receive
    {From, hi} ->
      From ! 'Bite my shiny metal ass.',
      say();
    {From, how_are_you} ->
      From ! 'I\'m so embarrassed, I wish everybody else was dead.',
      say();
    {From, what_are_you_up_to} ->
      From ! 'I\'m gonna go build my own theme park with blackjack and hookers. In fact, forget the park.',
      say();
    _ ->
      io:format('You should say something else')
  end.
