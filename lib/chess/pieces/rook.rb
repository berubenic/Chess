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
      DIRECTIONS.each do |direction|
        validate_captures(direction)
      end
    end

    private

    def validate_captures(direction, result = [], current = coordinate)
      return unless within_board?(current)

      next_move = [current[0] + direction[0], current[1] + direction[1]]
      if valid_capture?(next_move)
        captures << next_move
      else
        current = next_move
        validate_captures(direction, result, current)
      end
    end
  end
end
