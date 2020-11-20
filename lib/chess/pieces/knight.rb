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

    def possible_movements
      MOVES.each do |x, y|
        move = [coordinate[0] + x, coordinate[1] + y]
        movements << move if valid_move?(move)
      end
    end

    def possible_captures
      MOVES.each do |x, y|
        capture = [coordinate[0] + x, coordinate[1] + y]
        captures << capture if valid_capture?(capture)
      end
    end
  end
end
