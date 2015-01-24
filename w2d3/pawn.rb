require_relative 'piece.rb'

class Pawn < Piece

  attr_accessor :pos
  attr_reader :board, :color, :symbol, :value

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2659" : "\u265F" )
    @value = 1
  end

  def moves
    dx = ( color == :black ? 1 : -1 )
    x, y = pos
    forward_moves = [[x + dx, y]]
    if (x == 1 && color == :black) || (x == 6 && color == :white)
      forward_moves << [x + dx * 2, y]
    end
    forward_moves.select! { |move| check_board_at(move) == :nil }
    diagonal_moves = [[x + dx, y - 1], [x + dx, y + 1]].select do |move|
      check_board_at(move) == :opponent
    end

    (forward_moves + diagonal_moves).reject { |move| off_board?(move) }
  end

end
