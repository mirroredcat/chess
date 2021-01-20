require_relative 'pieces'

class King < Piece

  def symbol
    if @color == :B
      "\u265A"
    else
      "\u2654"
    end
  end

  def move_dirs
    return :queen
  end
end