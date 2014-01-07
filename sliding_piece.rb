class SlidingPiece < Piece

  attr_reader :position

  def initialize(position, board, color)
    super(position, board, color)
  end

  def legal_moves

  end

  def all_squares_in_one_direction(direction)
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