# frozen_string_literal: true

require_relative './piece'

module Chess
  # Bishop piece
  class Bishop < Piece
    attr_reader :board

    def initialize(**opts)
      @board = opts[:board]
      super
    end

    DIRECTIONS = [
      [1, -1],
      [1, 1],
      [-1, 1],
      [-1, -1]
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

    def possible_movements(directions = DIRECTIONS, array = board.array)
      super
    end

    def possible_captures(directions = DIRECTIONS, array = board.array)
      super
    end
  end

  # WhiteBishop piece
  class WhiteBishop < Bishop
    def default_color
      'white'
    end

    def default_content
      "\u2657"
    end

    def default_y_coordinate
      7
    end
  end

  # BlackBishop piece
  class BlackBishop < Bishop
    def default_color
      'black'
    end

    def default_content
      "\u265D"
    end

    def default_y_coordinate
      0
    end
  end
end
