class Queen < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def move_dirs
    [:north, :east, :south, :west,
      :northwest, :northeast, :southeast, :southwest]
  end

end