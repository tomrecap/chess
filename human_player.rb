class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    puts "It is the #{color} player's turn."
    puts "Please select a piece by entering a position."
    start_position = gets.chomp.split(",").map { |i| Integer(i) }

    puts "Please enter the position you would like to move it to."
    end_position = gets.chomp.split(",").map { |i| Integer(i) }

    [start_position, end_position]
  end

end