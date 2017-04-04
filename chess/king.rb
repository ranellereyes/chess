require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable
  attr_reader :symbol

  def initialize(board, pos)
    x, _ = pos
    @symbol = x < 2 ? "♔" : "♚"
    super(board, pos)
  end
end
