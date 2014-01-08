class Rook < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def move_directions
    ORTHOGONAL_STEPS
  end
end