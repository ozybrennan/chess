require_relative 'piece.rb'

class SteppingPiece < Piece

  KING_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1],
                [0, 1], [1, 0], [-1, 0], [0, -1]]
  KNIGHT_MOVES = [[-2, -1], [-2,  1], [-1, -2], [-1,  2],
                  [ 1, -2], [ 1,  2], [ 2, -1], [ 2,  1]]

  attr_accessor :pos
  attr_reader :board, :color, :symbol

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ""
  end

  def moves
    x, y = pos
    total_moves = move_dirs.map { |i, j| [x + i, y + j]}
    total_moves.reject! { |move| off_board?(move) }
    total_moves.select do |move|
      check_board_at(move) == :nil || check_board_at(move) == :opponent
    end
  end

end
