require 'debugger'

class Board

  attr_accessor :rows

  def initialize(rows = [])
    if rows.empty?
      @rows = self.class.blank_board
      [:white, :black].each { |color| place_pieces(color) }
    else
      @rows = rows
    end
  end

  def []=(position, piece)
    x,y = position
    rows[7 - y][x] = piece
  end

  def [](position)
    x, y = position
    rows[7 - y][x]
  end

  def render
    rows.map.with_index do |row, i|
      ([" #{8 - i} "] + row.map.with_index do |square, j|
        square_color = (i + j).even? ? :light_white : :white

        if square.nil?
          "   ".colorize(:background => square_color)
        else
          " #{square.render} ".colorize(:background => square_color)
        end
      end).join
    end.join("\n") + "\n    #{("a".."h").to_a.join("  ")} "
  end

  def move(start_pos, end_pos, player_color)
    raise ArgumentError.new unless start_pos.all? { |coord| coord.between?(0,7) }

    active_piece = self[start_pos]

    raise ArgumentError.new if active_piece.nil?
    raise ArgumentError.new if active_piece.color != player_color
    raise RuntimeError.new unless active_piece.valid_moves.include?(end_pos)

    self[end_pos] = active_piece
    active_piece.position = end_pos
    self[start_pos] = nil
  end

  def move!(start_pos, end_pos)
    active_piece = self[start_pos]
    self[end_pos] = active_piece
    active_piece.position = end_pos
    self[start_pos] = nil
  end

  def dup
    new_board = Board.new(self.class.blank_board)

    each do |piece|
      next if piece.nil?

      new_piece = piece.dup(new_board)
      new_board[piece.position] = new_piece
    end

    new_board
  end

  def checkmate?(king_color)
    return false unless in_check?(king_color)

    !any? do |piece|
      next if piece.nil? || piece.color != king_color
      !piece.valid_moves.empty?
    end
  end

  def in_check?(king_color)
    king_position = find_king(king_color)

    any? do |piece|
      next if piece.nil? || piece.color == king_color
      piece.find_legal_moves.include?(king_position)
    end
  end

  private
  def self.blank_board
    Array.new(8) { Array.new(8) }
  end

  def each(&blk)
    rows.each do |row|
      row.each { |square| blk.call(square) }
    end
  end

  def any?(&blk)
    each { |square| return true if blk.call(square) }
    false
  end

  def find_king(color)
    each do |piece|
      if piece.is_a?(King) && piece.color == color
        return piece.position
      end
    end
  end

  def place_pieces(color)
    main_row = (color == :white ? 0 : 7)
    pawn_row = (color == :white ? 1 : 6)

    pieces = [King  .new([4, main_row], self, color),
              Queen .new([3, main_row], self, color),
              Bishop.new([2, main_row], self, color),
              Bishop.new([5, main_row], self, color),
              Knight.new([1, main_row], self, color),
              Knight.new([6, main_row], self, color),
              Rook  .new([0, main_row], self, color),
              Rook  .new([7, main_row], self, color)]
    8.times { |col| pieces << Pawn.new([col, pawn_row], self, color) }

    pieces.each { |piece| self[piece.position] = piece }
  end
end