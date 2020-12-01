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
      return false if selection.nil?

      color = player.color
      tile = board.board[selection[1]][selection[0]]
      return false if tile == '' || tile.color != color

      true
    end

    def current_player_in_check?(player)
      if player.color == 'white'
        check?(white_king)
      elsif player.color == 'black'
        check?(black_king)
      end
    end

    def enemy_player_in_check?(player)
      if player.color == 'white'
        check?(black_king)
      elsif player.color == 'black'
        check?(white_king)
      end
    end

    def current_player_stalemate?(player)
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

          return true if tile.captures.include?(king.coordinate)
        end
      end
      false
    end

    def stalemate?(king)
      king.possible_movements
      return false if king.movements.any? { |move| can_not_be_attacked?(move, king) }
      return false if king.movements.empty?

      true
    end

    def mate?(king)
      king.possible_movements
      return false if king.movements.any? { |move| can_not_be_attacked?(move, king) }
      return false if king.movements.empty?

      true
    end

    def can_not_be_attacked?(coordinate, king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)
          next if tile == king
          next if tile.color == king.color

          tile.possible_movements
          next if tile.movements.nil?

          return false if tile.movements.include?(coordinate)
        end
      end
      true
    end

    def mate(king)
      king.possible_movements
      return king.not_mate if king.possible_movements.any? { |move| no_possible_check?(move, king) }

      king.mate
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
