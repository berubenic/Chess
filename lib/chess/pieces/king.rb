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

    attr_reader :moved, :check, :mate, :stalemate, :short_castling, :long_castling

    def initialize(**args)
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

    def in_check
      @check = true
    end

    def not_check
      @check = false
    end

    def in_mate
      @mate = true
    end

    def not_mate
      @mate = false
    end

    def in_stalemate
      @stalemate = true
    end

    def not_stalemate
      @stalemate = false
    end

    def allow_short_castling
      @short_castling = true
    end

    def disallow_short_castling
      @short_castling = false
    end

    def allow_long_castling
      @long_castling = true
    end

    def disallow_long_castling
      @long_castling = false
    end
  end
end
