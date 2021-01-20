require_relative 'pieces'
require_relative 'slideable_module'

class Queen < Piece
  include Slideable

  def symbol
    if @color == :B
      "\u265B"
    else
      "\u2655"
    end
  end

  private

  def move_dirs
    return :queen
  end

end