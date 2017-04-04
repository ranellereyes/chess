class Piece
  attr_accessor :side, :pos
  attr_reader :board

  def initialize(board, pos, side)
    @board = board
    @pos = pos
    x, _ = pos
    @side = side
  end
end
