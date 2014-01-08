class Knight < SteppingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def legal_steps
    [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  end
end