defmodule AoC.Day4.Solution do
  def run() do
    AoC.Reader.as_strings("data/4/input")
    |> strategy_1()
    |> AoC.Writer.print(4, 1)

    AoC.Reader.as_strings("data/4/input")
    |> strategy_2()
    |> AoC.Writer.print(4, 2)
  end

  def strategy_1(log) do
    sleep_schedule =
      log
      |> Enum.map(&parse/1)
      |> Enum.sort_by(&hd/1)
      |> Enum.reduce({%{}, nil, false, nil}, &build_sleep_schedule/2)
      |> elem(0)

    guard_id = most_asleep_guard(sleep_schedule)
    minute = most_sleepy_minute(sleep_schedule, guard_id)

    guard_id * minute
  end

  def strategy_2(log) do
    sleep_schedule =
      log
      |> Enum.map(&parse/1)
      |> Enum.sort_by(&hd/1)
      |> Enum.reduce({%{}, nil, false, nil}, &build_sleep_schedule/2)
      |> elem(0)

    {guard_id, minute} = most_sleepy_minute(sleep_schedule)

    guard_id * minute
  end

  defp parse(log_record) do
    [date, info_string] =
      log_record
      |> String.split(["[", "] "], trim: true)

    [date, minute(date), info(info_string)]
  end

  defp minute(date) do
    [_, minute] = date |> String.split(":")
    minute |> String.to_integer()
  end

  defp info("wakes up"), do: :wakes_up
  defp info("falls asleep"), do: :falls_asleep
  defp info(info_string), do: Regex.run(~r/\d+/, info_string) |> hd() |> String.to_integer()

  defp build_sleep_schedule([_, minute, :wakes_up], {schedule, guard, true, since}) do
    new_schedule =
      since..(minute - 1)
      |> Enum.reduce(schedule, &increment_at(&1, &2, guard))
      |> increment_total(guard, minute - since)

    {new_schedule, guard, false, nil}
  end

  defp build_sleep_schedule([_, minute, :falls_asleep], {schedule, guard, false, _}) do
    {schedule, guard, true, minute}
  end

  defp build_sleep_schedule([_, _, new_guard], {schedule, _, _, _}) do
    {schedule, new_guard, false, nil}
  end

  defp increment_at(minute, schedule, guard), do: Map.update(schedule, {guard, minute}, 1, &inc/1)

  defp increment_total(schedule, guard, minutes),
    do: Map.update(schedule, {guard, :total}, minutes, &Kernel.+(&1, minutes))

  defp inc(x), do: x + 1

  defp most_asleep_guard(schedule) do
    schedule
    |> Enum.filter(fn
      {{_, :total}, _} -> true
      _ -> false
    end)
    |> Enum.sort_by(&elem(&1, 1), &Kernel.>/2)
    |> hd()
    |> elem(0)
    |> elem(0)
  end

  defp most_sleepy_minute(schedule) do
    schedule
    |> Enum.filter(fn
      {{_, :total}, _} -> false
      _ -> true
    end)
    |> Enum.sort_by(&elem(&1, 1), &Kernel.>/2)
    |> hd()
    |> elem(0)
  end

  defp most_sleepy_minute(schedule, guard_id) do
    schedule
    |> Enum.filter(fn
      {{_, :total}, _} -> false
      {{^guard_id, _}, _} -> true
      _ -> false
    end)
    |> Enum.sort_by(&elem(&1, 1), &Kernel.>/2)
    |> hd()
    |> elem(0)
    |> elem(1)
  end
end
