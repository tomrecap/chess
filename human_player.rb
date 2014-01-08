class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    puts "It is the #{color} player's turn."
    puts "Please enter a move, type s to save, or q to quit."
    input = gets.chomp.downcase

    raise StandardError.new if input.empty?
    return input if input == "s" || input == "q"

    input.delete(" ").split(",").map do |coords|
      convert_to_indices(coords)
    end
  end

  private
  def convert_to_indices(chess_coords)
    col, row = chess_coords.split("")
    [col.ord - 97, row.to_i - 1]
  end
end