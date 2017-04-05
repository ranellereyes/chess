class Piece
  attr_accessor :side, :pos
  attr_reader :board

  def initialize(board, pos, side)
    @board = board
    @pos = pos
    x, _ = pos
    @side = side
  end

  def valid_moves
    moves.reject do |move|
      dup_board = Board.dup(@board)
      dup_board.move_piece(@pos, move)
      dup_board.in_check?(@side)
    end
  end
end
