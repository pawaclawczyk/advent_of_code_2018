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

  test "distance of two strings" do
    assert 0 === distance("same", "same")
    assert 4 === distance("", "abcd")
    assert 4 === distance("abcd", "")
    assert 2 === distance("abcde", "axcye")
    assert 1 === distance("fghij", "fguij")
  end

  test "search for ids with difference equal to one" do
    assert :not_found ===
             search_for_ids_with_difference_one([
               "none",
               "of",
               "these",
               "is",
               "different",
               "by",
               "one",
               "character"
             ])

    assert {"fghij", "fguij"} ===
             search_for_ids_with_difference_one([
               "abcde",
               "fghij",
               "klmno",
               "pqrst",
               "fguij",
               "axcye",
               "wvxyz"
             ])
  end

  test "get common substring" do
    assert "ace" === common_substring("abcde", "axcye")
    assert "fgij" === common_substring("fghij", "fguij")
  end
end
