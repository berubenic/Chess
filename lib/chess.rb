# frozen_string_literal: true

require_relative 'chess/version'

# Chess module
module Chess
end
require_relative './chess/initial_setup'
require_relative './chess/pieces/pawn'
require_relative './chess/pieces/rook'
require_relative './chess/pieces/knight'
require_relative './chess/pieces/bishop'
require_relative './chess/pieces/queen'
require_relative './chess/pieces/king'
require_relative './chess/pieces/piece_factory'
require_relative './chess/board'
require_relative './chess/game'
require_relative './chess/display'
require_relative './chess/translator'
