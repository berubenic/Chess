# frozen_string_literal: true

module Chess
  # Utility functions for Board
  module TileHelper
    module_function

    def find_tile(selection, array)
      array[selection[1]][selection[0]]
    end

    def not_occupied?(coordinate, array)
      tile = find_tile(coordinate, array)
      tile == ''
    end

    def enemy_occupied?(coordinate, array, color)
      tile = find_tile(coordinate, array)
      return false if tile == ''

      tile.color != color
    end

    def friendly_occupied?(coordinate, array, color)
      tile = find_tile(coordinate, array)
      tile_belongs_to_player?(color, tile)
    end

    def tile_belongs_to_player?(color, tile)
      return false if tile == ''

      tile.color == color
    end

    def find_king(player, array)
      color = player.color
      array.each do |row|
        piece = find_piece_in_row(row, color, King)
        return piece if piece.is_a?(King)
      end
    end

    def find_piece_in_row(row, color, piece_class)
      row.each do |tile|
        next if tile.is_a?(String)
        return tile if tile.is_a?(piece_class) && tile.belongs_to_player?(color)
      end
      nil
    end

    def find_rook_for_castling(player, selection, array)
      case selection
      when 'short castle'
        find_rook_for_short_castling(player, array)
      when 'long castle'
        find_rook_for_long_castling(player, array)
      else
        NoMatchingPatternError
      end
    end

    def find_rook_for_short_castling(player, array)
      color = player.color
      array.each do |row|
        piece = find_rook_in_row_for_short_castling(row, color, Rook)
        return piece if piece.is_a?(Rook)
      end
    end

    def find_rook_in_row_for_short_castling(row, color, piece_class)
      row.each do |tile|
        next if tile.is_a?(String)
        if tile.is_a?(piece_class) && tile.belongs_to_player?(color) && tile.correct_x_coordinate_for_short_castling?
          return tile
        end
      end
      nil
    end

    def find_rook_for_long_castling(player, array)
      color = player.color
      array.each do |row|
        piece = find_rook_in_row_for_long_castling(row, color, Rook)
        return piece if piece.is_a?(Rook)
      end
    end

    def find_rook_in_row_for_long_castling(row, color, piece)
      row.each do |tile|
        next if tile.is_a?(String)
        if tile.is_a?(piece) && tile.belongs_to_player?(color) && tile.correct_x_coordinate_for_long_castling?
          return tile
        end
      end
      nil
    end

    def tile_between_king_and_rook_are_not_empty?(rook, array)
      coordinates_for_castling = rook.empty_coordinates_needed_for_castling
      coordinates_for_castling.any? do |coordinate|
        tile = find_tile(coordinate, array)
        tile != ''
      end
    end
  end
end
