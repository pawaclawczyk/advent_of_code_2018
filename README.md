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

## Day 2: Inventory Management System

[Puzzle description](https://adventofcode.com/2018/day/2)

[Input data](data/2/input)

[Solution code](lib/aoc/day_2/solution.ex)

Input file contains lines with box IDs.

In the first part we must produce checksum for the list of box IDs.
The checksum is a product of two numbers, number of IDs containing the same letter twice
and number of IDs containing the same letter three times.

To complete a solution for the puzzle we need a helper function checking
whether an ID has two (or three) same letters.
The main solution is to traverse the list and count each ID having a duplicate letter and having a letter repeated three times.

Let's start with helper function for checking if any letter in ID appears exactly two (and three) times.
We need to split the string into letters, then group the letters and count each group. If we find a group of two (three) then will return `true`.
It's worth to note that we look for *exactly* two (three) same letters, it means we must analyse every letter in ID and cannot return earlier.

In the second part of the puzzle we must find IDs that differ by exactly one character.
The difference must be position-wise, it means that ID `abcd` and `bcda` have four different characters.
To compute the number of different characters we build a distance function.
The function is recursively walking over two strings character by character increasing distance counter by one when first characters are different.
In next step program should iterate over IDs and compute distance between current element
and all remaining. Once it finds two IDs with distance equal to one then it returns.
In an imperative language for this purpose we would use a nested for loops.
However, we will use two recursive functions, one for the outer iteration and second for the inner iteration and computing distance.
As the expected result is only the common part of found IDs, function similar to the one computing distance will do that for us.

## Day 3: No Matter How You Slice It

[Puzzle description](https://adventofcode.com/2018/day/3)

Todays puzzle may seem quiet difficult.
The input is a list of rectangle surface.
The challenge is to compute the area of overlapping surfaces.

So far I've came up with two algorithms.

The first algorithm converts a rectangle definitions into functions returning if given point is inside a shape.
In the second step each point on the available surface is checked by every function, then points marked by more than 1 rectangle are counted.
In order to cover the whole area we must find the lowest most right point used.

The second algorithm will iterate over rectangle definitions, convert it to list of points then increment a value in map where the point is a key.
Next it counts the keys with value greater than 1.

Which one is better? Let's analyse memory and computation complexity.

Given N rectangle definitions and the area consiting of M points.

Algorithm 1:
 - memory contains N functions and M points
 - it iterates over N rectangle definition to produce functions, then iterate over M points, because thes two operation are done in a sequance we have complecity of O(N + M)
 
Algorithm 2:
 - memory contains a map of M points
 - the worst case, quiet impossible, is that each rectangle is defined as a full available area - it gives the complexity of N * M as we increment for every point covered by every rectangle
