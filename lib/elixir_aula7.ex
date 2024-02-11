defmodule ElixirAula7 do
  def aplica_duas_vezes(f, initial) do
    f.(f.(initial))
  end

  def iter(_f, 0, x), do: x

  def iter(f, it, x) do
    iter(f, it - 1, f.(x))
  end

  def filter([], _pred), do: []

  def filter([h | t], pred) do
    case pred.(h) do
      true -> [h | filter(t, pred)]
      false -> filter(t, pred)
    end
  end

  def reduce([], acc, _f), do: acc

  def reduce([h | t], acc, f) do
    reduce(t, f.(acc, h), f)
  end

  def foldr([], acc, _f), do: acc

  def foldr([h | t], acc, f) do
    f.(h, foldr(t, acc, f))
  end

  def concatena(list) do
    foldr(list, [], &(&2 ++ &1))
  end

  def soma_quad_positivos(list) do
    positivos = filter(list, fn x -> x > 0 end)
    quadrados = Enum.map(positivos, fn x -> x * x end)
    reduce(quadrados, 0, &:erlang.+/2)
  end

  def conta_elementos(list) do
    nova_lista = Enum.map(list, fn _x -> 1 end)
    reduce(nova_lista, 0, &:erlang.+/2)
  end

  def conta_neg(list) do
    fun = fn x ->
      cond do
        x < 0 -> 1
        x >= 0 -> 0
      end
    end

    negs = Enum.map(list, fun)
    reduce(negs, 0, &:erlang.+/2)
  end

  def soma_lista_lista(list) do
    f_soma = &:erlang.+/2
    f_soma_lista = &reduce(&1, 0, f_soma)

    soma_parcial = Enum.map(list, f_soma_lista)
    reduce(soma_parcial, 0, f_soma)
  end
end
