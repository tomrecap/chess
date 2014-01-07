class Piece

  attr_reader :color, :position, :board

  def initialize(position, board, color)
    @position, @board, @color = position, board, color
  end

  def inspect
    # {color: color, position: position}
    color.to_s
  end

end