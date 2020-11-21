# frozen_string_literal: true

module Chess
  # Rook
  class Rook < Piece
    include DirectionalMovement

    DIRECTIONS = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ].freeze

    def possible_movements
      @movements = find_moves(DIRECTIONS)
    end

    def possible_captures
      @captures = find_captures(DIRECTIONS)
    end
  end
end
