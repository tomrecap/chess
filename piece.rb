class Piece

  DIAGONAL_STEPS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  ORTHOGONAL_STEPS = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  attr_accessor :position
  attr_reader :color, :board

  def initialize(position, board, color)
    @position, @board, @color = position, board, color
  end

  def inspect
    "#{color} #{self.class}"
  end

  def can_move_to?(square)
    find_legal_moves.include?(square)
  end

  def dup(new_board)
    self.class.new(position.dup, new_board, color)
  end

end