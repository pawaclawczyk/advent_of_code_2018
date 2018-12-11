defmodule AoC.Day3.Solution do
  def run() do
    AoC.Reader.as_strings("data/3/input")
    |> shared_area()
    |> AoC.Writer.print(3, 1)

    AoC.Reader.as_strings("data/3/input")
    |> independent_area()
    |> AoC.Writer.print(3, 2)
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

  def independent_area(input) do
    named_rectangles = input |> Enum.map(&parse_with_name/1)
    rectangles = named_rectangles |> Enum.map(&elem(&1, 1))

    find_independent(named_rectangles, rectangles)
  end

  def find_independent([], _rectangles) do
    :not_found
  end

  def find_independent([{name, subject} | rest], rectangles) do
    case overlapping_any?(subject, rectangles) do
      true -> find_independent(rest, rectangles)
      false -> name
    end
  end

  def parse_with_name(string) do
    [name | rectangle] =
      string
      |> String.split(["#", "@", ",", ":", "x"], trim: true)
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)

    {name, List.to_tuple(rectangle)}
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

  def overlapping_any?(_subject, []) do
    false
  end

  def overlapping_any?(subject, [rectangle | rest]) do
    case overllaping?(subject, rectangle) do
      true -> true
      false -> overlapping_any?(subject, rest)
    end
  end

  def overllaping?(same, same) do
    false
  end

  def overllaping?(this, that) do
    this
    |> rectangle_to_corners()
    |> Enum.map(&inside?(&1, that))
    |> Enum.reduce(false, &Kernel.or/2) or
      that
      |> rectangle_to_corners()
      |> Enum.map(&inside?(&1, this))
      |> Enum.reduce(false, &Kernel.or/2)
  end

  def rectangle_to_corners({left, top, width, height}) do
    right = left + width - 1
    bottom = top + height - 1

    [{left, top}, {right, top}, {left, bottom}, {right, bottom}]
  end

  def inside?(square, rectangle) do
    {x, y} = square
    {left, top, width, height} = rectangle

    x >= left and x < left + width and y >= top and y < top + height
  end
end
