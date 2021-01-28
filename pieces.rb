require_relative 'board'
require 'byebug'
require 'colorize'

class Piece
  attr_accessor :pos, :board, :selected
  attr_reader :color

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @selected = false
  end

  def to_s
    symbol
  end

  def empty?
    false
  end

  def toggle_selected
    @selected == false ? true : false
  end


  def all_possible_moves
    possible_moves = []
    all_moves = moves
    all_moves.each do |dir|
      dir.each do |square|
        if @board[square].empty?
          possible_moves << square
        else
          possible_moves << square if @board[square].color != @color
          break
        end
      end
    end
    possible_moves
  end

  def valid_moves
    all_possible_moves.select { |move| !move_into_check?(move) }
  end

  def symbol
    :X
  end

  # private

  def move_into_check?(end_pos)
    start_pos = @pos
    new_board = nil
    new_board = @board.deep_dup
    new_board.move_pieces!(start_pos, end_pos)
    new_board.in_check?(@color)
  end
end
