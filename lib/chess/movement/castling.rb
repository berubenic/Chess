# frozen_string_literal: true

module Chess
  module Castling
    def short_castling(king, rook)
      return unless king_and_rook_valid_for_short?(king, rook)
      return unless empty_tiles_for_short_castling?(king, rook)

      return if empty_tile_for_king_can_be_attacked?(king, rook)

      king.short_castling
      rook.short_castling
    end

    def long_castling(king, rook)
      return unless king_and_rook_valid_for_long?(king, rook)
      return unless empty_tiles_for_long_castling?(king, rook)

      king.long_castling
      rook.long_castling
    end

    def empty_tile_for_king_can_be_attacked?(king, _rook)
      move = short_castle_king_coordinate(king)
      board.each do |row|
        row.each do |tile|
          next if tile == ''
          next if tile.color == king.color

          return pawn_possibilities(tile, move) if tile.class == Pawn

          return true if tile.movements.include?(move)
        end
      end
      false
    end

    def pawn_possibilities(tile, move)
      if tile.color == 'black'
        [tile.coordinate[0] - 1, tile.coordinate[1] + 1] == move || [tile.coordinate[0] + 1, tile.coordinate[1] - 1] == move
      end
    end

    def short_castle_king_coordinate(king)
      if king.color == 'white'
        [6, 7]
      elsif king.color == 'black'
        [6, 0]
      end
    end

    def king_and_rook_valid_for_long?(king, rook)
      return false if king.moved && rook.moved

      color = validate_color(king, rook)
      if color == 'white'
        rook.coordinate == [0, 7]
      elsif color == 'black'
        rook.coordinate == [0, 0]
      end
    end

    def empty_tiles_for_long_castling?(king, rook)
      color = validate_color(king, rook)
      if color == 'white'
        board[7][1] == '' && board[7][2] == '' && board[7][3] == ''
      elsif color == 'black'
        board[0][1] == '' && board[0][2] == '' && board[0][3] == ''
      end
    end

    def king_and_rook_valid_for_short?(king, rook)
      return false if king.moved && rook.moved

      color = validate_color(king, rook)
      if color == 'white'
        rook.coordinate == [7, 7]
      elsif color == 'black'
        rook.coordinate == [7, 0]
      end
    end

    def empty_tiles_for_short_castling?(king, rook)
      color = validate_color(king, rook)
      if color == 'white'
        board[7][5] == '' && board[7][6] == ''
      elsif color == 'black'
        board[0][5] == '' && board[0][6] == ''
      end
    end

    def validate_color(king, rook)
      color = 'white' if king.color == 'white' && rook.color == 'white'
      color = 'black' if king.color == 'black' && rook.color == 'black'
      color
    end
  end
end
