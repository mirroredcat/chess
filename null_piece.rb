require_relative 'pieces'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize; end

  def symbol
    "\u2001"
  end

  def empty?
    true
  end
end
