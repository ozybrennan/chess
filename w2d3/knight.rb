require_relative 'stepping_piece.rb'

class Knight < SteppingPiece

  KNIGHT_MOVES = [[-2, -1], [-2,  1], [-1, -2], [-1,  2],
  [ 1, -2], [ 1,  2], [ 2, -1], [ 2,  1]]

  attr_accessor :pos
  attr_reader :board, :color, :symbol, :value

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2658" : "\u265E" )
    @value = 3
  end

  private

  def move_dirs
    KNIGHT_MOVES
  end
end
