defmodule AoC.Day3.SolutionTest do
  use ExUnit.Case
  import AoC.Day3.Solution, only: :functions

  test "compute shared area" do
    input = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

    assert 4 === shared_area(input)
  end

  test "find independent rectangle" do
    input = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

    assert 3 === independent_area(input)
  end
end
