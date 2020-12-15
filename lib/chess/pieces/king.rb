# frozen_string_literal: true

require_relative './piece'
require_relative './single_movement'

module Chess
  # King piece
  # noinspection DuplicatedCode
  class King < Piece
    include SingleMovement
    attr_reader :board

    def initialize(**opts)
      @board = opts[:board]
      super
    end

    DIRECTIONS = [
      [0, -1],
      [1, -1],
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
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

    def castling_coordinate(rook)
      x_coordinate = rook.starting_coordinate[0]
      y_coordinate = starting_coordinate[1]
      case x_coordinate
      when 0
        [2, y_coordinate]
      when 7
        [6, y_coordinate]
      else
        NoMatchingPatternError
      end
    end

    def possible_movements(directions = DIRECTIONS, coordinate = current_coordinate, array = board.array)
      super(directions, coordinate, array)
    end

    def possible_captures(directions = DIRECTIONS, result = [])
      directions.each do |x_coordinate, y_coordinate|
        capture = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << capture if PieceHelper.valid_capture?(capture, board.array, color)
      end
      result
    end

    def possible_discoveries(directions)
      possible_movements(directions)
    end
  end

  # WhiteKing piece
  class WhiteKing < King
    def default_color
      'white'
    end

    def default_content
      "\u2654"
    end

    def default_y_coordinate
      7
    end
  end

  # BlackKing piece
  class BlackKing < King
    def default_color
      'black'
    end

    def default_content
      "\u265A"
    end

    def default_y_coordinate
      0
    end
  end
end
