# frozen_string_literal: true

module Chess
  # Utility function fors check
  module Referee
    module_function

    def check?(array, king)
      coordinate = king.current_coordinate
      array.each do |row|
        return true if enemy_piece_in_row_can_attack_coordinate?(row, coordinate)
      end
      false
    end

    def enemy_piece_in_row_can_attack_coordinate?(row, coordinate)
      row.each do |tile|
        next if tile.is_a?(String)

        return true if tile.possible_captures.include?(coordinate)
      end
      false
    end

    def king_or_rook_have_moved?(king, rook)
      king.moved_from_starting_coordinate? || rook.moved_from_starting_coordinate?
    end
  end
end
