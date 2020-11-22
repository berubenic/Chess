# frozen_string_literal: true

module Chess
  # King
  class King < Piece
    include SingleMovement

    MOVES = [
      [0, -1],
      [1, -1],
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1]
    ].freeze

    def initialize(**args)
      @moved = false
      @check = false
      @mate = false
      @stalemate = false
      @short_castling = false
      @long_castling = false
      super
    end

    def possible_movements
      @movements = find_movements(MOVES)
    end

    def possible_captures
      @captures = find_captures(MOVES)
    end

    def check
      @check = true
    end

    def not_check
      @check = false
    end

    def mate
      @mate = true
    end

    def stalemate
      @stalemate = true
    end

    def short_castling
      @short_castling = true
    end
  end
end
