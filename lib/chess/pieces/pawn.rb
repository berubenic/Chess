# frozen_string_literal: true

module Chess
  # Pawn
  class Pawn < Piece
    WHITE_MOVES = [
      -1,
      -2
    ].freeze

    BLACK_MOVES = [
      1,
      2
    ].freeze

    def possible_movements
      if color == 'white'
        possible_color_movements(WHITE_MOVES)
      elsif color == 'black'
        possible_color_movements(BLACK_MOVES)
      end
    end

    def possible_color_movements(moves)
      move = [coordinate[0], coordinate[1] + moves[0]]
      movements << move if valid_move?(move)
      return unless valid_move?(move)
      return if moved

      additional_move = [coordinate[0], coordinate[1] + moves[1]]
      movements << additional_move if valid_move?(additional_move)
    end
  end
end
