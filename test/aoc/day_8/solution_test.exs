defmodule AoC.Day8.SolutionTest do
  use ExUnit.Case
  import AoC.Day8.Solution

  test "root node with single metadata" do
    assert 42 === part_1([0, 1, 42])
  end

  test "root node with multiple metadata" do
    assert 41 === part_1([0, 3, 11, 13, 17])
  end

  test "root with two children" do
    assert 41 === part_1([2, 1, 0, 1, 11, 0, 1, 13, 17])
  end

  test "sum of metadata" do
    assert 138 === part_1([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2])
  end

  test "value of leaf" do
    assert 41 === part_2([0, 3, 11, 13, 17])
  end

  test "value of tree" do
    assert 66 === part_2([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2])
  end
end
