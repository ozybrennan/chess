require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'
require_relative 'no_move_error.rb'

class Board

  attr_accessor :pieces_number
  attr_reader :grid

  def initialize(empty = false)
    @grid = Array.new(8) { Array.new(8)}
    build_board unless empty
    @pieces_number = 32
  end

  def render_board
    puts "   |  " + ("a".."h").to_a.join("  ")
    puts "---+------------------------"

    grid.each_with_index do |row, i|
      row_string = "#{i + 1}  |  "
      row.each do |tile|
        if tile.nil?
          row_string << "_  "
        else
          row_string << tile.symbol + "  "
        end
      end

      puts row_string
    end
    puts

    nil
  end

  def get_captured?(pos, color)
    all_pieces_of(other_color(color)).each do |piece|
      return true if piece.moves.include?(pos)
    end

    false
  end

  def in_check?(color)
    king = find_piece(color, King).first
    all_pieces_of(other_color(color)).each do |piece|
      return true if piece.moves.include?(king.pos)
    end

    false
  end

  def all_pieces_of(color)
    grid.flatten.compact.select { |piece| piece.color == color}
  end

  def move(start, end_pos, color)
    begin
      raise NoMoveError.new "this is nil" if self[start].nil?
      unless self[start].valid_moves.include?(end_pos)
        raise NoMoveError.new "you can't go there"
      end
      raise NoMoveError.new "wrong color" if color != self[start].color
      move!(start, end_pos)
      pawn_to_queen(color)
    end
  end

#to be moved into piece

  def move!(start, end_pos)
    self[start].pos = end_pos
    self[end_pos] = self[start]
    self[start] = nil
  end

  def checkmate?(color)
    return false unless in_check?(color)
    all_pieces_of(color).each do |piece|
      return false unless piece.valid_moves.empty?
    end
    puts "Game over! You win, #{color}!"
    true
  end

  def [](position)
    x, y = position
    grid[x][y]
  end

  def []=(cur_pos, new_obj)
    x, y = cur_pos
    grid[x][y] = new_obj
  end

  def dup
    new_board = Board.new(empty = true)
    grid.flatten.compact.each do |el|
      new_board[el.pos] = el.class.new(new_board, el.pos, el.color)
    end

    new_board
  end

  private

  def build_board
    grid[0][0] = Rook.new(self, [0, 0], :black)
    grid[0][1] = Knight.new(self, [0, 1], :black)
    grid[0][2] = Bishop.new(self, [0, 2], :black)
    grid[0][3] = Queen.new(self, [0, 3], :black)
    grid[0][4] = King.new(self, [0, 4], :black)
    grid[0][5] = Bishop.new(self, [0, 5], :black)
    grid[0][6] = Knight.new(self, [0, 6], :black)
    grid[0][7] = Rook.new(self, [0, 7], :black)

    grid[7][0] = Rook.new(self, [7, 0], :white)
    grid[7][1] = Knight.new(self, [7, 1], :white)
    grid[7][2] = Bishop.new(self, [7, 2], :white)
    grid[7][3] = Queen.new(self, [7, 3], :white)
    grid[7][4] = King.new(self, [7, 4], :white)
    grid[7][5] = Bishop.new(self, [7, 5], :white)
    grid[7][6] = Knight.new(self, [7, 6], :white)
    grid[7][7] = Rook.new(self, [7, 7], :white)

    grid[1].each_index do |i|
      grid[1][i] = Pawn.new(self, [1, i], :black)
    end

    grid[6].each_index do |i|
      grid[6][i] = Pawn.new(self, [6, i], :white)
    end
  end

  def find_piece(color, type)
    all_pieces_of(color).select {|i| i.is_a? type }
  end

  def other_color(color)
    color == :white ? :black : :white
  end

  def pawn_to_queen(color)
    pawns = find_piece(color, Pawn)
    pawns.each do |pawn|
      if pawn.pos[0] == 0 || pawn.pos[0] == 7
        self[pawn.pos] = Queen.new(self, pawn.pos, color)
      end
    end
  end

end
#
 x = Board.new
# x.move([1,5], [2,5])
# x.move([6,4], [4,4])
# x.move([1,6], [3,6])
# x.move([7,3], [3,7])
x.render_board
# p x.checkmate?(:black)
