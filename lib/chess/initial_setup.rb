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

    def setup_white_rooks(row_eight, board)
      row_eight[0] = PieceFactory.create_white_piece(:rook, 0, board)
      row_eight[7] = PieceFactory.create_white_piece(:rook, 7, board)
    end

    def setup_white_knights(row_eight, board)
      row_eight[6] = PieceFactory.create_white_piece(:knight, 6, board)
      row_eight[1] = PieceFactory.create_white_piece(:knight, 1, board)
    end

    def setup_white_bishops(row_eight, board)
      row_eight[5] = PieceFactory.create_white_piece(:bishop, 5, board)
      row_eight[2] = PieceFactory.create_white_piece(:bishop, 2, board)
    end

    def setup_white_king_and_queen(row_eight, board)
      row_eight[3] = PieceFactory.create_white_piece(:queen, 3, board)
      row_eight[4] = PieceFactory.create_white_piece(:king, 4, board)
    end

    def setup_white_pawns(row_seven, board)
      row_seven.each_with_index do |_tile, index|
        row_seven[index] = PieceFactory.create_white_piece(:pawn, index, board)
      end
    end

    def setup_black_rooks(row_one, board)
      row_one[0] = PieceFactory.create_black_piece(:rook, 0, board)
      row_one[7] = PieceFactory.create_black_piece(:rook, 7, board)
    end

    def setup_black_knights(row_one, board)
      row_one[1] = PieceFactory.create_black_piece(:knight,  1, board)
      row_one[6] = PieceFactory.create_black_piece(:knight,  6, board)
    end

    def setup_black_bishops(row_one, board)
      row_one[2] = PieceFactory.create_black_piece(:bishop, 2, board)
      row_one[5] = PieceFactory.create_black_piece(:bishop, 5, board)
    end

    def setup_black_king_and_queen(row_one, board)
      row_one[3] = PieceFactory.create_black_piece(:queen, 3, board)
      row_one[4] = PieceFactory.create_black_piece(:king, 4, board)
    end

    def setup_black_pawns(row_two, board)
      row_two.each_with_index do |_tile, index|
        row_two[index] = PieceFactory.create_black_piece(:pawn, index, board)
      end
    end
  end
end
