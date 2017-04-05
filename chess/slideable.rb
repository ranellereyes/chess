require 'byebug'

module Slideable

  def moves
    pos_moves = []
    move_dirs.each do |dir|
      new_move = grow_unblocked_moves_in_dir(@pos, dir)
      while @board.in_bounds?(new_move)
        if @board[new_move].side == self.side
          break
        else
          pos_moves << new_move if @board.in_bounds?(new_move)
          break unless @board[new_move] == NullPiece.instance
        end
        new_move = grow_unblocked_moves_in_dir(new_move, dir)
      end
    end
    pos_moves
  end

  def move_dirs
    if self.is_a?(Queen)
      horizontal_dirs + diagonal_dirs
    elsif self.is_a?(Bishop)
      diagonal_dirs
    elsif self.is_a?(Rook)
      horizontal_dirs
    end
  end

  #private

  def horizontal_dirs
    [[-1,0],[1,0],[0,-1],[0,1]]
  end

  def diagonal_dirs
    [[-1,-1],[-1,1],[1,-1],[1,1]]
  end

  def grow_unblocked_moves_in_dir(pos, diff)
    x, y = pos
    dx, dy = diff
    [x + dx, y + dy]
  end


end
