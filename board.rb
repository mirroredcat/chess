require_relative 'pieces'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'null_piece'
require_relative 'display'

require 'byebug'

class Board
  attr_accessor :rows

  def initialize
    @rows = Array.new(8) { Array.new(8) { NullPiece.instance } }

    @rows[0] = [Rook.new(:B, self, [0, 0]),
                Knight.new(:B, self, [0, 1]),
                Bishop.new(:B, self, [0, 2]),
                Queen.new(:B, self, [0, 3]),
                King.new(:B, self, [0, 4]),
                Bishop.new(:B, self, [0, 5]),
                Knight.new(:B, self, [0, 6]),
                Rook.new(:B, self, [0, 7])]
    (0..7).each do |i|
      @rows[1][i] = Pawn.new(:B, self, [1, i])
      @rows[6][i] = Pawn.new(:W, self, [6, i])
    end

    @rows[7] = [Rook.new(:W, self, [7, 0]),
                Knight.new(:W, self, [7, 1]),
                Bishop.new(:W, self, [7, 2]),
                Queen.new(:W, self, [7, 3]),
                King.new(:W, self, [7, 4]),
                Bishop.new(:W, self, [7, 5]),
                Knight.new(:W, self, [7, 6]),
                Rook.new(:W, self, [7, 7])]
  end

  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @rows[x][y] = val
  end

  def move_pieces(start_pos, end_pos)
    raise ArgumentError, 'Out of bounds' if !valid_pos(start_pos) || !valid_pos(end_pos)
    raise ArgumentError, "There is no piece at #{start_pos}" if self[start_pos].empty?
    raise ArgumentError, "Piece cannot move at #{end_pos}" unless self[start_pos].valid_moves.include?(end_pos)

    move_pieces!(start_pos, end_pos)
  end

  def move_pieces!(start_pos, end_pos)
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]

    self[start_pos] = NullPiece.instance
    self[end_pos].pos = end_pos
  end

  def valid_pos(pos)
    pos.all? { |pos| (0..7).include?(pos) }
  end

  def in_check?(color)
    king = @rows.flatten.find { |el| el.is_a?(King) && el.color == color }
    pieces = @rows.flatten.select { |el| el.color != color && !el.is_a?(NullPiece) }
    pieces.any? { |piece| piece.all_possible_moves.include?(king.pos) }
  end

  def checkmate?(color)
    pieces = @rows.flatten.select { |el| el.color == color && !el.is_a?(NullPiece) }
    pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def deep_dup
    new_board = Board.new
    new_board.rows = @rows.map do |row|
      row.map do |el|
        duplicate = !el.is_a?(NullPiece) ? el.dup : NullPiece.instance
        duplicate.board = new_board
        duplicate
      end
    end
    new_board
  end
end
