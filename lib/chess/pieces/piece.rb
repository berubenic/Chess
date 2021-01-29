# frozen_string_literal: true

require_relative './piece_helper'
require_relative '../modules/tile_helper'

module Chess
  # Piece superclass
  class Piece
    include PieceHelper
    attr_reader :current_coordinate, :starting_coordinate, :color, :content, :capturable, :board

    def initialize(**opts)
      @current_coordinate = [opts[:x_coordinate], opts[:y_coordinate] || default_y_coordinate]
      @starting_coordinate = current_coordinate
      @color = opts[:color] || default_color
      @content = opts[:content] || default_content
      @board = opts[:board]
      @capturable = false
    end

    def default_color
      raise NotImplementedError
    end

    def default_content
      raise NotImplementedError
    end

    def default_y_coordinate
      raise NotImplementedError
    end

    def update_current_coordinate(coordinate)
      @current_coordinate = coordinate
    end

    def belongs_to_player?(player_color)
      color == player_color
    end

    def moved_from_initial_coordinate?
      starting_coordinate != current_coordinate
    end

    def can_not_move_or_capture?
      possible_movements.empty? && possible_captures.empty?
    end

    def can_be_captured
      @capturable = true
    end

    def can_not_be_captured
      @capturable = false
    end

    def possible_movements(directions, result = [])
      directions.each do |direction|
        moves = directional_movements(direction)
        result = PieceHelper.add_moves_to_result(moves, result)
      end
      result
    end

    def possible_captures(directions, result = [])
      directions.each do |direction|
        capture = directional_captures(direction)
        result << capture unless capture.empty?
      end
      result
    end

    def possible_discoveries(directions)
      possible_movements(directions)
    end

    def directional_movements(direction, result = [], coordinate = current_coordinate)
      array = board.array
      next_move = [coordinate[0] + direction[0], coordinate[1] + direction[1]]
      return result if PieceHelper.coordinate_outside_of_board?(next_move) ||
                       TileHelper.friendly_occupied?(next_move, array, color)

      continue_with_next_coordinate(direction, result, next_move) if PieceHelper.valid_move?(next_move, array)

      result
    end

    def continue_with_next_coordinate(direction, result, next_move)
      result << next_move
      current = next_move
      directional_movements(direction, result, current)
    end

    def directional_captures(direction, array = board.array, coordinate = current_coordinate)
      next_move = [coordinate[0] + direction[0], coordinate[1] + direction[1]]
      return [] if PieceHelper.coordinate_outside_of_board?(next_move) ||
                   TileHelper.friendly_occupied?(next_move, array, color)

      if PieceHelper.valid_capture?(next_move, array, color)
        next_move
      else
        current = next_move
        directional_captures(direction, array, current)
      end
    end
  end
end
