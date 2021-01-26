require_relative "board.rb"
require_relative "cursor"

class Display

  attr_reader :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    puts "   #{("a".."h").to_a.join(" ")}"
    @board.rows.each.with_index do |row, i|
      puts "#{8-i} #{row.join(" ")}"
    end
  end

end

