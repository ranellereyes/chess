module Slideable

  def moves(pos)
    pos_moves = []
    move_dirs.each do |dir|
      new_move = pos
      while @board.in_bounds?(new_move)
        new_move = grow_unblocked_moves_in_dir(new_move, dir)
        pos_moves << new_move if @board.in_bounds?(new_move)
      end
    end
    pos_moves
  end

  def move_dirs
    case self.class
    when Queen
      horizontal_dirs + diagonal_dirs
    when Bishop
      diagonal_dirs
    when Rook
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
