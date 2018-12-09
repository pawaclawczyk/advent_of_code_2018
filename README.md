# Adevent of Code 2018

```
iex -S mix

iex> AoC.Day[number of the day].Solution.run()
```

## Day 1: Chronal Calibration

[Puzzle description](https://adventofcode.com/2018/day/1)

[Input data](data/1/input)

[Solution code](lib/aoc/day_1/solution.ex)

Input file contains lines with an integer representing consecutive frequency changes.
The initial frequnecy is 0. The puzzle solution is the resulting frequency.

The solution is to apply next change to current state and return last state.
As the initial state is 0 and a change is an integer to add to current state,
the solution can be reduced to a sum of a list of changes.
To achieve that can simply use `Enum.sum` function.

Second part of the puzzle is to find first frequency that is reached twice.
An important note for this puzzle is that list of frequency change is repeated infinitelly.
The solution traverses the frequency change list while keeping track of all reached frequencies
and the current frequency. In each step new frequency is computed and compared with visited ones.

Hint: The initial frequency is also a reached frequency.


