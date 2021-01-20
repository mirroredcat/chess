require_relative 'pieces'

class Knight < Piece

  def symbol
    if @color == :B
      "\u265E"
    else
      "\u2658"
    end
  end

  def move_dirs
    return :knight
  end
end