require_relative 'pieces'
require_relative 'stepable_module'

class Knight < Piece

  include Stepable

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