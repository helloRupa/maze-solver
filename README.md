# MAZE SOLVER

Written in Ruby. Find the shortest path through a maze provided in text file format, where asterisks (*) denote walls and barriers, the beginning is denoted by an "S" and the end by "E".

Shortest path is shown in "X"s in the command line.

## WHAT IS IT GOOD FOR?

This is not the most efficient approach. It will work quickly (seemingly instantly) for mazes where the open spaces are narrow, and will take more time for mazes with wide open spaces. For example, 'maze1.txt' takes roughly 32 seconds to solve, while 'maze_test3.txt' is solved almost instantly.

## HOW IT WORKS

The maze is solved via a recursive method that attempts to find every valid path from the beginning to the end. Instead of allowing every path to complete, if a path is found to have certain inefficiencies (snaking, going backward, traveling in a circle), that path is abandoned. Paths that run into walls or go outside the maze's boundaries are also abandoned.

## DEFINITIONS: SNAKING, TRAVELING IN A CIRCLE

A path is considered to snake if it traverses an existing x or y point unnecessarily, i.e. it needlessly turns back on itself when there is no wall to avoid. Example: [[0, 0], [0, 1], [1, 1], [2, 1], [2, 0]], if there is no wall between [0, 0] and [2, 0], the path is a snake.

A path is traveling in a circle if it contains 2 points stacked upon another 2 points. Example: [[0, 0], [0, 1], [1, 1], [1, 0]]

## FURTHER IMPROVEMENTS

Aside from implementing an existing algorithm, this specific approach could be further improved by defining other characteristics of a bad or inefficient path. This would lead to abandoing more paths as they are being built, which would reduce the run time for mazes with wide open spaces. However, it would likely increase runtime slightly for mazes with narrow open spaces, since more checks would be performed.

One possible improvement would be to define a stair-stepping method that looks for unnecessary stair-stepping within paths. Example: [0, 0], [0, 1], [0, 2], [1, 2], [1, 3], [1, 4] would be an unnecessary stair-step if the path were not attempting to get around walls.