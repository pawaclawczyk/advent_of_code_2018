defmodule AoC.Day3.Solution do
  def run() do
    AoC.Reader.as_strings("data/3/input")
    |> shared_area()
    |> AoC.Writer.print(3, 1)
  end

  def shared_area(input) do
    input
    |> Enum.map(&parse/1)
    |> Enum.flat_map(&area_to_squares/1)
    |> Enum.reduce(%{}, fn square, acc -> Map.update(acc, square, 1, &(&1 + 1)) end)
    |> Map.values()
    |> Enum.filter(&(&1 > 1))
    |> Enum.count()
  end

  def parse(string) do
    string
    |> String.split(["@", ",", ":", "x"])
    |> Enum.drop(1)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def area_to_squares({left, top, width, height}) do
    for x <- left..(left + width - 1), y <- top..(top + height - 1), do: {x, y}
  end
end
