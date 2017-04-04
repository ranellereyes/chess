require 'byebug'

module Stepable

  def moves
    pos_moves = []
    x, y = @pos
    move_dirs.each do |(dx, dy)|
      new_move = [x +dx, y + dy]
      pos_moves << new_move if @board.in_bounds?(new_move) &&
        @board[new_move].side != self.side
    end
    pos_moves
  end

  def move_dirs
    if self.is_a?(King)
      king_dirs
    elsif self.is_a?(Knight)
      knight_dirs
    end
  end

  private

  def king_dirs
    [[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[-1,1],[1,-1],[1,1]]
  end

  def knight_dirs
    [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]
  end

end
