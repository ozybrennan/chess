require_relative 'sliding_piece.rb'

class Bishop < SlidingPiece

  attr_accessor :pos
  attr_reader :board, :color, :symbol, :value

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2657" : "\u265D" )
    @value = 3
  end

  private

  def move_dirs
    DIAGONALS
  end
end
