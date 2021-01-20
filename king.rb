require_relative 'pieces'
require_relative 'stepable_module'

class King < Piece

  include Stepable
  def symbol
    if @color == :B
      "\u265A"
    else
      "\u2654"
    end
  end

  def move_dirs
    return :king
  end
end