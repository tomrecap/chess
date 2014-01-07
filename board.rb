class Board

  attr_accessor :rows

  def self.blank_board
    Array.new(8) { Array.new(8) }
  end

  def initialize(board = self.class.blank_board)
    @rows = board
  end

  def []=(position, piece)
    board[position] = piece
  end

  def [](position)
    x, y = position
    rows[8 - y][x]
  end

end