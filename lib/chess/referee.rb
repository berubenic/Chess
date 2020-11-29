# frozen_string_literal: true

require 'pry'

module Chess
  # looks for check, checkmate and stalemate
  class Referee
    include Castling

    attr_reader :board, :white_king, :black_king

    def initialize(board: nil)
      @board = board
      @white_king = nil
      @black_king = nil
    end

    def valid_selection?(selection, player)
      color = player.color
      tile = board.board[selection[1]][selection[0]]
      return false if tile == '' || tile.color != color

      true
    end

    def king_status
      white_king_status
      black_king_status
    end

    def checkmate?(player)
      king_status
      if player.color == 'white'
        white_king.check && white_king.mate
      elsif player.color == 'black'
        black_king.check && black_king.mate
      end
    end

    def check?(player)
      king_status
      if player.color == 'white'
        white_king.check
      elsif player.color == 'black'
        black_king.check
      end
    end

    def current_player_in_check?(player)
      king_status
      if player.color == 'white'
        return true if white_king.check

        false
      elsif player.color == 'black'
        return true if black_king.check

        false
      end
    end

    def white_king_status
      check(white_king)
      mate(white_king)
      stalemate(white_king)
    end

    def black_king_status
      check(black_king)
      mate(black_king)
      stalemate(black_king)
    end

    def check(king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)
          next if tile == king

          return king.in_check if tile.possible_captures.include?(king.coordinate)
        end
      end
      king.not_check
    end

    def mate(king)
      king.possible_movements
      return king.not_mate if king.possible_movements.any? { |move| no_possible_check?(move, king) }

      king.mate
    end

    def stalemate(king)
      king.possible_movements
      return king.not_stalemate if king.possible_movements.any? { |move| no_possible_check?(move, king) }

      king.stalemate
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

    def no_possible_check?(move, king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)
          next if tile == king

          tile.possible_movements
          next if tile.movements.nil?

          return false if tile.movements.include?(move)
        end
      end
    end

    def assign_kings(tile)
      @white_king = tile if tile.color == 'white'
      @black_king = tile if tile.color == 'black'
    end
  end
end
