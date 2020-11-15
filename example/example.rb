require_relative '../lib/chess'

game = Chess::Game.new

game.prepare_game

game.print_board

game.game_loop
