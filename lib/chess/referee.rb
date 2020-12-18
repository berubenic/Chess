# frozen_string_literal: true

module Chess
  # Utility function for check
  module Referee
    module_function

    def check?(array, king)
      coordinate = king.current_coordinate
      array.each do |row|
        return true if enemy_piece_in_row_can_attack_coordinate?(row, coordinate)
      end
      false
    end

    def castling_tile_can_be_attacked?(king, rook, array)
      coordinate = king.castling_coordinate(rook)
      color = king.color
      array.each do |row|
        return true if enemy_piece_in_row_can_discover_coordinate?(row, coordinate, color)
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

    def enemy_piece_in_row_can_discover_coordinate?(row, coordinate, color)
      row.each do |tile|
        next if tile.is_a?(String)
        next if tile.color == color

        return true if tile.possible_discoveries.include?(coordinate)
      end
      false
    end

    def king_or_rook_have_moved?(king, rook)
      king.moved_from_initial_coordinate? || rook.moved_from_initial_coordinate?
    end
  end
end
