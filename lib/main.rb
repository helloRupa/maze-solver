require_relative './maze_solver.rb'

puts 'Please provide a maze file in txt format:'
filename = gets.chomp
MazeSolver.solve(filename)