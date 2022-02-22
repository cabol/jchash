# jchash

![CI](https://github.com/cabol/jchash/workflows/CI/badge.svg)

Jump Consistent Hash NIF library for Erlang/Elixir.

This NIF implements the Jump Consistent Hash algorithm, created by John Lamping
and Eric Veach developed at **Google, Inc**. This is the original paper:
["A Fast, Minimal Memory, Consistent Hash Algorithm"](http://arxiv.org/ftp/arxiv/papers/1406/1406.2294.pdf).

## Installation

### Erlang

In your `rebar.config`:

```erlang
{deps, [
  {jchash, "0.1.2"}
]}.
```

Usage example:

```
> jchash:compute(1, 2).
0

> jchash:compute(erlang:phash2(os:timestamp()), 100).
22
```

### Elixir

In your `mix.exs`:

```elixir
def deps do
  [{:jchash, "~> 0.1"}]
end
```

Usage example:

```
> :jchash.compute(1, 2)
0

> System.system_time() |> :erlang.phash2() |> :jchash.compute(100)
22
```

## Testing

    $ rebar3 eunit

## Copyright and License

Copyright (c) 2016 Carlos Andres Bolaños R.A.

**jchash** source code is licensed under the [MIT License](LICENSE.md).
