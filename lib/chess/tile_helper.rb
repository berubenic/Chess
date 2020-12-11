# frozen_string_literal: true

module Chess
  # Utility functions for Board
  module TileHelper
    module_function

    def find_tile(selection, array)
      array[selection[1]][selection[0]]
    end

    def tile_belongs_to_player?(color, tile)
      tile != '' || tile.color == color
    end

    def find_king(player, board, king = King)
      color = player.color
      board.each do |row|
        piece = find_piece_in_row(row, color, king)
        return piece if piece.is_a?(king)
      end
    end

    def find_piece_in_row(row, color, piece)
      row.each do |tile|
        next if tile.is_a?(String)
        return tile if tile.is_a?(piece) && tile_belongs_to_player?(color, tile)
      end
    end

    def find_rook_for_short_castling(player, board)
      rook = Rook
      color = player.color
      board.each do |row|
        piece = find_piece_in_row_for_short_castling(row, color, rook)
        return piece if piece.is_a?(rook)
      end
    end

    def find_piece_in_row_for_short_castling(row, color, piece)
      row.each do |tile|
        next if tile.is_a?(string)
        if tile.is_a?(piece) && tile_belongs_to_player?(color, tile) && correct_x_coordinate_for_short_castling?(tile)
          return tile
        end
      end
    end

    def correct_x_coordinate_for_short_castling?(tile, x_coordinate = 7)
      tile[0] == x_coordinate
    end

    def find_rook_for_long_castling(player, board)
      rook = Rook
      color = player.color
      board.each do |row|
        piece = find_piece_in_row_for_long_castling(row, color, rook)
        return piece if piece.is_a?(rook)
      end
    end

    def find_piece_in_row_for_long_castling(row, color, piece)
      row.each do |tile|
        next if tile.is_a?(string)
        if tile.is_a?(piece) && tile_belongs_to_player?(color, tile) && correct_x_coordinate_for_short_castling?(tile)
          return tile
        end
      end
    end

    def correct_x_coordinate_for_long_castling?(tile, x_coordinate = 0)
      tile[0] == x_coordinate
    end
  end
end
