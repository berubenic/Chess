# frozen_string_literal: true

require_relative './pieces/rook'
require_relative './pieces/pawn'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/queen'
require_relative './pieces/king'
require_relative './pieces/piece_factory'

module Chess
  # creates and places pieces for a normal game of chess
  module InitialSetup
    module_function

    def setup_white_rooks(row_eight)
      row_eight[0] = PieceFactory.create_white_piece(:rook, x_coordinate: 0)
      row_eight[7] = PieceFactory.create_white_piece(:rook, x_coordinate: 7)
    end

    def setup_white_knights(row_eight)
      row_eight[6] = PieceFactory.create_white_piece(:knight, x_coordinate: 6)
      row_eight[1] = PieceFactory.create_white_piece(:knight, x_coordinate: 1)
    end

    def setup_white_bishops(row_eight)
      row_eight[5] = PieceFactory.create_white_piece(:bishop, x_coordinate: 5)
      row_eight[2] = PieceFactory.create_white_piece(:bishop, x_coordinate: 2)
    end

    def setup_white_king_and_queen(row_eight)
      row_eight[3] = PieceFactory.create_white_piece(:queen, x_coordinate: 3)
      row_eight[4] = PieceFactory.create_white_piece(:king, x_coordinate: 4)
    end

    def setup_white_pawns(row_seven)
      row_seven.each_with_index do |_tile, index|
        row_seven[index] = PieceFactory.create_white_piece(:pawn, x_coordinate: index)
      end
    end

    def setup_black_rooks(row_one)
      row_one[0] = PieceFactory.create_black_piece(:rook, x_coordinate: 0)
      row_one[7] = PieceFactory.create_black_piece(:rook, x_coordinate: 7)
    end

    def setup_black_knights(row_one)
      row_one[1] = PieceFactory.create_black_piece(:knight, x_coordinate: 1)
      row_one[6] = PieceFactory.create_black_piece(:knight, x_coordinate: 6)
    end

    def setup_black_bishops(row_one)
      row_one[2] = PieceFactory.create_black_piece(:bishop, x_coordinate: 2)
      row_one[5] = PieceFactory.create_black_piece(:bishop, x_coordinate: 5)
    end

    def setup_black_king_and_queen(row_one)
      row_one[3] = PieceFactory.create_black_piece(:queen, x_coordinate: 3)
      row_one[4] = PieceFactory.create_black_piece(:king, x_coordinate: 4)
    end

    def setup_black_pawns(row_two)
      row_two.each_with_index do |_tile, index|
        row_two[index] = PieceFactory.create_black_piece(:pawn, x_coordinate: index)
      end
    end
  end
end
