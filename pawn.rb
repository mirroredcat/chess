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

  private

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
    if !@board[[x+i,y]].empty?
      return []
    else
      if at_start_row? && @board[[x+(2*i),y]].empty?
        return [[x+i,y],[x+(2*i),y]]
      else
        return [[x+i,y]]
      end
    end
  end

  def side_attacks
    x,y = @pos
    i = forward_dir
    a = [x+i, y-1] 
    b = [x+i, y+1]
    
    [a,b].select {|spot| valid_pos(spot) && !@board[spot].is_a?(NullPiece) && 
      @board[spot].color != @color}.map{|x| [x]}

  end


  def valid_pos(pos)
    pos.all?{|pos| (0..7).include?(pos)}
  end

end