# frozen_string_literal: true

module Chess
  # Pieces
  class Piece
    attr_reader :color, :current_position, :count
    def initialize(color:, current_position:, count: 0)
      @color = color
      @current_position = current_position
      @count = count
    end

    def update_position(coordinate)
      @current_position = coordinate
    end

    private

    def with_in_board?(coord)
      coord.all? { |num| num >= 0 && num <= 7 }
    end
  end

  # Pawn
  class Pawn < Piece
    private

    def possible_moves(x, y)
      possibilities = [
        [x, y + 2],
        [x, y + 1],
        [x, y - 2],
        [x, y - 1]
      ]

      possibilities.keep_if { |coord| with_in_board?(coord) }
    end
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
