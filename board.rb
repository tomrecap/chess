class Board

  attr_accessor :rows

  def self.blank_board
    Array.new(8) { Array.new(8) }
  end

  def initialize(board = self.class.blank_board)
    @rows = board
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
        if nil
          "_"
        else
          square.inspect
        end
      end.join("\t")
    end.join("\n")
  end

end