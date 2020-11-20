# frozen_string_literal: true

module Chess
  # Knight
  class Knight < Piece
    include SingleMovement

    MOVES = [
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2],
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1]
    ].freeze

    def possible_movements
      @movements = find_movements(MOVES)
    end

    def possible_captures
      @captures = find_captures(MOVES)
    end
  end
end
