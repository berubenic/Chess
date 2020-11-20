# frozen_string_literal: true

require_relative 'chess/version'

# Chess
module Chess
end

require_relative './chess/movement/single_movement'
require_relative './chess/pieces/piece'
require_relative './chess/pieces/pawn'
require_relative './chess/pieces/rook'
require_relative './chess/pieces/knight'
require_relative './chess/pieces/bishop'
require_relative './chess/pieces/queen'
require_relative './chess/pieces/king'
require_relative './chess/board'

require_relative './string'
