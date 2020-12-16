# frozen_string_literal: true

require_relative './piece'
require_relative './single_movement'

module Chess
  # Knight piece
  # noinspection DuplicatedCode
  class Knight < Piece
    include SingleMovement
    attr_reader :board

    def initialize(**opts)
      @board = opts[:board]
      super
    end

    DIRECTIONS = [
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2],
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1]
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

    def possible_discoveries(directions = DIRECTIONS)
      possible_movements(directions)
    end
  end

  # WhiteKnight piece
  class WhiteKnight < Knight
    def default_color
      'white'
    end

    def default_content
      "\u2658"
    end

    def default_y_coordinate
      7
    end
  end

  # BlackKnight piece
  class BlackKnight < Knight
    def default_color
      'black'
    end

    def default_content
      "\u265E"
    end

    def default_y_coordinate
      0
    end
  end
end
