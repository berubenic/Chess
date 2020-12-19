# frozen_string_literal: true

require_relative './piece'
require_relative './piece_helper'

module Chess
  # Pawn piece
  class Pawn < Piece
    attr_reader :moved_two_squares

    def default_color
      raise NotImplementedError
    end

    def default_content
      raise NotImplementedError
    end

    def default_y_coordinate
      raise NotImplementedError
    end

    def can_not_move_or_capture?
      possible_movements.empty? && possible_captures.empty? && possible_en_passant.empty?
    end

    def did_move_two_squares
      @moved_two_squares = true
    end

    def did_not_move_two_squares
      @moved_two_squares = false
    end

    def verify_if_moved_two_squares(action_coordinate)
      if (current_coordinate[1] - action_coordinate[1]) == 2 || (current_coordinate[1] - action_coordinate[1]) == -2
        did_move_two_squares
      else
        did_not_move_two_squares
      end
    end

    def possible_movements(directions, result = [])
      result = first_possible_move(directions[0], result)
      return result unless current_coordinate == starting_coordinate

      second_possible_move(directions[1], result)
    end

    def first_possible_move(direction, result = [])
      move = [current_coordinate[0], current_coordinate[1] + direction]
      result << move if PieceHelper.valid_move?(move, board.array)
      result
    end

    def second_possible_move(direction, result = [])
      additional_move = [current_coordinate[0], current_coordinate[1] + direction]
      result << additional_move if PieceHelper.valid_move?(additional_move, board.array)
      result
    end

    def possible_captures(directions, result = [])
      directions.each do |x_coordinate, y_coordinate|
        capture = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << capture if PieceHelper.valid_capture?(capture, board.array, color)
      end
      result
    end

    def possible_discoveries(directions, result = [])
      directions.each do |x_coordinate, y_coordinate|
        capture = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << capture if PieceHelper.valid_move?(capture, board.array)
      end
      result
    end

    def possible_en_passant(result = [])
      return [] unless en_passant_correct_row?

      result << left_en_passant unless left_en_passant.nil?
      result << right_en_passant unless right_en_passant.nil?
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

    def possible_movements(directions = MOVE_DIRECTIONS)
      super
    end

    def possible_captures(directions = CAPTURE_DIRECTIONS)
      super
    end

    def possible_discoveries(directions = CAPTURE_DIRECTIONS)
      super
    end

    def left_en_passant
      left_coordinate = [current_coordinate[0] - 1, current_coordinate[1]]
      return nil unless PieceHelper.valid_tile_for_en_passant?(left_coordinate, board)

      [left_coordinate[0], left_coordinate[1] - 1]
    end

    def right_en_passant
      right_coordinate = [current_coordinate[0] + 1, current_coordinate[1]]
      return nil unless PieceHelper.valid_tile_for_en_passant?(right_coordinate, board)

      [right_coordinate[0], right_coordinate[1] - 1]
    end

    def en_passant_correct_row?
      current_coordinate[1] == 3
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

    def possible_movements(directions = MOVE_DIRECTIONS)
      super
    end

    def possible_captures(directions = CAPTURE_DIRECTIONS)
      super
    end

    def possible_discoveries(directions = CAPTURE_DIRECTIONS)
      super
    end

    def left_en_passant
      left_coordinate = [current_coordinate[0] - 1, current_coordinate[1]]
      return nil unless PieceHelper.valid_tile_for_en_passant?(left_coordinate, board)

      [left_coordinate[0], left_coordinate[1] + 1]
    end

    def right_en_passant
      right_coordinate = [current_coordinate[0] + 1, current_coordinate[1]]
      return nil unless PieceHelper.valid_tile_for_en_passant?(right_coordinate, board)

      [right_coordinate[0], right_coordinate[1] + 1]
    end

    def en_passant_correct_row?
      current_coordinate[1] == 4
    end
  end
end
