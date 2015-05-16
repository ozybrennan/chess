require_relative 'sliding_piece.rb'

class Rook < SlidingPiece

  attr_accessor :pos
  attr_reader :board, :color, :symbol, :value, :moved

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2656" : "\u265C" )
    @value = 5
    @moved = false
  end

  def pos=(pos)
    pos = pos
    moved = true
  end

  def move!(start, end_pos)
    if end_pos == find_piece(color, King).pos
      x, y = pos
      x2, y2 = end_pos
      if y > y2
        board[[x, y - 2]] = self
        board[[x, y - 1]] = board[end_pos]
        board[pos] = nil
        board[end_pos] = nil
        board[[x, y - 1]].pos = [x, y - 1]
        pos = [x, y - 2]
      else
        board[[x, y + 3]] = self
        board[[x, y + 2]] = board[end_pos]
        board[pos] = nil
        board[end_pos] = nil
        board[[x, y + 2]].pos = [x, y + 2]
        pos = [x, y + 3]
      end
    else
      board[end_pos] = self
      board[pos] = nil
      pos = end_pos
    end
  end

  private

  def castle
    king = board.find_piece(color, King)[0]
    if moved || king.moved
      []
    elsif board.get_captured?(pos, color) || board.get_captured?(king.pos, color)
      []
    else
      x, y = pos
      x2, y2 = king.pos
      if y > y2
        (y2 + 1).upto(y - 1).each do |i|
          unless check_board_at([x, i]) == :nil && !board.get_captured?([x, i], color)
            return []
          end
        end
      else
        (y2 - 1).downto(y + 1).each do |i|
          unless check_board_at([x, i]) == :nil && !board.get_captured?([x, i], color)
            return []
          end
        end
      end
      [pos, king.pos]
    end
  end

  def move_dirs
    ORTHOGONALS
  end
end
