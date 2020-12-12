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
        next if tile == king

        tile.possible_captures
        return true if tile.captures.include?(coordinate)
      end
    end

    def king_and_rook_have_moved?(king, rook)
      king.not_moved_from_starting_coordinate? && rook.not_moved_from_starting_coordinate?
    end
  end
end
