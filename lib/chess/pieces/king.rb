# frozen_string_literal: true

require_relative './piece'

module Chess
  # King piece
  class King < Piece
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

    def all_possible_movements(directions = DIRECTIONS, result = [])
      directions.each do |x_coordinate, y_coordinate|
        move = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << move
      end
      result
    end

    def all_possible_captures(directions = DIRECTIONS, result = [])
      directions.each do |x_coordinate, y_coordinate|
        move = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << move
      end
      result
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
