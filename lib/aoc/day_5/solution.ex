defmodule AoC.Day5.Solution do
  def run() do
    AoC.Reader.as_strings('data/5/input')
    |> length_after_reaction()
    |> AoC.Writer.print(5, 1)
  end

  def length_after_reaction([polymer]) do
    polymer
    |> react()
    |> Enum.count()
  end

  def react(polymer), do: react([], String.to_charlist(polymer))

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
