require_relative 'load'

class Chess

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @the_big_D = Display.new(@board)
    @cursor = Cursor.new([0,0], @board)
  end

  def play
    @the_big_D.render
    until @cursor.get_input.is_a?(Array)
    @cursor.get_input

  end


end
