module Slideable
  def horizontal_dirs
    x, y = pos
    left = []
    right = []
    up = []
    down = []
    (0..7).each do |i|
      left.unshift([x, i]) if i < y
      right << [x, i] if i > y
      up.unshift([i, y]) if i < x
      down << [i, y] if i > x
    end
    [left, up, right, down]
  end

  def diagonal_dirs
    x, y = pos
    top_left = []
    top_right = []
    bottom_right = []
    bottom_left = []
    (1..7).each do |i|
      top_left << ([x - i, y - i]) if valid_pos([x - i, y - i])
      top_right << [x - i, y + i] if valid_pos([x - i, y + i])
      bottom_right << [x + i, y + i] if valid_pos([x + i, y + i])
      bottom_left << ([x + i, y - i]) if valid_pos([x + i, y - i])
    end
    [top_left, top_right, bottom_right, bottom_left]
  end

  def moves
    if move_dirs == :horizontal
      horizontal_dirs
    elsif move_dirs == :diagonal
      diagonal_dirs
    else
      horizontal_dirs + diagonal_dirs
    end
  end

  private

  def move_dirs; end

  def valid_pos(pos)
    pos.all? { |pos| (0..7).include?(pos) }
  end
end
