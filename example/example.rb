require_relative '../lib/chess'

game = Chess::Game.new

game.prepare_game

game.print_board

loop do
  game.select_piece_loop
  game.select_move_loop
  game.switch_turn
end
