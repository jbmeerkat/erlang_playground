-module(better_bender).
-export([start/0, talk/2, say/0]).

%% @doc spawn Bender
start() ->
  spawn(?MODULE, say, []).

%% @doc user-friendly interface
%% ```
%% > Pid = better_bender:start().
%% <0.40.0>
%% > better_bender:talk(Pid, hi).
%% 'Bite my shiny metal ass.'
%% '''
talk(Pid, Phrase) ->
  Pid ! {self(), Phrase},
  receive
    {Pid, Msg} -> Msg
  end.

%% @doc say something to Bender
say() ->
  receive
    {From, hi} ->
      From ! {self(), 'Bite my shiny metal ass.'},
      say();
    {From, how_are_you} ->
      From ! {self(),'I\'m so embarrassed, I wish everybody else was dead.'},
      say();
    {From, what_are_you_up_to} ->
      From ! {self(), 'I\'m gonna go build my own theme park with blackjack and hookers. In fact, forget the park.'},
      say();
    _ ->
      io:format('You should say something else~n')
  end.
