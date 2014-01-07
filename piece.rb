class Piece

  attr_reader :color, :position, :board

  def initialize(position, board, color)
    @position, @board, @color = position, board, color
  end

  def inspect
    "#{color} #{self.class}"
  end

end