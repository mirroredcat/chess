require_relative 'pieces'
require_relative 'slideable_module'

class Bishop < Piece
  include Slideable

  def symbol
    if @color == :B
      "\u265D"
    else
      "\u2657"
    end
  end

  def move_dirs
    :diagonal
  end
end
