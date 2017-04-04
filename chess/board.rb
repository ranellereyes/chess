require_relative 'piece'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8)}
    def_board_setup
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
    # back_row = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
    back_row = Array.new(8) {Piece.new(nil,@board,[0,0])}
    @grid.map!.with_index do |row, i|
      case i
      when 0, 7
        row = back_row
      when 1, 6
        row = Array.new(8) { Piece.new(nil, @board,[0,0]) }
      when 2,3,4,5
        row = Array.new(8) { nil }
      end
    end
  end

  def move_piece(start_pos, end_pos)
    begin
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    rescue
      raise "There is no piece at start position" if self[start_pos].nil?
      raise "The piece cannot move to position" unless self[end_pos].nil?
      retry
    end
  end

  def in_bounds?(pos)
    pos.all? { |coordinate| coordinate.between?(0, 7) }
  end
end
