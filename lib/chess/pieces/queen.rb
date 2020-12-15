# frozen_string_literal: true

require_relative './piece'

module Chess
  # Queen piece
  class Queen < Piece
    DIRECTIONS = [
      [1, -1],
      [1, 1],
      [-1, 1],
      [-1, -1],
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ].freeze

    def default_color
      raise NotImplementedError
    end

    def default_content
      raise NotImplementedError
    end

    def default_y_coordinate
      raise NotImplementedError
    end

    def possible_movements(directions = DIRECTIONS)
      super
    end

    def possible_captures(directions = DIRECTIONS)
      super
    end

    def possible_discoveries(directions = DIRECTIONS)
      super
    end
  end

  # WhiteQueen piece
  class WhiteQueen < Queen
    def default_color
      'white'
    end

    def default_content
      "\u2655"
    end

    def default_y_coordinate
      7
    end
  end

  # BlackQueen piece
  class BlackQueen < Queen
    def default_color
      'black'
    end

    def default_content
      "\u265B"
    end

    def default_y_coordinate
      0
    end
  end
end
