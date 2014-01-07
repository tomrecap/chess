class King < SteppingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def legal_steps
    DIAGONAL_STEPS + ORTHOGONAL_STEPS
  end

end