require 'debugger'

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

        return save if input == "s"
        return if input == "q"

        start_position, end_position = input
        board.move(start_position, end_position, active_player.color)
      rescue ArgumentError
        puts "You have no piece on that square. Please try again."
        retry
      rescue RuntimeError
        puts "That piece cannot move to that square. Please try again."
        retry
      rescue
        retry
      end

      active_player = other_player(active_player)
    end

    puts board.render

    if board.stalemate?(:white) || board.stalemate?(:black)
      puts "The game ended in stalemate."
    else
      puts "The winner is the #{winner} player."
    end
  end

  private

  def save
    puts "What would you like to call your game?"
    filename = gets.chomp

    File.write("#{filename}.txt", YAML.dump(self))

    puts "File saved."
    puts "Resume your game by typing 'ruby #{$PROGRAM_NAME} #{filename}.txt'."
  end

  def winner
    board.checkmate?(:white) ? :black : :white
  end

  def game_over?
    [:white, :black].any? do |color|
      board.checkmate?(color) || board.stalemate?(color)
    end
  end

  def other_player(active_player)
    active_player == @player1 ? @player2 : @player1
  end

end