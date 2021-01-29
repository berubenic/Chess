# frozen_string_literal: true

require_relative '../modules/tile_helper'

module Chess
  # Utility functions for pieces
  module PieceHelper
    module_function

    def coordinate_outside_of_board?(coordinate)
      coordinate.any? { |number| number.negative? || number > 7 }
    end

    def add_moves_to_result(moves, result)
      moves.each { |move| result << move }
      result
    end

    def valid_move?(coordinate, array)
      within_board?(coordinate) && TileHelper.not_occupied?(coordinate, array)
    end

    def within_board?(coordinate)
      coordinate.all? { |number| number >= 0 && number <= 7 }
    end

    def valid_capture?(coordinate, array, color)
      within_board?(coordinate) && TileHelper.enemy_occupied?(coordinate, array, color)
    end

    def valid_tile_for_en_passant?(coordinate, board)
      return false unless within_board?(coordinate)

      TileHelper.valid_tile_for_en_passant?(coordinate, board)
    end
  end
end
