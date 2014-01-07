require 'debugger'

class Board

  attr_accessor :rows

  def self.blank_board
    Array.new(8) { Array.new(8) }
  end

  def initialize(rows = [])
    if rows.empty?
      @rows = self.class.blank_board
      place_pieces
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
    rows.map do |row|
      row.map do |square|
        if square.nil?
          "____"
        else
          square.inspect
        end
      end.join("\t")
    end.join("\n\n")
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
      next if square.nil? || square.color == king_color
      return true if square.find_legal_moves.include?(king_position)
    end

    false
  end

# refactor LATER
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

  def move(start_pos, end_pos, player_color)
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

    each do |square|
      next if square.nil?

      new_piece = square.dup(new_board)
      new_board[square.position] = new_piece
    end

    new_board
  end

  def checkmate?(color)
    return false unless in_check?(color)

    each do |square|
      next if square.nil? || square.color != color
      return false unless square.valid_moves.empty?
    end

    true
  end
end