# frozen_string_literal: true

module Chess
  # King
  class King < Piece
    MOVES = [
      [0, 1],
      [1, 1],
      [1, 0],
      [1, -1],
      [0, -1],
      [-1, -1],
      [-1, 0],
      [-1, 1]
    ].freeze

    def possible_movements(result = [])
      MOVES.each do |x, y|
        move = [coordinate[0] + x, coordinate[1] + y]
        result << move if valid_move?(move)
      end
      @movements = result
    end
  end
end
