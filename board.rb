
require_relative "pieces"

class Board

  attr_accessor :rows

  def initialize
    @rows = Array.new(8){Array.new(8)}

    @rows[0] = [Rook.new(:B,@rows,[0,0]), 
              Knight.new(:B,@rows,[0,1], 
              Bishop.new(:B,@rows,[0,2], 
              Queen.new(:B,@rows,[0,3], 
              King.new(:B,@rows,[0,4], 
              Bishop.new(:B,@rows,[0,5], 
              Knight.new(:B,@rows,[0,6], 
              Rook.new(:B,@rows,[0,7] ]
    @rows[1].each_with_index{|pawn,i| pawn = Pawn.new(:B, @rows,[1,i])}

    @rows[-2].each_with_index{|pawn,i| pawn = Pawn.new(:W, @rows,[1,i])}
    @rows[-1] = [Rook.new(:W,@rows,[7,0]), 
                Knight.new(:W,@rows,[7,1], 
                Bishop.new(:W,@rows,[7,2], 
                Queen.new(:W,@rows,[7,3], 
                King.new(:W,@rows,[7,4], 
                Bishop.new(:W,@rows,[7,5], 
                Knight.new(:W,@rows,[7,6], 
                Rook.new(:W,@rows,[7,7] ]

  end


  def [](pos)
    x,y = pos
    @rows[x][y]
  end

  def []=(pos,val)
    x,y = pos
    @rows[x][y] = val
  end

  def move_pieces(start_pos, end_pos)
    raise ArgumentError.new("Out of bounds") if !valid_pos(start_pos) || !valid_pos(end_pos)
    raise ArgumentError.new("There is no piece at #{start_pos}") if @rows[start_pos[0]][start_pos[1]].nil?
    raise ArgumentError.new("Piece cannot move at #{end_pos}") if @rows[end_pos[0]][end_pos[1]] != nil
  

    piece = @rows[start_pos[0]][start_pos[1]]
    @rows[end_pos[0]][end_pos[1]] = piece

  end

  def valid_pos(pos)
    pos.all?{|pos| (0..7).include?(pos)}
  end

end
