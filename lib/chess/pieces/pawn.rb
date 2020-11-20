# frozen_string_literal: true

module Chess
  # Pawn
  class Pawn < Piece
    def initialize(*)
      super()
      @moved = false
    end

    def possible_movements; end
  end
end
