# frozen_string_literal: true

require_relative '../lib/string'
require_relative '../lib/chess/save_load'
require_relative '../lib/chess/display'
require_relative '../lib/chess/translator'
require_relative '../lib/chess/movement/single_movement'
require_relative '../lib/chess/movement/directional_movement'
require_relative '../lib/chess/movement/en_passant'
require_relative '../lib/chess/movement/castling'
require_relative '../lib/chess/win_conditions'
require_relative '../lib/chess/pawn_promotion'
require_relative '../lib/chess/pieces/piece'
require_relative '../lib/chess/pieces/rook'
require_relative '../lib/chess/pieces/pawn'
require_relative '../lib/chess/pieces/knight'
require_relative '../lib/chess/pieces/bishop'
require_relative '../lib/chess/pieces/queen'
require_relative '../lib/chess/pieces/king'
require_relative '../lib/chess/referee'
require_relative '../lib/chess/board'
require_relative '../lib/chess/game'

game = Chess::Game.new
game.intro
