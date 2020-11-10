# frozen_string_literal: true

module Chess
  # Pieces
  class Piece
    attr_reader :color, :current_position
    def initialize(color:, current_position:)
      @color = color
      @current_position = current_position
    end
  end

  class Pawn < Piece
  end

  class Rook < Piece
  end

  class Bishop < Piece
  end

  class Knight < Piece
  end

  class Queen < Piece
  end

  class King < Piece
  end
end
