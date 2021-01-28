require_relative 'board'
require_relative 'cursor'
require_relative 'pieces'
require 'colorize'

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
  end




  def render(highlight = nil)
    puts "   #{('a'..'h').to_a.join(" ")}"
    @board.rows.each.with_index do |row, i|
      row_nr = 8-i
      if !highlight.nil? 
        x,y = highlight
          if i == x
            puts "#{row_nr} #{row[0...y].join(' ')} #{row[y].symbol.colorize(:red)} #{row[(y+1)..-1].join(' ')}  #{row_nr}"
          else 
            puts "#{row_nr} #{row.join(' ')}  #{row_nr}"
          end
      else
        puts "#{row_nr} #{row.join(' ')}  #{row_nr}"
      end
    end
    puts "   #{('a'..'h').to_a.join(' ')}"
  end
end
