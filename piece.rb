class Piece

  DIAGONAL_STEPS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  ORTHOGONAL_STEPS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  attr_accessor :position
  attr_reader :color, :board

  def initialize(position, board, color)
    @position, @board, @color = position, board, color
  end

  def inspect
    { postion: position, color: color }
  end

  def dup(new_board)
    self.class.new(position.dup, new_board, color)
  end

  def move_into_check?(square)
    new_board = board.dup
    new_board.move!(position, square)
    new_board.in_check?(color)
  end

  def valid_moves
    find_legal_moves.reject { |square| move_into_check?(square) }
  end
end