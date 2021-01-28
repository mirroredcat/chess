require_relative 'board'
require_relative 'pieces'
require_relative 'display'
require_relative 'cursor'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  def initialize(name1, name2 = 'Chess-o-tron 3000')
    @board = Board.new
    @render = Display.new(@board)
    @player1 = HumanPlayer.new(name1, :W)
    if name2 == 'Chess-o-tron 3000'
      @player2 = ComputerPlayer.new(@board)
    else
      @player2 = HumanPlayer.new(name2, :B)
    end
    @players = [@player1, @player2]
  end

  def current_player
    @players[0]
  end

  def switch_player
    @players << @players.shift
  end

  def play
    @render.render

    puts
    puts 'Choose your piece'
    begin
      start_pos = current_player.make_move
      raise ArgumentError.new("Not your piece") unless @board[start_pos].color == current_player.color
      raise ArgumentError.new("Empty square") if @board[start_pos].empty?
    rescue ArgumentError => e
      puts e
      retry
    end
    
    system('cls')
    @render.render(start_pos)
    sleep(1) if current_player.is_a?(ComputerPlayer)

    puts 'Choose where to move it'
    begin
      end_pos = current_player.make_move
      @board.move_pieces(start_pos, end_pos)
    rescue ArgumentError => e
      puts "#{e}, try again"
      retry
    end
    switch_player
    
    system('cls')
  end

  def won?
    @board.checkmate?(:W) || @board.checkmate?(:B)
  end

  def game
    puts 'Welcome to chess'
    puts
    puts
    play until won?
    @render.render
    puts "Congratulations #{@players[1].name}, you won!"
  end
end

game = Game.new('Jeff')
game.game
