# frozen_string_literal: true

require_relative '../tile_helper'

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

    def valid_move?(move, board)
      within_board?(move) && TileHelper.not_occupied?(move, board)
    end

    def within_board?(coordinate)
      coordinate.all? { |number| number >= 0 && number <= 7 }
    end

    def valid_capture?(capture, board, color)
      within_board?(capture) && TileHelper.enemy_occupied?(capture, board, color)
    end

    def friendly_occupied?(coordinate, board, color)
      tile = TileHelper.find_tile(coordinate, board)
      TileHelper.tile_belongs_to_player?(color, tile)
    end
  end
end
