# frozen_string_literal: true

require_relative './initial_setup'

module Chess
  # Sets pieces for a normal game of chess
  class Board
    attr_reader :array, :current_movements, :current_captures

    def initialize(array: Array.new(8) { Array.new(8, '') })
      @array = array
      @current_movements = nil
      @current_captures = nil
    end

    def add_moves_and_captures(piece)
      @current_movements = piece.possible_movements
      @current_captures = piece.possible_captures
      add_moves unless current_movements.empty?
      add_captures unless current_captures.empty?
    end

    def add_moves(content = 'o')
      current_movements.each do |move|
        update_array(move, content)
      end
    end

    def update_array(coordinate, content)
      @array[coordinate[1]][coordinate[0]] = content
    end

    def add_captures
      current_captures.each do |capture|
        update_capturable_piece(capture)
      end
    end

    def update_capturable_piece(coordinate)
      piece = array[coordinate[1]][coordinate[0]]
      piece.can_be_captured
    end

    def setup_board
      setup_white_pieces
      setup_black_pieces
    end

    def setup_white_pieces(row_eight = array[7], row_seven = array[6])
      InitialSetup.setup_white_rooks(row_eight, self)
      InitialSetup.setup_white_knights(row_eight, self)
      InitialSetup.setup_white_bishops(row_eight, self)
      InitialSetup.setup_white_king_and_queen(row_eight, self)
      InitialSetup.setup_white_pawns(row_seven, self)
    end

    def setup_black_pieces(row_one = array[0], row_two = array[1])
      InitialSetup.setup_black_rooks(row_one, self)
      InitialSetup.setup_black_knights(row_one, self)
      InitialSetup.setup_black_bishops(row_one, self)
      InitialSetup.setup_black_king_and_queen(row_one, self)
      InitialSetup.setup_black_pawns(row_two, self)
    end
  end
end
