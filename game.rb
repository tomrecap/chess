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
        start_position, end_position = active_player.play_turn
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