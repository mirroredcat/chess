
require_relative "pieces"

class Board

  attr_accessor :rows

  def initialize
    @rows = Array.new(8){Array.new(8)}

    @rows[0] = [rook = Piece.new, knight = Piece.new, bishop = Piece.new, 
              queen = Piece.new, king = Piece.new, bishop = Piece.new, 
              knight = Piece.new, rook = Piece.new ]
    @rows[1].map!{|pawn| pawn = Piece.new}

    @rows[-2].map!{|pawn| pawn = Piece.new}
    @rows[-1] = [rook = Piece.new, knight = Piece.new, bishop = Piece.new, 
    queen = Piece.new, king = Piece.new, bishop = Piece.new, 
    knight = Piece.new, rook = Piece.new ]

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
