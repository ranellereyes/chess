class Piece
  attr_reader :pos, :board, :side

  def initialize(board, pos)
    @board = board
    @pos = pos
    x, _ = pos
    @side = x < 2 ? :white : :black
  end
end
