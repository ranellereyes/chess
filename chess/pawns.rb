require_relative 'piece'
require 'byebug'

class Pawns < Piece
  attr_reader :symbol

  def initialize(board, pos, side)
    # debugger
    x, _ = pos
    @symbol = side == :white ? "♙" : "♟"
    super
  end

  def moves
    pos_moves = []
    x, y = @pos
    attacks = side_attacks.reject do |(dx, dy)|
      @board[[x + dx, y + dy]] == NullPiece.instance
    end
    move_dirs = attacks + forward_steps
    move_dirs.each do |(dx, dy)|
      pos_moves << [x + dx, y + dy]
    end

    pos_moves
  end

  def at_start_row?
    x , _ = @pos
    @side == :white && x == 1 ||
      @side == :black && x == 6
  end

  def forward_dir
    @side == :white ? [1, 0] : [-1, 0]
  end

  def forward_steps
    x, y = forward_dir
    if at_start_row?
      [[x,y], [x+x, y+y]]
    else
      [[x,y]]
    end
  end

  def side_attacks
    x, y = forward_dir
    diagonal_dirs = [[x, y + 1], [x, y - 1]]
  end

end
