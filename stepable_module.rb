module Stepable



  def king_dirs
    x,y = self.pos
    dirs = []
    
    [0,1,-1].each do |i| 
      [0,1,-1].each do |j|
        unless x+i == x && y+j == y
          dirs << [[x+i,y+j]] if valid_pos([x+i,y+j])
        end
      end
    end
    dirs
  end

  def knight_dir
    x,y = self.pos
    dirs = []

    (-2..2).each do |i|
      unless i == 0
        if i %2 == 0
           dirs << [[x+i, y+1]] if valid_pos([x+i, y+1])
           dirs << [[x+i, y-1]] if valid_pos([x+i, y-1])
        else
          dirs << [[x+i, y+2]] if valid_pos([x+i, y+2])
          dirs << [[x+i, y-2]] if valid_pos([x+i, y-2])
        end
      end
    end
    dirs
  end

  def moves
    if self.move_dirs == :king
      return king_dirs
    else 
      return knight_dir
    end
  end

  private

  def move_dirs

  end

  def valid_pos(pos)
    pos.all?{|pos| (0..7).include?(pos)}
  end
end