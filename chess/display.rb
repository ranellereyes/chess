require_relative 'board'
require 'colorize'
require_relative 'cursor'


class Display

  attr_accessor :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    # system('clear')
    puts "  0 1 2 3 4 5 6 7"
    @board.grid.each_with_index do |row, i|
      puts "#{i} #{row.map.with_index do |vu, j|
        current_vu = vu.nil? ? '_' : vu.symbol
        if @cursor.cursor_pos == [i,j]
          current_vu.colorize(:background => :light_blue, :color => :white)
        else
          current_vu
        end
      end.join(' ')}"
    end
    nil
  end
end

if __FILE__ == $0
  the_big_B = Board.new
  the_big_D = Display.new(the_big_B)
  while true
    the_big_D.render
    the_big_D.cursor.get_input
    system('clear')
    p the_big_D.cursor.cursor_pos
  end
end
