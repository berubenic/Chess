# frozen_string_literal: true

module Chess
  # Bishop
  class Bishop < Piece
    DIRECTIONS = [
      [1, -1],
      [1, 1],
      [-1, 1],
      [-1, -1]
    ].freeze

    def possible_movements
      @movements = []
      DIRECTIONS.each do |direction|
        result = validate_movements(direction)
        result.each { |coordinate| @movements << coordinate }
      end
    end

    def validate_movements(direction, result = [], current = coordinate)
      next_move = [current[0] + direction[0], current[1] + direction[1]]
      if valid_move?(next_move)
        result << next_move
        current = next_move
        validate_movements(direction, result, current)
      else
        result
      end
    end
  end
end
