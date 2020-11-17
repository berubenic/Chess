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
      within_board?(move)
      not_occupied?(move)
    end

    def within_board?(move)
      move.all? { |coordinate| coordinate.between? 0, 7 }
    end

    def not_occupied?(move)
      board_tile = board[move[1]][move[0]]
      board_tile == ''
    end
  end
end
