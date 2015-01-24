require_relative 'piece.rb'

class SlidingPiece < Piece
  DIAGONALS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  ORTHOGONALS = [[0, 1], [1, 0], [-1, 0], [0, -1]]

  attr_accessor :pos
  attr_reader :board, :color

  def initialize(board, pos, color)
    super(board, pos, color)
  end

  def moves
    total_moves = []
    x, y = pos
    move_dirs.each do |dir|
      i, j = dir
      x2, y2 = [x + i, y + j]
      total_moves += rec_moves(x2, y2, i, j)
    end
    if self.class == Rook
      total_moves += castle
    end

    total_moves
  end

  private

  def rec_moves(x, y, i, j)
    total_moves = []
    until off_board?([x, y])
      case check_board_at([x, y])
      when :nil
        total_moves << [x, y]
        x += i
        y += j
      when :opponent
        total_moves << [x, y]
        break
      when :ally
        break
      end
    end
    total_moves
  end

end
