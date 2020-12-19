# frozen_string_literal: true

require_relative './initial_setup'

module Chess
  # Sets pieces for a normal game of chess
  class Board
    attr_reader :array, :current_movements, :current_captures, :current_en_passant, :last_captured_piece, :last_moved_piece

    def initialize(array: Array.new(8) { Array.new(8, '') })
      @array = array
      @current_movements = []
      @current_captures = []
      @current_en_passant = []
      @last_captured_piece = nil
      @last_moved_piece = nil
    end

    def revert_move(action_coordinate, piece)
      array[piece.current_coordinate[1]][piece.current_coordinate[0]] = piece
      return array[action_coordinate[1]][action_coordinate[0]] = '' if last_captured_piece.nil?

      revert_captured_piece
    end

    def revert_captured_piece(coordinate = last_captured_piece.current_coordinate)
      array[coordinate[1]][coordinate[0]] = last_captured_piece
      @last_captured_piece = nil
    end

    def execute_action(action_coordinate, piece)
      piece.verify_if_moved_two_squares(action_coordinate) if piece.is_a?(Pawn)
      @last_moved_piece = piece
      return execute_en_passant(action_coordinate, piece) if current_en_passant.include?(action_coordinate)

      update_last_captured_piece(action_coordinate)
      update_board(action_coordinate, piece)
    end

    def execute_en_passant(action_coordinate, piece)
      case piece.current_coordinate[1]
      when 4
        black_en_passant(action_coordinate)
      when 3
        white_en_passant(action_coordinate)
      else
        NoMatchingPatternError
      end
      update_board(action_coordinate, piece)
    end

    def white_en_passant(action_coordinate)
      @last_captured_piece = array[action_coordinate[1] + 1][action_coordinate[0]]
      array[action_coordinate[1] + 1][action_coordinate[0]] = ''
    end

    def black_en_passant(action_coordinate)
      @last_captured_piece = array[action_coordinate[1] - 1][action_coordinate[0]]
      array[action_coordinate[1] - 1][action_coordinate[0]] = ''
    end

    def execute_long_castle(color)
      case color
      when 'white'
        y_coordinate = 7
        long_castling(y_coordinate)
      when 'black'
        y_coordinate = 0
        long_castling(y_coordinate)
      else
        NoMatchingPatternError
      end
    end

    def long_castling(y_coordinate, rook = array[y_coordinate][0], king = array[y_coordinate][4])
      array[y_coordinate][0] = ''
      array[y_coordinate][4] = ''
      array[y_coordinate][3] = rook
      array[y_coordinate][2] = king
      king.update_current_coordinate([2, y_coordinate])
      rook.update_current_coordinate([4, y_coordinate])
    end

    def execute_short_castle(color)
      case color
      when 'white'
        y_coordinate = 7
        short_castling(y_coordinate)
      when 'black'
        y_coordinate = 0
        short_castling(y_coordinate)
      else
        NoMatchingPatternError
      end
    end

    def short_castling(y_coordinate, rook = array[y_coordinate][7], king = array[y_coordinate][4])
      array[y_coordinate][7] = ''
      array[y_coordinate][4] = ''
      array[y_coordinate][5] = rook
      array[y_coordinate][6] = king
      king.update_current_coordinate([6, y_coordinate])
      rook.update_current_coordinate([5, y_coordinate])
    end

    def update_board(action_coordinate, piece)
      current_coordinate = piece.current_coordinate
      array[current_coordinate[1]][current_coordinate[0]] = ''
      array[action_coordinate[1]][action_coordinate[0]] = piece
      # return unless piece.is_a?(Pawn) && piece.en_passant_captures.include?(action_coordinate)
      # update_en_passant_execution(action_coordinate, selection, piece)
    end

    def update_last_captured_piece(coordinate)
      @last_captured_piece = if array[coordinate[1]][coordinate[0]].is_a?(String)
                               nil
                             else
                               array[coordinate[1]][coordinate[0]]
                             end
    end

    def valid_action?(coordinate)
      current_movements.include?(coordinate) ||
        current_captures.include?(coordinate) ||
        current_en_passant.include?(coordinate)
    end

    def add_moves_and_captures(piece)
      @current_movements = piece.possible_movements
      @current_captures = piece.possible_captures
      @current_en_passant = piece.possible_en_passant if piece.is_a?(Pawn)
      add_moves unless current_movements.empty?
      add_captures unless current_captures.empty?
      add_en_passant unless current_en_passant.empty?
    end

    def remove_moves_and_captures
      remove_moves unless current_movements.empty?
      remove_captures unless current_captures.empty?
      @current_movements = []
      @current_captures = []
    end

    def remove_moves
      current_movements.each do |move|
        tile = array[move[1]][move[0]]
        next unless tile.is_a?(String)

        array[move[1]][move[0]] = ''
      end
    end

    def remove_captures
      current_captures.each do |capture|
        tile = array[capture[1]][capture[0]]
        next if tile.is_a?(String)

        tile.can_not_be_captured
      end
    end

    def add_moves(content = 'o')
      current_movements.each do |move|
        update_array(move, content)
      end
    end

    def add_captures
      current_captures.each do |capture|
        update_capturable_piece(capture)
      end
    end

    def add_en_passant(content = 'x')
      current_en_passant.each do |passant|
        update_array(passant, content)
      end
    end

    def update_array(coordinate, content)
      @array[coordinate[1]][coordinate[0]] = content
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
