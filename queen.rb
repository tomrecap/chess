class Queen < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def move_directions
    DIAGONAL_STEPS + ORTHOGONAL_STEPS
  end
end