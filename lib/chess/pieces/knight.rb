# frozen_string_literal: true

module Chess
  # Knight
  class Knight < Piece
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

    def possible_movements(result = [])
      MOVES.each do |x, y|
        move = [coordinate[0] + x, coordinate[1] + y]
        result << move if valid_move?(move)
      end
      @movements = result
    end

    private

    def valid_move?(move)
      move.all? { |coordinate| coordinate.between? 0, 7 }
    end
  end
end
