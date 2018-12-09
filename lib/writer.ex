defmodule AoC.Writer do
  def print(solution, day, part) when is_integer(day) and is_integer(part) do
    IO.puts("""
    The solution for first part of Day #{day} puzzle is: #{inspect(solution)}
    """)
  end
end
