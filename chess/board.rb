require_relative 'piece'
require_relative 'load'
require 'byebug'
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
    @grid.map!.with_index do |row, i|
      side = (i < 4 ? :white : :black)
      # puts "i: #{i}, side: #{side}"
      case i
      when 0, 7
        back_row = [
          Rook.new(self, [i, 0], side),
          Knight.new(self, [i, 1], side),
          Bishop.new(self, [i, 2], side),
          Queen.new(self, [i, 3], side),
          King.new(self, [i, 4], side),
          Bishop.new(self, [i, 5], side),
          Knight.new(self, [i, 6], side),
          Rook.new(self, [i, 7], side)
        ]
        row = back_row
        # p side
      when 1, 6
        pawn_row = []
        0.upto(7) { |j| pawn_row << Pawns.new(self, [i, j], side) }
        row = pawn_row
      when 2,3,4,5
        null_row = Array.new(8) { NullPiece.instance }
        row = null_row
      end
    end
  end

  def move_piece(start_pos, end_pos)
    begin
      if self[end_pos] == NullPiece.instance
        self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
        self[end_pos].pos = end_pos
        self[start_pos].pos = start_pos
      else
          self[end_pos], self[start_pos]= self[start_pos], NullPiece.instance
          self[end_pos].pos = end_pos
      end
    rescue
      raise "There is no piece at start position" if self[start_pos] == NullPiece.instance
      raise "The piece cannot move to position" unless self[end_pos] == NullPiece.instance
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

  def check_mate?(side)
    defending_pieces = @grid.flatten.select do |piece|
      piece.side == side
    end

    defending_pieces.all? do |piece|
      orig_pos = piece.pos
      piece.moves.all? do |move|
        dup_board = Board.dup(self)
        dup_board.move_piece(orig_pos, move)
        dup_board.in_check?(side)
      end
    end
  end

  def self.dup(board)
    new_board = Board.new
    board.grid.each_index do |row|
      board.grid.each_index do |col|
        new_board[[row,col]] = NullPiece.instance
        next if board[[row,col]] == NullPiece.instance
        piece = board[[row,col]]
        pos = piece.pos
        side = piece.side
        new_piece = piece.class.new(new_board,pos,side)
        new_board[[row,col]] = new_piece
      end
    end
    new_board
  end
end
