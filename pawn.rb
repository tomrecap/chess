class Pawn < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def find_legal_moves
    find_spaces_ahead + find_spaces_diagonally
  end

  def find_spaces_ahead
    x, y = position

    if color == :white
      one_square_ahead = [x, y + 1]
      two_squares_ahead = [x, y + 2]
      starting_y = 1
    else
      one_square_ahead = [x, y - 1]
      two_squares_ahead = [x, y - 2]
      starting_y = 6
    end

    if !board[one_square_ahead].nil?
      []
    elsif board[two_squares_ahead].nil? && y == starting_y
      [one_square_ahead, two_squares_ahead]
    else
      [one_square_ahead]
    end
  end

  def find_spaces_diagonally
    x,y = position

    if color == :white
      diagonals = [[x + 1, y + 1], [x - 1, y + 1]]
    else
      diagonals = [[x + 1, y - 1], [x - 1, y - 1]]
    end

    diagonals.select do |diagonal|
      !board[diagonal].nil? && (board[diagonal].color != color)
    end
  end
end