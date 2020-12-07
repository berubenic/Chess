# frozen_string_literal: true

require_relative 'chess/version'

# Chess module
module Chess
end

require_relative './chess/save_load'
require_relative './string'
require_relative './chess/translator'
require_relative './chess/pawn_promotion'
require_relative './chess/pieces/pawn'
require_relative './chess/pieces/rook'
require_relative './chess/pieces/knight'
require_relative './chess/pieces/bishop'
require_relative './chess/pieces/queen'
require_relative './chess/pieces/king'
require_relative './chess/board'
require_relative './chess/game'
