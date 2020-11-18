# frozen_string_literal: true

module Chess
  # King
  class King < Piece
    MOVES = [
      [0, 1],
      [1, 1],
      [1, 0],
      [1, -1],
      [0, -1],
      [-1, -1],
      [-1, 0],
      [-1, 1]
    ].freeze
  end
end
