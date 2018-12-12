# Find shortest path through maze
require_relative './maze_reader.rb'
require_relative './maze_printer.rb'

class MazeSolver
  GOAL = 'E'.freeze
  START = 'S'.freeze
  WALL = '*'.freeze

  attr_reader :maze_arr

  private_class_method :new

  def initialize(filename)
    @maze_arr = MazeReader.make_array(filename)
    @rows = @maze_arr.length
    @cols = @maze_arr[0].length
  end

  def self.solve(filename)
    maze = new(filename)
    MazePrinter.print_maze(maze.maze_arr)
    puts
    all_paths = maze.find_paths(maze.find_start)
    shortest = maze.shortest_path(all_paths)
    MazePrinter.show_path(maze.maze_arr, shortest, START, GOAL)
  end

  def find_paths(coords, path = [], all_paths = [])
    return if bad_location?(coords, path)

    if goal?(coords)
      all_paths << path
      return
    end

    parent_path = update_path(coords, path)

    possible_moves(coords).each do |point|
      find_paths(point, parent_path, all_paths)
    end
    all_paths
  end

  def update_path(coords, path)
    parent_path = path[0..-1]
    parent_path << coords
    parent_path
  end

  def bad_location?(coords, path)
    !in_bounds?(coords) || wall?(coords) || path.include?(coords) || \
      in_circle?(coords, path) || inefficient_path?(coords, path)
  end

  def inefficient_path?(coords, path)
    return true if should_have_been_horizontal?(coords, path)
    should_have_been_vertical?(coords, path)
  end

  def should_have_been_horizontal?(coords, path)
    y = coords[0]
    x = coords[1]

    unless path.include?([y, x - 1])
      (x - 1).downto(0) do |col|
        break if wall?([y, col])
        return true if path.include?([y, col])
      end
    end

    unless path.include?([y, x + 1])
      (x + 1...@cols).each do |col|
        break if wall?([y, col])
        return true if path.include?([y, col])
      end
    end
    false
  end

  def should_have_been_vertical?(coords, path)
    y = coords[0]
    x = coords[1]

    unless path.include?([y - 1, x])
      (y - 1).downto(0) do |row|
        break if wall?([row, x])
        return true if path.include?([row, x])
      end
    end

    unless path.include?([y + 1, x])
      (y + 1...@rows).each do |row|
        break if wall?([row, x])
        return true if path.include?([row, x])
      end
    end
    false
  end

  def in_circle?(coords, path)
    y = coords[0]
    x = coords[1]

    if path.include?([y, x - 1])
      return true if path.include?([y - 1, x - 1]) && path.include?([y - 1, x])
      return true if path.include?([y + 1, x]) && path.include?([y + 1, x - 1])
    elsif path.include?([y, x + 1])
      return true if path.include?([y - 1, x + 1]) && path.include?([y - 1, x])
      return true if path.include?([y + 1, x]) && path.include?([y + 1, x + 1])
    end
    false
  end

  def goal?(coords)
    y = coords[0]
    x = coords[1]
    @maze_arr[y][x] == GOAL
  end

  def wall?(coords)
    y = coords[0]
    x = coords[1]
    @maze_arr[y][x] == WALL
  end

  def in_bounds?(coords)
    y = coords[0]
    x = coords[1]
    (0...@rows).cover?(y) && (0...@cols).cover?(x)
  end

  def possible_moves(coords)
    y = coords[0]
    x = coords[1]
    [[y - 1, x], [y + 1, x], [y, x + 1], [y, x - 1]]
  end

  def find_start
    @maze_arr.each_with_index do |line, row|
      return [row, line.index('S')] if line.include?('S')
    end
  end

  def shortest_path(all_paths)
    all_paths.min_by(&:length)
  end
end

if $PROGRAM_NAME == __FILE__
  MazeSolver.solve('small_maze.txt')
  puts '-------------------------'
  MazeSolver.solve('maze_test2.txt')
  puts '-------------------------'
  MazeSolver.solve('maze_test3.txt')
end
