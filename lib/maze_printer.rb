class MazePrinter
  private_class_method :new

  def self.print_maze(maze_arr)
    maze_arr.each { |line| p line }
  end

  def self.update_maze(maze_arr, path, start, goal)
    path.each do |coords|
      y = coords[0]
      x = coords[1]
      maze_arr[y][x] = 'X' unless MazePrinter.start_or_end?(maze_arr, coords, start, goal)
    end
  end

  def self.show_path(maze_arr, path, start, goal)
    update_maze(maze_arr, path, start, goal)
    print_maze(maze_arr)
  end

  def self.start_or_end?(maze_arr, coords, start, goal)
    y = coords[0]
    x = coords[1]
    maze_arr[y][x] == start || maze_arr[y][x] == goal
  end
end
