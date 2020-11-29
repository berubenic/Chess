# frozen_string_literal: true

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

    def check(king)
      board.board.each do |row|
        row.each do |tile|
          next if tile == ''
          next if tile == king

          return king.in_check if tile.captures.include?(king.coordinate)
        end
      end
      king.not_check
    end

    def mate(king)
      king.possible_movements
      return king.not_mate if king.movements.any? { |move| no_possible_check?(move, king) }

      king.mate
    end

    def stalemate(king)
      king.possible_movements
      return king.not_stalemate if king.movements.any? { |move| no_possible_check?(move, king) }

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

          assign_kings(tile)
        end
      end
    end

    private

    def no_possible_check?(move, king)
      board.board.each do |row|
        row.each do |tile|
          next if tile == ''
          next if tile == king

          return false if tile.movements.include?(move)
        end
      end
    end

    def assign_kings(tile)
      @white_king = tile if tile.is_a?(King) && tile.color == 'white'
      @black_king = tile if tile.is_a?(King) && tile.color == 'black'
    end
  end
end
