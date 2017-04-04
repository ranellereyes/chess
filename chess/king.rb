require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable
  attr_reader :symbol

  def initialize(board, pos, side)
    x, _ = pos
    @symbol = side == :white ? "♔" : "♚"
    super
  end
end
