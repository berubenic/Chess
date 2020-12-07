# frozen_string_literal: true

require_relative '../lib/chess/save_load'
require_relative '../lib/chess/display'
require_relative '../lib/chess/translator'
require_relative '../lib/chess/pawn_promotion'
require_relative '../lib/chess/initial_setup'
require_relative '../lib/chess/pieces/rook'
require_relative '../lib/chess/pieces/pawn'
require_relative '../lib/chess/pieces/knight'
require_relative '../lib/chess/pieces/bishop'
require_relative '../lib/chess/pieces/queen'
require_relative '../lib/chess/pieces/king'
require_relative '../lib/chess/board'
require_relative '../lib/chess/game'

game = Chess::Game.new
game.intro
