class SlidingPiece < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def find_legal_moves
    legal_moves = []

    move_directions.each do |direction|
      legal_moves += find_legal_moves_in_one_direction(direction)
    end

    legal_moves
  end

  def find_legal_moves_in_one_direction(direction)
    legal_moves = []
    squares = find_all_squares_in_one_direction(direction)

    squares.each do |square|

      if board[square].nil?
        legal_moves << square
      else
        legal_moves << square unless board[square].color == color
        break
      end
    end

    legal_moves
  end

  def find_all_squares_in_one_direction(direction)
    x, y = position
    squares = []

    (1..7).each do |distance|
      dx, dy = direction.map { |i| i * distance }
      new_square = [x + dx, y + dy]

      break unless new_square.all?{ |coord| coord.between?(0,7) }
      squares << new_square
    end

    squares
  end
end