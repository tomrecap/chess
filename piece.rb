class Piece

  DIAGONAL_STEPS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  ORTHOGONAL_STEPS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  WHITE_UNICODES = {
    King:   "\u2654",
    Queen:  "\u2655",
    Rook:   "\u2656",
    Bishop: "\u2657",
    Knight: "\u2658",
    Pawn:   "\u2659",
  }
  BLACK_UNICODES = {
    King:   "\u265a",
    Queen:  "\u265b",
    Rook:   "\u265c",
    Bishop: "\u265d",
    Knight: "\u265e",
    Pawn:   "\u265f"
  }
  CHESS_SYMBOLS = { white: WHITE_UNICODES,
                    black: BLACK_UNICODES }

  attr_accessor :position
  attr_reader :color, :board

  def initialize(position, board, color)
    @position, @board, @color = position, board, color
  end

  def inspect
     { postion: position, color: color }
  end

  def render
    CHESS_SYMBOLS[color][self.class.to_s.to_sym]
  end

  def dup(new_board)
    self.class.new(position.dup, new_board, color)
  end

  def move_into_check?(destination_square)
    new_board = board.dup
    new_board.move!(position, destination_square)
    new_board.in_check?(color)
  end

  def valid_moves
    find_legal_moves.reject { |square| move_into_check?(square) }
  end
end