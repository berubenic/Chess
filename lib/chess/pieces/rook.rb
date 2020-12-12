# frozen_string_literal: true

require_relative './piece'

module Chess
  # Rook piece
  class Rook < Piece
    DIRECTIONS = [
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

    def all_possible_movements(directions = DIRECTIONS, result = [])
      directions.each do |direction|
        moves = directional_movements(direction)
        result = PieceHelper.add_moves_to_result(moves, result)
      end
      result
    end

    def directional_movements(direction, result = [], coordinate = current_coordinate)
      next_move = [coordinate[0] + direction[0], coordinate[1] + direction[1]]
      return result if PieceHelper.coordinate_outside_of_board?(next_move)

      result << next_move
      current = next_move
      directional_movements(direction, result, current)
    end

    def all_possible_captures(directions = DIRECTIONS, result = [])
      directions.each do |direction|
        moves = directional_movements(direction)
        result = PieceHelper.add_moves_to_result(moves, result)
      end
      result
    end

    def correct_x_coordinate_for_short_castling?(x_coordinate = 7)
      current_coordinate[0] == x_coordinate
    end

    def correct_x_coordinate_for_long_castling?(x_coordinate = 0)
      current_coordinate[0] == x_coordinate
    end
  end

  # WhiteRook piece
  class WhiteRook < Rook
    def default_color
      'white'
    end

    def default_content
      "\u2656"
    end

    def default_y_coordinate
      7
    end

    def empty_coordinates_needed_for_castling
      case starting_coordinate
      when [0, 7]
        [[1, 7], [2, 7], [3, 7]]
      when [7, 7]
        [[6, 7], [5, 7]]
      end
    end
  end

  # BlackRook piece
  class BlackRook < Rook
    def default_color
      'black'
    end

    def default_content
      "\u265C"
    end

    def default_y_coordinate
      0
    end

    def empty_coordinates_needed_for_castling
      case starting_coordinate
      when [0, 0]
        [[1, 0], [2, 0], [3, 0]]
      when [7, 0]
        [[6, 0], [5, 0]]
      end
    end
  end
end
