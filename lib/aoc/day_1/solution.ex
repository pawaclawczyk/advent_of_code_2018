defmodule AoC.Day1.Solution do
  def run() do
    AoC.Reader.as_integers("data/1/input")
    |> resulting_frequency()
    |> AoC.Writer.print(1, 1)

    AoC.Reader.as_integers("data/1/input")
    |> frequency_reached_twice()
    |> AoC.Writer.print(1, 2)
  end

  def resulting_frequency(changes) do
    changes |> Enum.sum()
  end

  def frequency_reached_twice(changes) do
    frequency_reached_twice(changes, [], MapSet.new([0]), 0)
  end

  defp frequency_reached_twice(changes, [], visited, current_frequency) do
    frequency_reached_twice(changes, changes, visited, current_frequency)
  end

  defp frequency_reached_twice(changes, [change | rest], visited, current_frequency) do
    frequency = current_frequency + change

    case MapSet.member?(visited, frequency) do
      true ->
        frequency

      false ->
        frequency_reached_twice(changes, rest, MapSet.put(visited, frequency), frequency)
    end
  end
end
