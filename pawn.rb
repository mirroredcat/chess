require_relative 'pieces'

class Pawn < Piece

  def symbol
    if @color == :B
      "\u265F"
    else
      "\u2659"
    end
  end

  def moves
    side_attacks << forward_steps
  end

  # private

  def at_start_row?
    return true if @pos[0] == 1 && @color == :B || @pos[0] == 6 && @color == :W
    false
  end

  def forward_dir
    if @color == :B
      return +1
    else
      return -1
    end
  end

  def forward_steps
    x, y = @pos
    i = forward_dir
    if at_start_row?
      return [[x+i,y], [x+(2*i),y]]
    else
      return [[x+i,y]]
    end

  end

  def side_attacks
    x,y = @pos
    i = forward_dir
    return [[[x+i, y-1 ]], [[x+i, y+1]]]
  end

end