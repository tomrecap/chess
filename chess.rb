require 'yaml'
require 'colorize'
require './board.rb'
require './piece.rb'

require './sliding_piece.rb'
require './bishop.rb'
require './rook.rb'
require './queen.rb'

require './stepping_piece.rb'
require './king.rb'
require './knight.rb'
require './pawn.rb'

require './human_player.rb'
require './game.rb'

if $PROGRAM_NAME == __FILE__
  if ARGV.empty?
    Game.new.play
  else
    YAML.load_file(ARGV.shift).play
  end
end