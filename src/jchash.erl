-module(jchash).

-export([compute/2]).
-on_load(init/0).

-define(APPNAME, ?MODULE).
-define(LIBNAME, ?MODULE).

%%%===================================================================
%%% API
%%%===================================================================

-spec compute(Key, Buckets) -> Hash when
  Key     :: integer(),
  Buckets :: pos_integer(),
  Hash    :: non_neg_integer().
compute(_Key, _Buckets) ->
  not_loaded(?LINE).

%% @private
not_loaded(Line) ->
  erlang:nif_error({not_loaded, [{module, ?MODULE}, {line, Line}]}).

%%%===================================================================
%%% NIF init
%%%===================================================================

%% @hidden
init() ->
  SoName = case code:priv_dir(?APPNAME) of
    {error, bad_name} ->
      case filelib:is_dir(filename:join(["..", priv])) of
        true ->
          filename:join(["..", priv, ?LIBNAME]);
        _ ->
          filename:join([priv, ?LIBNAME])
      end;
    Dir ->
      filename:join(Dir, ?LIBNAME)
  end,
  erlang:load_nif(SoName, 0).

%%%===================================================================
%%% Tests
%%%===================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

jchash_test_() ->
  % {Expected, Key, Buckets}
  Cases = [
    {0, 0, 1},
    {0, 0, 2},
    {0, 0, 3},
    {0, 2, 1},
    {0, 2, 2},
    {0, 2, 3},
    {6, 2, 10},
    {69, 100, 100},
    {46, 200, 150},
    {0, 0, 10000},
    {118, 123456789, 256},
    {294, 123456789, 512},
    {65, 90484701, 100},
    {65, 90484701, 150},
    {955, 65030539, 1000},
    {955, 65030539, 1200}
  ],
  [?_assertEqual(Expected, compute(K, N)) || {Expected, K, N} <- Cases].

-endif.
