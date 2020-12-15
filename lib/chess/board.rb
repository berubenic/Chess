# frozen_string_literal: true

require_relative './initial_setup'

module Chess
  # Sets pieces for a normal game of chess
  class Board
    attr_reader :array, :current_movements, :current_captures, :last_captured_piece, :last_moved_piece

    def initialize(array: Array.new(8) { Array.new(8, '') })
      @array = array
      @current_movements = nil
      @current_captures = nil
      @last_captured_piece = nil
      @last_moved_piece = nil
    end

    def execute_action(action, piece)
      verify_pawn_moved_two_squares(action, piece) if piece.is_a?(Pawn)
      @last_moved_piece = piece
      update_last_captured_piece(action)
      update_board(action, piece)
    end

    def update_board(action, piece)
      coordinate = piece.current_coordinate
      array[coordinate[1]][coordinate[0]] = ''
      array[action[1]][action[0]] = piece
      # return unless piece.is_a?(Pawn) && piece.en_passant_captures.include?(action)
      # update_en_passant_execution(action, selection, piece)
    end

    def update_last_captured_piece(action)
      @last_captured_piece = if array[action[1]][action[0]].is_a?(String)
                               nil
                             else
                               array[action[1]][action[0]]
                             end
    end

    def verify_pawn_moved_two_squares(action, piece)
      coordinate = piece.current_coordinate
      if (coordinate[1] - action[1]) == 2 || (coordinate[1] - action[1]) == -2
        piece.moved_two_squares
      else
        piece.did_not_move_two_squares
      end
    end

    def valid_action?(coordinate)
      current_movements.include?(coordinate) || current_captures.include?(coordinate)
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
