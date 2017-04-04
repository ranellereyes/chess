class Piece
  attr_reader :value

  def initialize(value = "Vu", board, pos)
    @value = "v"
    @board = board
    @pos = pos
  end
end
