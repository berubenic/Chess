# frozen_string_literal: true

require_relative './piece'

module Chess
  # Pawn piece
  class Pawn < Piece
    def default_color
      raise NotImplementedError
    end

    def default_content
      raise NotImplementedError
    end

    def default_y_coordinate
      raise NotImplementedError
    end

    def all_possible_movements(directions, result = [])
      result = first_possible_move(directions[0], result)
      return result unless current_coordinate == starting_coordinate

      second_possible_move(directions[1], result)
    end

    def first_possible_move(direction, result = [])
      move = [current_coordinate[0], current_coordinate[1] + direction]
      result << move
      result
    end

    def second_possible_move(direction, result = [])
      additional_move = [current_coordinate[0], current_coordinate[1] + direction]
      result << additional_move
      result
    end

    def all_possible_captures(directions, result = [])
      directions.each do |x_coordinate, y_coordinate|
        capture = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << capture
      end
      result
    end
  end

  # WhitePawn piece
  class WhitePawn < Pawn
    MOVE_DIRECTIONS = [
      -1,
      -2
    ].freeze

    CAPTURE_DIRECTIONS = [
      [1, -1],
      [-1, -1]
    ].freeze

    def default_color
      'white'
    end

    def default_content
      "\u2659"
    end

    def default_y_coordinate
      6
    end

    def all_possible_movements(directions = MOVE_DIRECTIONS)
      super
    end

    def all_possible_captures(directions = CAPTURE_DIRECTIONS)
      super
    end
  end

  # BlackPawn piece
  class BlackPawn < Pawn
    MOVE_DIRECTIONS = [
      1,
      2
    ].freeze

    CAPTURE_DIRECTIONS = [
      [1, 1],
      [-1, 1]
    ].freeze

    def default_color
      'black'
    end

    def default_content
      "\u265F"
    end

    def default_y_coordinate
      1
    end

    def all_possible_movements(directions = MOVE_DIRECTIONS)
      super
    end

    def all_possible_captures(directions = CAPTURE_DIRECTIONS)
      super
    end
  end
end
