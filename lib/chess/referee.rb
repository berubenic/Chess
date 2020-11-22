# frozen_string_literal: true

module Chess
  # looks for check, checkmate and stalemate
  class Referee
    attr_reader :board, :white_king, :black_king

    def initialize(board: nil)
      @board = board
      @white_king = nil
      @black_king = nil
    end

    def checkmate(king)
      board.each do |row|
        row.each do |tile|
          next if tile == ''
          next if tile == king

          return king.checkmate if tile.captures.include?(king.coordinate)
        end
      end
      king.not_checkmate
    end

    def find_kings
      board.each do |row|
        row.each do |tile|
          next if tile == ''

          assign_kings(tile)
        end
      end
    end

    def assign_kings(tile)
      @white_king = tile if tile.is_a?(King) && tile.color == 'white'
      @black_king = tile if tile.is_a?(King) && tile.color == 'black'
    end
  end
end
