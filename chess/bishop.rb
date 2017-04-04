require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable
  attr_reader :symbol

  def initialize(board, pos, side)
    x, _ = pos
    @symbol = side == :white ? "♗" : "♝"
    super
  end
end
