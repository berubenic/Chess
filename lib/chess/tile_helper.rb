# frozen_string_literal: true

module Chess
  # Utility functions for Board
  module TileHelper
    module_function

    def find_tile(selection, array)
      array[selection[1]][selection[0]]
    end

    def tile_belongs_to_player?(color, tile)
      return false if tile == ''

      tile.color == color
    end

    def find_king(player, board)
      color = player.color
      board.each do |row|
        piece = find_piece_in_row(row, color, King)
        return piece if piece.is_a?(King)
      end
    end

    def find_piece_in_row(row, color, piece)
      row.each do |tile|
        next if tile.is_a?(String)
        return tile if tile.is_a?(piece) && tile_belongs_to_player?(color, tile)
      end
    end

    def find_rook_for_short_castling(player, board)
      color = player.color
      board.each do |row|
        piece = find_piece_in_row_for_short_castling(row, color, Rook)
        return piece if piece.is_a?(Rook)
      end
    end

    def find_piece_in_row_for_short_castling(row, color, piece)
      row.each do |tile|
        next if tile.is_a?(String)
        if tile.is_a?(piece) && tile_belongs_to_player?(color, tile) && correct_x_coordinate_for_short_castling?(tile)
          return tile
        end
      end
    end

    def correct_x_coordinate_for_short_castling?(tile, x_coordinate = 7)
      tile.current_coordinate[0] == x_coordinate
    end

    def find_rook_for_long_castling(player, board)
      color = player.color
      board.each do |row|
        piece = find_piece_in_row_for_long_castling(row, color, Rook)
        return piece if piece.is_a?(Rook)
      end
    end

    def find_piece_in_row_for_long_castling(row, color, piece)
      row.each do |tile|
        next if tile.is_a?(String)
        if tile.is_a?(piece) && tile_belongs_to_player?(color, tile) && correct_x_coordinate_for_long_castling?(tile)
          return tile
        end
      end
    end

    def correct_x_coordinate_for_long_castling?(tile, x_coordinate = 0)
      tile.current_coordinate[0] == x_coordinate
    end
  end
end
