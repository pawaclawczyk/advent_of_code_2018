defmodule AoC.Day2.SolutionTest do
  use ExUnit.Case
  import AoC.Day2.Solution, only: :functions

  test "letter appears exactly two times" do
    assert false === has_same_letters?("abcdef", 2)
    assert true === has_same_letters?("bababc", 2)
    assert true === has_same_letters?("abbcde", 2)
    assert false === has_same_letters?("abcccd", 2)
    assert true === has_same_letters?("aabcdd", 2)
    assert true === has_same_letters?("abcdee", 2)
    assert false === has_same_letters?("ababab", 2)
  end

  test "letter appears exactly three times" do
    assert false === has_same_letters?("abcdef", 3)
    assert true === has_same_letters?("bababc", 3)
    assert false === has_same_letters?("abbcde", 3)
    assert true === has_same_letters?("abcccd", 3)
    assert false === has_same_letters?("aabcdd", 3)
    assert false === has_same_letters?("abcdee", 3)
    assert true === has_same_letters?("ababab", 3)
  end

  test "count ids with two and three letters" do
    ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]

    assert {4, 3} === count_ids_with_same_letters(ids)
  end

  test "compute checksum" do
    ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]

    assert 12 === checksum(ids)
  end
end
