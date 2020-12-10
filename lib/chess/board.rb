# frozen_string_literal: true

require_relative './initial_setup'

module Chess
  # Sets pieces for a normal game of chess
  class Board
    attr_reader :array

    def initialize(array: Array.new(8) { Array.new(8, '') })
      @array = array
    end

    def setup_board
      setup_white_pieces
      setup_black_pieces
    end

    def setup_white_pieces(row_eight = array[7], row_seven = array[6])
      InitialSetup.setup_white_rooks(row_eight)
      InitialSetup.setup_white_knights(row_eight)
      InitialSetup.setup_white_bishops(row_eight)
      InitialSetup.setup_white_king_and_queen(row_eight)
      InitialSetup.setup_white_pawns(row_seven)
    end

    def setup_black_pieces(row_one = array[0], row_two = array[1])
      InitialSetup.setup_black_rooks(row_one)
      InitialSetup.setup_black_knights(row_one)
      InitialSetup.setup_black_bishops(row_one)
      InitialSetup.setup_black_king_and_queen(row_one)
      InitialSetup.setup_black_pawns(row_two)
    end
  end
end
