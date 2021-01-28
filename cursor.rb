require 'io/console'
require 'colorize'

KEYMAP = {
  ' ' => :space,
  'h' => :left,
  'j' => :down,
  'k' => :up,
  'l' => :right,
  'w' => :up,
  'a' => :left,
  's' => :down,
  'd' => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor
  attr_reader :cursor_pos
  attr_accessor :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
    # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
    # numeric keycode. chr returns a string of the
    # character represented by the keycode.
    # (e.g. 65.chr => "A")

    if input == "\e"
      begin
        input << STDIN.read_nonblock(3)
      rescue StandardError
        nil
      end
      # at most maxlen bytes from a
      # data stream; it's nonblocking,
      # meaning the method executes
      # asynchronously; it raises an
      # error if no data is available,
      # hence the need for rescue

      begin
        input << STDIN.read_nonblock(2)
      rescue StandardError
        nil
      end
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    input
  end

  def handle_key(key)
    case key
    when :return || :space
      toggle_selected
      @board[@cursor_pos].symbol.colorize(:red)
      @cursor_pos
    when :left || :right || :up || :down
      update_pos(MOVES[key])
      @board[@cursor_pos].colorize(:green)
      nil
    when :ctrl_c
      Process.exit
    end
  end

  def update_pos(diff)
    @cursor_pos = [(@cursor_pos[0] + diff[0]), (cursor_pos[1] + diff[1])] if @board.valid_pos([
                                                                                                (@cursor_pos[0] + diff[0]), (cursor_pos[1] + diff[1])
                                                                                              ])
  end

  def toggle_selected
    @selected ^= true
  end
end
