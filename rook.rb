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

  private


  def move_dirs
    return :horizontal
  end

end