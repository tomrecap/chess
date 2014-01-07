class Piece

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

end