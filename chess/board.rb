require_relative 'piece'
require_relative 'load'

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
    null_row = Array.new(8) { NullPiece.instance }
    @grid.map!.with_index do |row, i|
      case i
      when 0, 7
        back_row = [
          Rook.new(self, [i, 0]),
          Knight.new(self, [i, 1]),
          Bishop.new(self, [i, 2]),
          Queen.new(self, [i, 3]),
          King.new(self, [i, 4]),
          Bishop.new(self, [i, 5]),
          Knight.new(self, [i, 6]),
          Rook.new(self, [i, 7])
        ]
        row = back_row
      when 1, 6
        pawn_row = []
        0.upto(7) { |j| pawn_row << Pawns.new(self, [i, j]) }
        row = pawn_row
      when 2,3,4,5
        row = null_row
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

  def in_check?(side)
    opposing_side = side == :white ? :black : :white
    king = nil
    opposing_pieces = @grid.flatten.select do |piece|
      king = piece if piece.side == side && piece.is_a?(King)
      piece.side == opposing_side
    end

    opposing_pieces.any? do |piece|
      piece.moves.include?(king.pos)
    end

  end
end
