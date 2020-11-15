require_relative '../lib/chess'

game = Chess::Game.new

game.prepare_game

game.print_board

game.print_select_piece

game.select_piece
game.convert_move

game.possible_moves
game.print_board
