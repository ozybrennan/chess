require_relative 'stepping_piece.rb'

class King < SteppingPiece

  KING_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1],
  [0, 1], [1, 0], [-1, 0], [0, -1]]

  attr_accessor :pos
  attr_reader :board, :color, :symbol, :value, :moved

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2654" : "\u265A" )
    @value = 9001
    @moved = false
  end

  def pos=(pos)
    pos = pos
    moved = true
  end

  private

  def move_dirs
    KING_MOVES
  end
end
