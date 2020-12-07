# frozen_string_literal: true

module Chess
  # Sets pieces for a normal game of chess
  class Board
    attr_reader :array

    def initialize(array: Array.new(8) { Array.new(8, '') })
      @array = array
    end

    def setup_white_pieces(row_eight = array[7], row_seven = array[6])
      setup_white_rooks(row_eight)
      setup_white_knights(row_eight)
      setup_white_bishops(row_eight)
      setup_white_king_and_queen(row_eight)
      setup_white_pawns(row_seven)
    end

    def setup_white_rooks(row_eight)
      row_eight[0] = WhiteRook.new(x_coordinate: 0)
      row_eight[7] = WhiteRook.new(x_coordinate: 7)
    end

    def setup_white_knights(row_eight)
      row_eight[6] = WhiteKnight.new(x_coordinate: 6)
      row_eight[1] = WhiteKnight.new(x_coordinate: 1)
    end

    def setup_white_bishops(row_eight)
      row_eight[2] = WhiteBishop.new(x_coordinate: 2)
      row_eight[5] = WhiteBishop.new(x_coordinate: 5)
    end

    def setup_white_king_and_queen(row_eight)
      row_eight[3] = WhiteQueen.new(x_coordinate: 3)
      row_eight[4] = WhiteKing.new(x_coordinate: 4)
    end

    def setup_white_pawns(row_seven)
      row_seven.each_with_index do |_tile, index|
        row_seven[index] = WhitePawn.new(x_coordinate: index)
      end
    end

    def setup_black_pieces(row_one = array[0], row_two = array[1])
      setup_black_rooks(row_one)
      setup_black_knights(row_one)
      setup_black_bishops(row_one)
      setup_black_king_and_queen(row_one)
      setup_black_pawns(row_two)
    end

    def setup_black_rooks(row_one)
      row_one[0] = BlackRook.new(x_coordinate: 0)
      row_one[7] = BlackRook.new(x_coordinate: 7)
    end

    def setup_black_knights(row_one)
      row_one[1] = BlackKnight.new(x_coordinate: 1)
      row_one[6] = BlackKnight.new(x_coordinate: 6)
    end

    def setup_black_bishops(row_one)
      row_one[2] = BlackBishop.new(x_coordinate: 2)
      row_one[5] = BlackBishop.new(x_coordinate: 5)
    end

    def setup_black_king_and_queen(row_one)
      row_one[3] = BlackQueen.new(x_coordinate: 3)
      row_one[4] = BlackKing.new(x_coordinate: 4)
    end

    def setup_black_pawns(row_two)
      row_two.each_with_index do |_tile, index|
        row_two[index] = BlackPawn.new(x_coordinate: index)
      end
    end
  end
end
