class Pawn < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def find_legal_moves
    find_spaces_ahead + find_spaces_diagonally
  end

  private
  def find_spaces_ahead
    y = position[1]
    one_ahead, two_ahead, starting_y = identify_spaces_ahead

    if board[one_ahead]
      []
    elsif board[two_ahead].nil? && y == starting_y
      [one_ahead, two_ahead]
    else
      [one_ahead]
    end
  end

  def identify_spaces_ahead
    x, y = position
    if color == :white
      [[x, y + 1], [x, y + 2], 1]
    else
      [[x, y - 1], [x, y - 2], 6]
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