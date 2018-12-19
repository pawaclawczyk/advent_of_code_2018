defmodule AoC.Day7.Solution do
  defmodule Worker do
    defstruct task: :idle, remaining: 0
  end

  def run do
    AoC.Reader.as_strings("data/7/input")
    |> parse_edges()
    |> part_1()
    |> AoC.Writer.print(7, 1)

    AoC.Reader.as_strings("data/7/input")
    |> parse_edges()
    |> part_2()
    |> AoC.Writer.print(7, 2)
  end

  defp parse_edges(lines) when is_list(lines), do: lines |> Enum.map(&parse_edges/1)

  defp parse_edges(string) when is_binary(string) do
    [_, x, y] =
      Regex.run(~r/Step ([A-Z]) must be finished before step ([A-Z]) can begin./, string)

    {x, y}
  end

  defp part_1(edges) do
    {from, to} =
      edges
      |> Enum.unzip()

    nodes =
      (from ++ to)
      |> Enum.uniq()
      |> Enum.sort()

    outer_loop([], nodes, edges)
  end

  defp outer_loop(collected, [], _), do: collected |> Enum.reverse() |> List.to_string()

  defp outer_loop(collected, remaining, edges) do
    node = inner_loop(remaining, collected, edges)

    outer_loop([node | collected], List.delete(remaining, node), edges)
  end

  defp inner_loop([guess | rest], collected, edges) do
    fits? =
      find_dependecies(guess, edges)
      |> Enum.all?(&(&1 in collected))

    case fits? do
      true -> guess
      false -> inner_loop(rest, collected, edges)
    end
  end

  defp find_dependecies(node, edges) do
    edges
    |> Enum.filter(fn
      {_, ^node} -> true
      _ -> false
    end)
    |> Enum.map(fn {x, _} -> x end)
  end

  @workers 5

  def part_2(edges) do
    waiting =
      part_1(edges)
      |> String.codepoints()

    {workers, new_waiting} =
      1..@workers
      |> Enum.map(fn _ -> %Worker{} end)
      |> Enum.reduce({[], waiting}, &plan_work(&1, &2, [], edges))

    simulate(1, workers, new_waiting, [], edges)
  end

  defp simulate(time, workers, waiting, done, edges) do
    {new_workers, new_waiting, new_done} = work_all(workers, waiting, done, edges)

    case done?(new_waiting, new_workers) do
      true -> time
      false -> simulate(time + 1, new_workers, new_waiting, new_done, edges)
    end
  end

  defp work_all(workers, waiting, done, edges) do
    {new_workers, done_steps} =
      workers
      |> Enum.map(&do_work/1)
      |> Enum.unzip()

    new_done = done ++ done_steps

    {planned_workers, new_waiting} =
      new_workers
      |> Enum.reduce({[], waiting}, &plan_work(&1, &2, new_done, edges))

    {planned_workers, new_waiting, new_done}
  end

  defp do_work(worker = %Worker{task: :idle}), do: {worker, nil}

  defp do_work(worker = %Worker{remaining: 1, task: done}),
    do: {%{worker | task: :idle, remaining: 0}, done}

  defp do_work(worker = %Worker{remaining: n}), do: {%{worker | remaining: n - 1}, nil}

  defp plan_work(worker = %Worker{task: :idle}, {workers, waiting}, done, edges) do
    {task, new_waiting} = find_work(waiting, done, edges)
    time = compute_time(task)

    {
      [%{worker | task: task, remaining: time} | workers],
      new_waiting
    }
  end

  defp plan_work(worker, {workers, waiting}, _, _), do: {[worker | workers], waiting}

  defp find_work(waiting, done, edges) do
    task = find_work_loop(waiting, done, edges)

    {task, List.delete(waiting, task)}
  end

  defp find_work_loop([], _, _), do: :idle

  defp find_work_loop([task | rest], done, edges) do
    case find_dependecies(task, edges) -- done do
      [] -> task
      _ -> find_work_loop(rest, done, edges)
    end
  end

  defp compute_time(:idle), do: 0
  defp compute_time(<<step::utf8()>>), do: step - ?A + 61

  defp done?([], workers) do
    workers
    |> Enum.all?(&(&1.task === :idle))
  end

  defp done?(_, _), do: false
end
