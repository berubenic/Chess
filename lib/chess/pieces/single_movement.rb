# frozen_string_literal: true

require_relative './piece_helper'

module Chess
  # move method for King and Knight
  module SingleMovement
    module_function

    def possible_movements(directions, coordinate, array, result = [])
      directions.each do |x_coordinate, y_coordinate|
        move = [coordinate[0] + x_coordinate, coordinate[1] + y_coordinate]
        result << move if PieceHelper.valid_move?(move, array)
      end
      result
    end
  end
end