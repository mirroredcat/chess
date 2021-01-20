
require_relative "pieces"
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'

class Board

  attr_accessor :rows

  def initialize
    @rows = Array.new(8){Array.new(8){NullPiece.instance}}

    @rows[0] = [Rook.new(:B,@rows,[0,0]), 
              Knight.new(:B,@rows,[0,1]), 
              Bishop.new(:B,@rows,[0,2]), 
              Queen.new(:B,@rows,[0,3]), 
              King.new(:B,@rows,[0,4]), 
              Bishop.new(:B,@rows,[0,5]), 
              Knight.new(:B,@rows,[0,6]), 
              Rook.new(:B,@rows,[0,7]) ]
    (0..7).each do |i|                    
      @rows[1][i] = Pawn.new(:B, @rows,[1,i])
      @rows[6][i] = Pawn.new(:W, @rows,[6,i])
    end
    
    @rows[7] = [Rook.new(:W,@rows,[7,0]), 
                Knight.new(:W,@rows,[7,1]), 
                Bishop.new(:W,@rows,[7,2]), 
                Queen.new(:W,@rows,[7,3]), 
                King.new(:W,@rows,[7,4]), 
                Bishop.new(:W,@rows,[7,5]), 
                Knight.new(:W,@rows,[7,6]), 
                Rook.new(:W,@rows,[7,7]) ]

  end


  def [](pos)
    # x,y = pos
    @rows[pos]
  end

  def []=(pos,val)
    x,y = pos
    @rows[x][y] = val
  end

  def move_pieces(start_pos, end_pos)
    raise ArgumentError.new("Out of bounds") if !valid_pos(start_pos) || !valid_pos(end_pos)
    raise ArgumentError.new("There is no piece at #{start_pos}") if @rows[start_pos[0]][start_pos[1]].empty?
    raise ArgumentError.new("Piece cannot move at #{end_pos}") if !@rows[start_pos[0]][start_pos[1]].moves.flatten(1).include?(end_pos)
  

    @rows[start_pos[0]][start_pos[1]], @rows[end_pos[0]][end_pos[1]] = @rows[end_pos[0]][end_pos[1]], @rows[start_pos[0]][start_pos[1]]

    @rows[end_pos[0]][end_pos[1]].pos = end_pos

  end

  def valid_pos(pos)
    pos.all?{|pos| (0..7).include?(pos)}
  end

end
