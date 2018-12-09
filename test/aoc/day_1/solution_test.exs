defmodule AoC.Day1.SolutionTest do
  use ExUnit.Case
  import AoC.Day1.Solution, only: [resulting_frequency: 1, frequency_reached_twice: 1]

  test "compute resulting frequency" do
    assert 3 === resulting_frequency([+1, -2, +3, +1])
  end

  test "find frequency reached twice" do
    assert 2 === frequency_reached_twice([+1, -2, +3, +1])
    assert 0 === frequency_reached_twice([+1, -1])
    assert 10 === frequency_reached_twice([+3, +3, +4, -2, -4])
    assert 5 === frequency_reached_twice([-6, +3, +8, +5, -6])
    assert 14 === frequency_reached_twice([+7, +7, -2, -7, -4])
  end
end
