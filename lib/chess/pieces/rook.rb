# frozen_string_literal: true

module Chess
  # Rook
  class Rook < Piece
    DIRECTIONS = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ].freeze

    def possible_movements
      @movements = []
      DIRECTIONS.each do |direction|
        result = validate_movements(direction)
        result.each { |coordinate| @movements << coordinate }
      end
    end

    def possible_captures
      @captures = []
      DIRECTIONS.each do |direction|
        validate_captures(direction)
      end
    end

    private

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

    def validate_captures(direction, result = [], current = coordinate)
      next_move = [current[0] + direction[0], current[1] + direction[1]]
      if valid_capture?(next_move)
        @captures << next_move
      else
        current = next_move
        validate_movements(direction, result, current)
      end
    end
  end
end
