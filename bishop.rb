class Bishop < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def move_directions
    DIAGONAL_STEPS
  end

end