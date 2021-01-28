require_relative 'pieces'
require_relative 'slideable_module'

class Rook < Piece
  include Slideable

  def symbol
    if @color == :B
      "\u265C"
    else
      "\u2656"
    end
  end

  def move_dirs
    :horizontal
  end
end
