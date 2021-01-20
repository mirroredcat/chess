class Piece

  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    symbol.to_s
  end

  def empty?
    false
  end

  def valid_moves
    valid_moves = []
    all_moves = self.moves
    all_moves.each do |dir|
      dir.each do |square|
        if @board[square[0]][square[1]].empty?
          valid_moves << square
        else
          valid_moves << square if @board[square[0]][square[1]].color != @color 
          break
        end
      end
    end
    valid_moves
  end

  def symbol
    :X
  end

  def pos= (val)
    @pos = val
  end

  private

  def move_into_check?(end_pos)
    valid_moves.include?(end_pos)
  end

end