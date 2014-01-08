class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    puts "It is the #{color} player's turn."
    puts "Please select a piece by entering a position."
    start_position = convert_to_indices(gets.chomp)

    puts "Please enter the position you would like to move it to."
    end_position = convert_to_indices(gets.chomp)

    [start_position, end_position]
  end

  private
  def convert_to_indices(chess_coords)
    col, row = chess_coords.split("")
    [col.ord - 97, row.to_i - 1]
  end
end