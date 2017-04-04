require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  include Stepable
  attr_reader :symbol

  def initialize(board, pos)
    x, _ = pos
    @symbol = x < 2 ? "♘" : "♞"
  end
end
