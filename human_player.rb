# require_relative ''



class HumanPlayer

  attr_reader :color, :name

  def initialize(name, color)
    @name = name
    @color = color
  end

  def make_move
    begin
      pos = pos_parser(gets.chomp)
    rescue ArgumentError => e
      puts e
      retry
    end
    pos
  end

  # private

  def pos_parser(pos)
    alph = ('a'..'h')
    if alph.include?(pos[0])
      if (1..8).include?(pos[1].to_i)
        coords(pos)
      else
        raise ArgumentError, '2nd coordinate out of bounds'
      end
    else
      raise ArgumentError, '1st coordinate out of bounds'
    end
  end

  def coords(sq)
    letter = sq[0]
    number = sq[1]
    [8 - number.to_i , letter.ord - 97]
  end
end
