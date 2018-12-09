defmodule AoC.Reader do
  def as_integers(path) do
    as_lines(path)
    |> Enum.map(&String.trim/1)
    |> skip_empty_lines()
    |> Enum.map(&String.to_integer/1)
  end

  defp as_lines(path) do
    path
    |> File.read!()
    |> String.split("\n")
  end

  def skip_empty_lines(lines) do
    lines |> Enum.reject(&(String.length(&1) === 0))
  end
end
