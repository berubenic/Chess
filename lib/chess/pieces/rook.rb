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

    attr_reader :moved, :check, :mate, :stalemate

    def initialize(**args)
      @moved = false
      @short_castling = false
      super
    end

    def possible_movements
      @movements = find_moves(DIRECTIONS)
    end

    def possible_captures
      @captures = find_captures(DIRECTIONS)
    end

    def short_castling
      @short_castling = true
    end

    def long_castling
      @long_castling = true
    end
  end
end
