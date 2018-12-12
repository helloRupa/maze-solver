# Get file from user, convert it to array to provide to solver
class MazeReader
  private_class_method :new

  def self.make_array(filename)
    file = MazeReader.valid_file(filename)
    maze_array = []
    File.foreach(file) do |line|
      line_arr = []
      # Must keep empty spaces, split will remove them
      line.chomp.chars { |char| line_arr << char }
      maze_array << line_arr
    end
    maze_array
  end

  def self.valid_file(filename)
    until filename.end_with?('.txt') && File.file?(filename) && MazeReader.valid_contents?(filename)
      puts 'Please provide a txt file containing only *, S and E chars.'
      filename = gets.chomp
    end
    filename
  end

  def self.valid_contents?(filename)
    File.foreach(filename) do |line|
      return false unless line.chomp.count('*SE ') == line.chomp.length
    end
    true
  end
end

if $PROGRAM_NAME == __FILE__
  arr = MazeReader.make_array('maze1.txt')
  arr.each { |line| p line }
end