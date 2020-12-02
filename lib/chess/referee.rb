# frozen_string_literal: true

require 'pry'

module Chess
  # looks for check, checkmate and stalemate
  class Referee
    include Castling

    attr_reader :board, :white_king, :black_king, :checking_piece

    def initialize(board: nil)
      @board = board
      @white_king = nil
      @black_king = nil
      @checking_piece = nil
    end

    def valid_selection?(selection, player)
      return false if selection.nil?

      color = player.color
      tile = board.board[selection[1]][selection[0]]
      return false if tile == '' || tile.color != color

      true
    end

    def enemy_player_checkmated?(player)
      enemy_player_checked?(player) && enemy_player_mated?(player)
    end

    def current_player_checked?(player)
      if player.color == 'white'
        check?(white_king)
      elsif player.color == 'black'
        check?(black_king)
      end
    end

    def enemy_player_checked?(player)
      if player.color == 'white'
        check?(black_king)
      elsif player.color == 'black'
        check?(white_king)
      end
    end

    def current_player_stalemated?(player)
      if player.color == 'white'
        stalemate?(white_king)
      elsif player.color == 'black'
        stalemate?(black_king)
      end
    end

    def enemy_player_mated?(player)
      if player.color == 'white'
        mate?(black_king)
      elsif player.color == 'black'
        mate?(white_king)
      end
    end

    def check?(king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)
          next if tile == king

          tile.possible_captures
          next if tile.captures.nil?

          return king_is_in_check(tile) if tile.captures.include?(king.coordinate)
        end
      end
      @checking_piece = nil
      false
    end

    def king_is_in_check(tile)
      @checking_piece = tile
      true
    end

    def stalemate?(king)
      king.possible_movements
      return false if king.movements.any? { |move| can_avoid_attack?(move, king) }

      true
    end

    def mate?(king)
      king.possible_movements
      king.possible_captures
      # king can kill @checking_piece
      return false if king_can_kill_checking_piece?(king) || king_can_avoid_attack?(king) || friendly_can_block?(king)

      # king can move to unattackable tile
      # if @checking piece is a queen, rook or bishop
      #   a friendly can move to @checking piece movement

      # return false if king.movements.any? { |move| can_avoid_attack?(move, king) }

      true
    end

    def king_can_kill_checking_piece?(king)
      return false if king.captures.nil?

      king.captures.include?(checking_piece.coordinate)
    end

    def king_can_avoid_attack?(king)
      return false if king.movements.nil? || king.movements.empty?

      return true if king.movements.any? { |move| can_not_be_attacked?(move, king) }

      false
    end

    def can_not_be_attacked?(move, king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String) || tile == king || tile.color == king.color

          if tile.is_a?(Pawn)
            return false if pawn_can_attack?(move, tile)

            next
          else
            tile.possible_movements
            next if tile.movements.nil?
            return false if tile.movements.include?(move)
          end
        end
      end
      true
    end

    def pawn_can_attack?(move, pawn)
      if tile.color == 'black'
        black_pawn_can_attack?(move, pawn)
      elsif tile.color == 'white'
        white_pawn_can_attack?(move, pawn)
      end
    end

    def black_pawn_can_attack?(move, pawn)
      left_attack = [pawn.coordinate[0] - 1, pawn.coordinate[1] + 1]
      right_attack = [pawn.coordinate[0] + 1, pawn.coordinate[1] + 1]
      return true if left_attack == move || right_attack == move

      false
    end

    def white_pawn_can_attack?(move, pawn)
      left_attack = [pawn.coordinate[0] - 1, pawn.coordinate[1] - 1]
      right_attack = [pawn.coordinate[0] + 1, pawn.coordinate[1] - 1]
      return true if left_attack == move || right_attack == move

      false
    end

    def castling(king, rook)
      return unvalid_castling(king, rook) if king.check

      short_castling(king, rook)
      long_castling(king, rook)
    end

    def find_kings
      board.board.each do |row|
        row.each do |tile|
          next if tile == ''

          assign_kings(tile) if tile.is_a?(King)
        end
      end
    end

    private

    def assign_kings(tile)
      @white_king = tile if tile.color == 'white'
      @black_king = tile if tile.color == 'black'
    end
  end
end
