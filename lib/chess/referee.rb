# frozen_string_literal: true

require_relative './coordinate_helper'

module Chess
  # Utility function for check
  module Referee
    module_function

    def king_can_avoid_attack?(king, board)
      king.possible_movements
      return false if king.possible_movements.empty?

      return true if king.possible_movements.any? { |move| can_not_be_attacked?(move, king, board) }

      false
    end

    def can_not_be_attacked?(coordinate, king, board)
      color = king.color
      board.array.each do |row|
        return false if enemy_piece_in_row_can_discover_coordinate?(row, coordinate, color)
      end
    end

    def no_friendly_piece_can_move?(board, king, array = board.array)
      color = king.color
      array.all? do |row|
        next if row.all? { |tile| tile.is_a?(String) }
        next if row.all? do |tile|
          next if tile.is_a?(String)

          tile.color != color
        end

        moving_a_friendly_piece_in_row_causes_check?(king, row, board, color)
      end
    end

    def can_kill_checking_piece?(king, board, array = board.array)
      checking_piece = find_checking_piece(king, board.array)
      color = king.color
      array.each do |row|
        return true if friendly_can_kill_checking_piece_in_row?(row, checking_piece, color)
      end
      false
    end

    def friendly_can_kill_checking_piece_in_row?(row, checking_piece, color)
      coordinate = checking_piece.current_coordinate
      row.each do |tile|
        next if tile.is_a?(String)
        next if tile.color != color

        return true if tile.possible_captures.include?(coordinate)
      end
      false
    end

    def friendly_can_block?(king, board, array = board.array)
      checking_piece = find_checking_piece(king, board.array)
      color = king.color
      movements = CoordinateHelper.coordinates_between_king_and_checking_piece(king, checking_piece, board.array)
      array.each do |row|
        return true if friendly_can_block_in_row?(row, movements, color, king)
      end
      false
    end

    def friendly_can_block_in_row?(row, movements, color, king)
      row.each do |tile|
        next if tile.is_a?(String)
        next if tile.color != color
        next if tile == king

        tile.possible_movements.any? { |move| movements.include?(move) }
      end
      false
    end

    def find_checking_piece(king, array, color = king.color)
      coordinate = king.current_coordinate
      array.each do |row|
        piece = find_checking_piece_in_row(row, coordinate, color)
        return piece unless piece.nil?
      end
    end

    def find_checking_piece_in_row(row, coordinate, color)
      row.each do |tile|
        next if tile.is_a?(String)
        next if tile.color == color

        return tile if tile.possible_captures.include?(coordinate)
      end
      nil
    end

    def moving_a_friendly_piece_in_row_causes_check?(king, row, board, color)
      row.each do |tile|
        next if tile.is_a?(String)
        next if tile.color != color
        next if tile == king
        next if tile.can_not_move_or_capture?

        board.remove_tile(tile)
        if check?(board.array, king)
          board.replace_tile(tile)
          return true
        end
        board.replace_tile(tile)
        return false
      end
    end

    def check?(array, king, coordinate = king.current_coordinate)
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
