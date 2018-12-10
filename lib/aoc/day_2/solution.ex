defmodule AoC.Day2.Solution do
  def run() do
    AoC.Reader.as_strings("data/2/input")
    |> checksum()
    |> AoC.Writer.print(2, 1)

    AoC.Reader.as_strings("data/2/input")
    |> common_letters()
    |> AoC.Writer.print(2, 2)
  end

  def checksum(ids) do
    {two_times, three_times} = count_ids_with_same_letters(ids)
    two_times * three_times
  end

  def count_ids_with_same_letters(ids) do
    count_ids_with_same_letters(ids, 0, 0)
  end

  defp count_ids_with_same_letters([], two_times, three_times) do
    {two_times, three_times}
  end

  defp count_ids_with_same_letters([id | rest], two_times, three_times) do
    case {has_same_letters?(id, 2), has_same_letters?(id, 3)} do
      {true, true} -> count_ids_with_same_letters(rest, two_times + 1, three_times + 1)
      {true, false} -> count_ids_with_same_letters(rest, two_times + 1, three_times)
      {false, true} -> count_ids_with_same_letters(rest, two_times, three_times + 1)
      {false, false} -> count_ids_with_same_letters(rest, two_times, three_times)
    end
  end

  def has_same_letters?(id, expected_number_of_same_letters) do
    id
    |> String.to_charlist()
    |> Enum.group_by(fn character -> character end)
    |> Enum.map(fn {character, character_list} -> {character, length(character_list)} end)
    |> Enum.filter(fn {_character, count} -> count === expected_number_of_same_letters end)
    |> Enum.empty?()
    |> Kernel.not()
  end

  def common_letters(ids) do
    ids
    |> search_for_ids_with_difference_one()
    |> (fn {this, that} -> common_substring(this, that) end).()
  end

  def search_for_ids_with_difference_one([]) do
    :not_found
  end

  def search_for_ids_with_difference_one([id | rest]) do
    case compare_with_remaining_ids(id, rest) do
      :not_found -> search_for_ids_with_difference_one(rest)
      found -> found
    end
  end

  defp compare_with_remaining_ids(_id, []) do
    :not_found
  end

  defp compare_with_remaining_ids(id, [next | rest]) do
    case distance(id, next) do
      1 -> {id, next}
      _ -> compare_with_remaining_ids(id, rest)
    end
  end

  def distance(this, that) do
    distance(this, that, 0)
  end

  defp distance(<<>>, <<>>, distance) do
    distance
  end

  defp distance(<<>>, that, distance) do
    distance + String.length(that)
  end

  defp distance(this, <<>>, distance) do
    distance + String.length(this)
  end

  defp distance(<<char::utf8(), this::binary()>>, <<char::utf8, that::binary()>>, distance) do
    distance(this, that, distance)
  end

  defp distance(<<_x::utf8(), this::binary()>>, <<_y::utf8(), that::binary()>>, distance) do
    distance(this, that, distance + 1)
  end

  def common_substring(this, that) do
    common_substring(this, that, <<>>)
  end

  defp common_substring(
         <<char::utf8(), this::binary()>>,
         <<char::utf8(), that::binary()>>,
         common
       ) do
    common_substring(this, that, common <> <<char::utf8()>>)
  end

  defp common_substring(<<_x::utf8(), this::binary()>>, <<_y::utf8(), that::binary()>>, common) do
    common_substring(this, that, common)
  end

  defp common_substring(_, _, common) do
    common
  end
end
