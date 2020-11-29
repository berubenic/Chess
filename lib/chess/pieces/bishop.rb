# frozen_string_literal: true

module Chess
  # Bishop
  class Bishop < Piece
    include DirectionalMovement

    DIRECTIONS = [
      [1, -1],
      [1, 1],
      [-1, 1],
      [-1, -1]
    ].freeze

    def possible_movements
      reset_movements
      @movements = find_moves(DIRECTIONS)
    end

    def possible_captures
      reset_captures
      @captures = find_captures(DIRECTIONS)
    end
  end
end
