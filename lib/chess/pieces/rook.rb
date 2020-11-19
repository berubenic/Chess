# frozen_string_literal: true

module Chess
  # Rook
  class Rook < Piece
    MOVES = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ].freeze

    def possible_movements
      @movements = []
      MOVES.each do |move|
        result = validate_movements(move)
        result.each { |coordinate| @movements << coordinate }
      end
    end

    def validate_movements(move, result = [], current = coordinate)
      next_move = [current[0] + move[0], current[1] + move[1]]
      if valid_move?(next_move)
        result << next_move
        current = next_move
        validate_movements(move, result, current)
      else
        result
      end
    end
  end
end
