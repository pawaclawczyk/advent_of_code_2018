defmodule AoC.Day6.Solution do
  def run() do
    AoC.Reader.as_strings("data/6/input")
    |> Enum.map(&coordinate/1)
    |> part_1()
    |> AoC.Writer.print(6, 1)

    AoC.Reader.as_strings("data/6/input")
    |> Enum.map(&coordinate/1)
    |> part_2(10_000)
    |> AoC.Writer.print(6, 2)
  end

  defp coordinate(string) do
    string
    |> String.split(", ")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def part_1(positions) do
    finite_area = finite_area(positions)

    positions
    |> boundries()
    |> fields()
    |> Enum.map(&closest(&1, positions))
    |> Enum.group_by(fn {_, owner} -> owner end)
    |> Enum.map(fn {owner, fields} -> {owner, Enum.count(fields)} end)
    |> Enum.filter(fn {owner, _} -> owner in finite_area end)
    |> Enum.map(fn {_, area} -> area end)
    |> Enum.max()
  end

  def part_2(positions, max_distance) do
    positions
    |> boundries()
    |> fields()
    |> Enum.map(&total_distance(&1, positions))
    |> Enum.filter(&(&1 < max_distance))
    |> Enum.count()
  end

  defp finite_area(positions) do
    {left, top, right, bottom} = boundries(positions)

    open_areas_left_right =
      for y <- top..bottom do
        outer_point_left = {left - 1, y}
        {_, open_area_left} = closest(outer_point_left, positions)

        outer_point_right = {right + 1, y}
        {_, open_area_right} = closest(outer_point_right, positions)

        [open_area_left, open_area_right]
      end

    open_areas_up_down =
      for x <- left..right do
        outer_point_up = {x, top - 1}
        {_, open_area_up} = closest(outer_point_up, positions)

        outer_point_down = {x, bottom + 1}
        {_, open_area_down} = closest(outer_point_down, positions)

        [open_area_up, open_area_down]
      end

    open_positions =
      (open_areas_left_right ++ open_areas_up_down)
      |> List.flatten()
      |> Enum.uniq()

    positions -- open_positions
  end

  defp boundries(positions) do
    {horizontal, vertical} = Enum.unzip(positions)

    {Enum.min(horizontal), Enum.min(vertical), Enum.max(horizontal), Enum.max(vertical)}
  end

  defp closest(point, positions) do
    {owner, _distance} =
      positions
      |> Enum.reduce(nil, fn
        position, nil ->
          {position, distance(position, point)}

        position, {owner, distance} ->
          case distance(position, point) do
            position_distance when position_distance < distance -> {position, position_distance}
            position_distance when position_distance == distance -> {:common, position_distance}
            _ -> {owner, distance}
          end
      end)

    {point, owner}
  end

  defp distance({a, b}, {c, d}), do: abs(a - c) + abs(b - d)

  defp fields({left, top, right, bottom}) do
    for x <- left..right, y <- top..bottom, do: {x, y}
  end

  defp total_distance(point, positions) do
    positions
    |> Enum.map(&distance(&1, point))
    |> Enum.sum()
  end
end
