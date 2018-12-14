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

[Input data](data/3/input)

[Solution code](lib/aoc/day_3/solution.ex)

Todays puzzle may seem quiet difficult.
The input is a list of rectangle surface.
The challenge is to compute the area of overlapping surfaces.

The solution will be simple.
An rectange surface is defined by position of left-top square and width and height.
This form can be converted into list of position of every square in such rectangle.
All we have to do is to count how many times each square position appears
then count theses positions which appear more than once.

In the second part we must find the rectangle that is not overllaping with any other.
I found no better solution than comparing each pair of rectangles in the input.
Instead of loops I use recursive iteration and return as soon as first overllaping rectangle is found.
An interesting part is how overlapping is verified - if any of the corners of one rectangle is inside of the other
then they are overlapping. We must check this relation in both directions.

## Day 4: Repose Record

[Puzzle description](https://adventofcode.com/2018/day/4)

[Input data](data/4/input)

[Solution code](lib/aoc/day_4/solution.ex)

Todays challange is about computing few things aout of given log.
In log we can find three types of information, when new guard begins shift, when guard falls asleep
and when guard wakes up.
Each record has data and time information.
Unfortunatelly records about waking up and falling asleep do not contain direct information about the guard.
We must infer it from the earlier records.
One more difficulty is that log is not sorted.

That's how the input looks like. Now find out what value do we need to compute.
In the first strategy we must find guard that has the most minutes asleep
and what minute does the guard spend asleep the most.
In the second strategy we must find which guard is most frequently asleep on the same minute.

To answer these question we build a sleep schedule of all guards.
The schedule is a map where a key is a pair - guard identifier and a minute,
and the value is number of how many times the guard was asleep in that minute.
Additionally we will keep track of total number of minutes when guard was asleep.
It's not necessery and can be computed out of the remaing data by simply summing up all the minute records.

Having such sleep schedule makes finding the numbers needed for solution very easy.
Let's focuse then on building the sleep schedule.
We need to traverse the log chronologically, so it must be sorted first by a date.
Going through records we mst keep track of which guard is currently on shift,
whether he is asleep or awake, and since when is he asleep.
The information is set and used when processing different records.

- On "begins shift" put the guide identifier and set to awake.
- On "falls asleep" set to asleep and set the current minute in the log.
- On "wakes up" update the sleep schedule as we have the guard id and the minute he falls asleep and set to awake.

The only remaining feature is parsing the log records to extract all required information.

## Day 5: Alchemical Reduction

[Puzzle description](https://adventofcode.com/2018/day/5)

[Input data](data/5/input)

[Solution code](lib/aoc/day_5/solution.ex)

Today's algorithm operates on long string, in our case it will be list of characters.
We can do two operations:
 - continue processing without change,
 - delete units with the same type but different polarization.
The solution is to walk over the list from left to right by two elements.

```
(ab)cde
a(bc)de
ab(cd)e
abc(de)
...
```

In case when removing currently check pair, as a next pair we must take a previous unit and the next unit.

```
(ab)cCde
a(bc)Cde
ab(cC)de
a(bd)e
ab(de)
```

Once we iterate over the list we have the shortest polymer.

In second part we must find a unit type that prevents the polymer from collapsing more.
To solve this we will iterate over list of characters from A to Z and compute the shortest polymer after removing that unit.
