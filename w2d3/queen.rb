require_relative 'sliding_piece.rb'

class Queen < SlidingPiece

  attr_accessor :pos
  attr_reader :board, :color, :symbol, :value

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2655" : "\u265B" )
    @value = 9
  end

  private

  def move_dirs
    DIAGONALS + ORTHOGONALS
  end
end
