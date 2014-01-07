class Board

  attr_accessor :rows

  def self.blank_board
    Array.new(8) { Array.new(8) }
  end

  def initialize(board = self.class.blank_board)
    @rows = board
    place_pieces
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
    rows.map do |row|
      row.map do |square|
        if square.nil?
          "_"
        else
          square.inspect
        end
      end.join("\t")
    end.join("\n")
  end

  def each(&blk)
    rows.each do |row|
      row.each { |square| blk.call(square) }
    end
  end

  def find_king(color)
    each do |square|
      if square.is_a?(King) && square.color == color
        return square.position
      end
    end
  end

  def in_check?(king_color)
    king_position = find_king(king_color)

    each do |square|
      next if square.nil?

      return true if square.color != king_color &&
      square.find_legal_moves.include?(king_position)
    end

    false
  end

  def place_pieces
    pieces = [King.new([4,0], self, :white),
    Queen.new([3,0], self, :white),
    Bishop.new([2,0], self, :white),
    Bishop.new([5,0], self, :white),
    Knight.new([1,0], self, :white),
    Knight.new([6,0], self, :white),
    Rook.new([0,0], self, :white),
    Rook.new([7,0], self, :white),
    King.new([4,7], self, :black),
    Queen.new([3,7], self, :black),
    Bishop.new([2,7], self, :black),
    Bishop.new([5,7], self, :black),
    Knight.new([1,7], self, :black),
    Knight.new([6,7], self, :black),
    Rook.new([0,7], self, :black),
    Rook.new([7,7], self, :black)]

    8.times { |col| pieces << Pawn.new([col, 1], self, :white) }
    8.times { |col| pieces << Pawn.new([col, 6], self, :black) }

    pieces.each { |piece| self[piece.position] = piece }
  end

end