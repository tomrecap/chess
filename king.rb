class King < SteppingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def legal_steps
    [[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1],[1,1]]
  end

end