defmodule AoC.Day6.Solution2Test do
  use ExUnit.Case
  import AoC.Day6.Solution

  @a {1, 1}
  @b {1, 6}
  @c {8, 3}
  @d {3, 4}
  @e {5, 5}
  @f {8, 9}

  @positions [@a, @b, @c, @d, @e, @f]

  test "example for part 1" do
    assert 17 === part_1(@positions)
  end

  test "example for part 2" do
    assert 16 === part_2(@positions, 32)
  end
end
