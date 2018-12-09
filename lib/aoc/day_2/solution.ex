defmodule AoC.Day2.Solution do
  def run() do
    AoC.Reader.as_strings("data/2/input")
    |> checksum()
    |> AoC.Writer.print(2, 1)
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
end
