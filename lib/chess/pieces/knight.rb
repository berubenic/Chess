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

    def possible_captures(result = [])
      MOVES.each do |x, y|
        capture = [coordinate[0] + x, coordinate[1] + y]
        result << capture if valid_capture?(capture)
      end
      @captures = result
    end

    private

    def valid_capture?(capture)
      within_board?(capture) && !not_occupied?(capture) && !friendly_occupied?(capture)
    end

    def friendly_occupied?(capture)
      piece = board[capture[1]][capture[0]]
      piece.color == color
    end
  end
end
