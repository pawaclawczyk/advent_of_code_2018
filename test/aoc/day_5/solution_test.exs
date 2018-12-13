defmodule AoC.Day5.SolutionTest do
  use ExUnit.Case
  import AoC.Day5.Solution, only: :functions

  test "do polymer reaction" do
    assert 'Z' === react("abBAZ")
  end

  test "polymer length after reaction" do
    assert 10 === length_after_reaction(["dabAcCaCBAcCcaDA"])
    assert 0 === length_after_reaction(["abcdeEDCBA"])
    assert 1 === length_after_reaction(["zabcdeEDCBA"])
    assert 1 === length_after_reaction(["abcdeEDCBAZ"])
  end
end
