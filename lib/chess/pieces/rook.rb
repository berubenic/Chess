# frozen_string_literal: true

module Chess
  # Rook
  class Rook < Piece
    include DirectionalMovement

    DIRECTIONS = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ].freeze

    attr_reader :check, :mate, :stalemate, :short_castling, :long_castling

    def initialize(**args)
      @short_castling = false
      @long_castling = false
      super
    end

    def possible_movements
      reset_movements
      @movements = find_moves(DIRECTIONS)
    end

    def possible_captures
      reset_captures
      @captures = find_captures(DIRECTIONS)
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
