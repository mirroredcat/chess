require_relative 'board'
require_relative 'pieces'


class ComputerPlayer
  attr_reader :name, :color

  def initialize(board)
    @name = 'Chess-o-tron 3000'
    @color = :B
    @board = board
    @pieces = @board.rows.flatten.select { |el| el.color == @color }
    @count = 0
    @selected = nil
  end

  def make_move
    if @count == 0
      @selected = @pieces.sample
      while @selected.valid_moves.empty?
        @selected = @pieces.sample
      end
      @count = 1
      @selected.pos
    else
      @count = 0
      @selected.valid_moves.sample
    end
  end
end
