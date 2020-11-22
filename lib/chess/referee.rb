# frozen_string_literal: true

module Chess
  # looks for check, checkmate and stalemate
  class Referee
    attr_reader :board, :kings

    def initialize(board: nil)
      @board = board
      @kings = []
    end

    def checkmate(king)
      board.each do |row|
        row.each do |tile|
          next if tile == ''
          next if tile == King

          return king.checkmate if tile.captures.include?(king.coordinate)
        end
      end
      king.not_checkmate
    end
  end
end
