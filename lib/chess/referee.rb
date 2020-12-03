# frozen_string_literal: true

require 'pry'

module Chess
  # looks for check, checkmate and stalemate
  class Referee
    include Castling
    include WinConditions

    attr_reader :board, :white_king, :black_king, :checking_piece, :futur_checking_pieces

    def initialize(board: nil)
      @board = board
      @white_king = nil
      @black_king = nil
      @checking_piece = nil
      @futur_checking_pieces = []
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
      @futur_checking_pieces = []
      if king_can_avoid_attack?(king) || can_kill_future_checking_piece?(king) || friendly_can_block_future_checking_piece?(king)
        return false
      end

      true
    end

    def mate?(king)
      if can_kill_checking_piece?(king, checking_piece) || king_can_avoid_attack?(king) || friendly_can_block?(king, checking_piece)
        return false
      end

      true
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
