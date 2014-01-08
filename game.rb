class Game

  attr_reader :board, :active_player

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:white)
    @player2 = HumanPlayer.new(:black)
  end

  def play
    active_player = @player1

    until game_over?

      begin
        puts board.render
        input = active_player.play_turn

        return save if input.nil?
        start_position, end_position = input

        board.move(start_position, end_position, active_player.color)
      rescue ArgumentError
        puts "You have no piece on that square. Please try again."
        retry
      rescue RuntimeError
        puts "That piece cannot move to that square. Please try again."
        retry
      end

      active_player = other_player(active_player)
    end

    puts board.render
    puts "The winner is the #{winner} player."
  end

  private

  def save
    puts "What would you like to call your game?"
    filename = gets.chomp

    File.write("#{filename}.txt", YAML.dump(self))

    puts "File saved."
    puts "Resume your game by typing 'ruby #{__FILE__} #{filename}.txt'."
  end

  def winner
    board.checkmate?(:white) ? :black : :white
  end

  def game_over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def other_player(active_player)
    active_player == @player1 ? @player2 : @player1
  end

end