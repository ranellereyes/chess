require_relative 'piece'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8)}

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos,val)
    x, y = pos
    @grid[x][y] = val
  end

  def def_board_setup
    null_rows = [2,3,4,5]
    back_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    @grid.each_with_index do |row, i|
      case i
      when 0, 7
        row = back_row
      when 1, 6
        row = Array.new(8) { Pawn.new }
      when null_rows
        row = Array.new(8) { Null.new }
      end
    end
  end

  def move_piece

  end
end
