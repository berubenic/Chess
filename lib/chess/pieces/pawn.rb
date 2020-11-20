# frozen_string_literal: true

module Chess
  # Pawn
  class Pawn < Piece
    include SingleMovement

    WHITE_MOVES = [
      -1,
      -2
    ].freeze

    WHITE_CAPTURES = [
      [1, -1],
      [-1, -1]
    ].freeze

    BLACK_MOVES = [
      1,
      2
    ].freeze

    BLACK_CAPTURES = [
      [1, 1],
      [-1, 1]
    ].freeze

    def possible_movements
      if color == 'white'
        first_possible_move(WHITE_MOVES)
      elsif color == 'black'
        first_possible_move(BLACK_MOVES)
      end
    end

    def possible_captures
      if color == 'white'
        @captures = find_captures(WHITE_CAPTURES)
      elsif color == 'black'
        @captures = find_captures(BLACK_CAPTURES)
      end
    end

    private

    def first_possible_move(moves)
      move = [coordinate[0], coordinate[1] + moves[0]]
      movements << move if valid_move?(move)
      return unless valid_move?(move)
      return if moved

      second_possible_move(moves)
    end

    def second_possible_move(moves)
      additional_move = [coordinate[0], coordinate[1] + moves[1]]
      movements << additional_move if valid_move?(additional_move)
    end
  end
end
