class SteppingPiece < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def find_legal_moves
    find_squares_one_step_away.select do |square|
      board[square] == nil || board[square].color != color
    end
  end

  private
  def find_squares_one_step_away
    x, y = position

    accessible_squares = legal_steps.map do |(dx, dy)|
      next_pos = [x + dx, y + dy]
    end

    accessible_squares.select do |square|
      square.all? { |coord| coord.between?(0,7) }
    end
  end
end