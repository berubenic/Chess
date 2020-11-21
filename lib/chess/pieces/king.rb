# frozen_string_literal: true

module Chess
  # King
  class King < Piece
    include SingleMovement

    MOVES = [
      [0, -1],
      [1, -1],
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1]
    ].freeze

    def initialize(**args)
      @checkmate = false
      super
    end

    def possible_movements
      @movements = find_movements(MOVES)
    end

    def possible_captures
      @captures = find_captures(MOVES)
    end

    def checkmate
      @checkmate = true
    end
  end
end
