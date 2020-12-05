# frozen_string_literal: true

require 'pry'

module Chess
  # looks for check, checkmate, stalemate and castling
  class Referee
    include Castling
    include WinConditions

    attr_reader :board, :white_king, :black_king, :short_white_rook, :long_white_rook, :short_black_rook,
                :long_black_rook, :checking_piece, :futur_checking_pieces

    def initialize(board: nil)
      @board = board
      @white_king = nil
      @black_king = nil
      @short_white_rook = nil
      @short_black_rook = nil
      @long_white_rook = nil
      @long_black_rook = nil
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

    # check

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

    # stalemate

    def current_player_stalemated?(player)
      if player.color == 'white'
        stalemate?(white_king)
      elsif player.color == 'black'
        stalemate?(black_king)
      end
    end

    def stalemate?(king)
      @futur_checking_pieces = []
      if king_can_avoid_attack?(king) || can_kill_future_checking_piece?(king) || friendly_can_block_future_checking_piece?(king)
        return false
      end

      true
    end

    # mate

    def enemy_player_mated?(player)
      if player.color == 'white'
        mate?(black_king)
      elsif player.color == 'black'
        mate?(white_king)
      end
    end

    def mate?(king)
      if can_kill_checking_piece?(king, checking_piece) || king_can_avoid_attack?(king) || friendly_can_block?(king, checking_piece)
        return false
      end

      true
    end

    # castling

    def valid_castling?(selection, player)
      return unless valid_castle_input?(selection)

      if selection == 'short castle'
        verify_player_short_castling(player)
        valid_short_castle?(player)
      elsif selection == 'long castle'
        verify_player_long_castling(player)
        valid_long_castle?(player)
      end
    end

    def valid_short_castle?(player)
      if player.color == 'white'
        white_king.short_castling
      elsif player.color == 'black'
        black_king.short_castling
      end
    end

    def valid_long_castle?(player)
      if player.color == 'white'
        white_king.long_castling
      elsif player.color == 'black'
        black_king.long_castling
      end
    end

    def valid_castle_input?(selection)
      return false if selection.nil?

      selection.downcase == 'short castle' || selection.downcase == 'long castle'
    end

    def verify_player_short_castling(player)
      if player.color == 'white'
        castling(white_king, short_white_rook)
      elsif player.color == 'black'
        castling(black_king, short_black_rook)
      end
    end

    def verify_player_long_castling(player)
      if player.color == 'white'
        castling(white_king, long_white_rook)
      elsif player.color == 'black'
        castling(black_king, long_black_rook)
      end
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

    def find_rooks
      board.board.each do |row|
        row.each do |tile|
          next if tile == ''

          assign_rooks(tile) if tile.is_a?(Rook)
        end
      end
    end

    def assign_kings(tile)
      @white_king = tile if tile.color == 'white'
      @black_king = tile if tile.color == 'black'
    end

    def assign_rooks(tile)
      @short_white_rook = tile if tile.coordinate == [7, 7]
      @short_black_rook = tile if tile.coordinate == [7, 0]
      @long_white_rook = tile if tile.coordinate == [0, 7]
      @long_black_rook = tile if tile.coordinate == [0, 0]
    end
  end
end
