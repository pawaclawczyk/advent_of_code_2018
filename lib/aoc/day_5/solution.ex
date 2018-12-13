defmodule AoC.Day5.Solution do
  def run() do
    AoC.Reader.as_strings('data/5/input')
    |> length_after_reaction()
    |> AoC.Writer.print(5, 1)

    AoC.Reader.as_strings('data/5/input')
    |> find_shortest()
    |> AoC.Writer.print(5, 2)
  end

  def length_after_reaction([polymer]) do
    polymer
    |> react()
    |> Enum.count()
  end

  def find_shortest([polymer]) do
    units = Enum.zip(?a..?z, ?A..?Z)
    polymer = String.to_charlist(polymer)

    units
    |> Enum.reduce([], fn x, acc ->
      [clean_and_react(polymer, x) | acc]
    end)
    |> Enum.min()
  end

  defp clean_and_react(polymer, {lower, upper}) do
    polymer
    |> Enum.reject(&(&1 === lower or &1 === upper))
    |> react()
    |> Enum.count()
  end

  def react(polymer) when is_binary(polymer), do: react([], String.to_charlist(polymer))
  def react(polymer), do: react([], polymer)

  defp react(stable, []), do: stable
  defp react([], [x | rest]), do: react([x], rest)

  defp react([x | visited], [y | rest]) do
    case react_units(x, y) do
      :nothing -> react([y, x | visited], rest)
      :annihilate -> react(visited, rest)
    end
  end

  defp react_units(x, y) do
    if String.upcase(<<x::utf8>>) === String.upcase(<<y::utf8>>) and x !== y do
      :annihilate
    else
      :nothing
    end
  end
end
