class Piece

  attr_accessor :pos
  attr_reader :board, :color, :symbol

  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
  end

  def valid_moves
    valid_moves = []
    moves.each do |destination|
      new_board = board.dup
      new_board.move!(pos, destination)
      valid_moves << destination unless new_board.in_check?(color)
    end
    valid_moves
  end

  def inspect
    {:pos => pos,
      :color => color}.inspect
  end

  def check_board_at(pos)
    # p pos
    if board[pos].nil?
      :nil
    elsif board[pos].color != color
      :opponent
    else
      :ally
    end
  end

  private

  def off_board?(pos)
    x, y = pos
    x < 0 || x > 7 || y < 0 || y > 7
  end

end
