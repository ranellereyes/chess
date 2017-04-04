module Slideable

  def moves(pos)

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

  private

  def horizontal_dirs
    [[-1,0],[1,0],[0,-1],[0,1]]
  end

  def diagonal_dirs
    [[-1,-1],[-1,1],[1,-1],[1,1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    [dx + dx, dy + dy]
  end


end
