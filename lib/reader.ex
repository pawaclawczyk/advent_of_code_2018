defmodule AoC.Reader do
  def as_integers(path) do
    as_strings(path)
    |> Enum.map(&String.to_integer/1)
  end

  def as_strings(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> skip_empty_lines()
  end

  def skip_empty_lines(lines) do
    lines |> Enum.reject(&(String.length(&1) === 0))
  end
end
