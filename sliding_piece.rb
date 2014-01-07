class SlidingPiece < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def find_legal_moves(directions)
    legal_moves = []

    directions.each do |direction|
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

    (1..7).each do |move_distance|

      case direction
      when :north
        current_x, current_y = x, y + move_distance
      when :south
        current_x, current_y = x, y - move_distance

      when :east
        current_x, current_y = x + move_distance, y
      when :west
        current_x, current_y = x - move_distance, y

      when :northeast
        current_x, current_y = x + move_distance, y + move_distance
      when :southwest
        current_x, current_y = x - move_distance, y - move_distance

      when :southeast
        current_x, current_y = x + move_distance, y - move_distance
      when :northwest
        current_x, current_y = x - move_distance, y + move_distance
      end

      break unless [current_x, current_y].all?{ |coord| coord.between?(0,7) }

      squares << [current_x, current_y]
    end

    squares

  end

end