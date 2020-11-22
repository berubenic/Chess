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

    def check(king)
      board.each do |row|
        row.each do |tile|
          next if tile == ''
          next if tile == king

          return king.check if tile.captures.include?(king.coordinate)
        end
      end
      king.not_check
    end

    def mate(king)
      king.possible_movements
      return if king.movements.any? { |move| no_check?(move, king) }

      king.mate
    end

    def stalemate(king)
      king.possible_movements
      return if king.movements.any? { |move| no_check?(move, king) }

      king.stalemate
    end

    def castling(king, rook)
      short_castling(king, rook)
    end

    def short_castling(king, rook)
      return unless empty_tiles_for_short_castling?(king, rook)

      king.short_castling
      rook.short_castling
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

    def find_kings
      board.each do |row|
        row.each do |tile|
          next if tile == ''

          assign_kings(tile)
        end
      end
    end

    private

    def no_check?(move, king)
      board.each do |row|
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
