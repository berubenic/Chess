# frozen_string_literal: true

require 'pry'

module Chess
  # Board
  class Board
    WHITE_PAWN = "\u2659".white
    WHITE_ROOK = "\u2656".white
    WHITE_KNIGHT = "\u2658".white
    WHITE_BISHOP = "\u2657".white
    WHITE_QUEEN = "\u2655".white
    WHITE_KING = "\u2654".white
    BLACK_PAWN = "\u265F".black
    BLACK_ROOK = "\u265C".black
    BLACK_KNIGHT = "\u265E".black
    BLACK_BISHOP = "\u265D".black
    BLACK_QUEEN = "\u265B".black
    BLACK_KING = "\u265A".black

    attr_accessor :board
    def initialize
      @board = Array.new(8) { Array.new(8, '') }
    end

    def setup_board
      setup_white_pieces
      setup_black_pieces
    end

    def highlight_selection(selection)
      piece = find_tile(selection)
      piece.highlight_selected
    end

    def revert_highlight(selection)
      piece = find_tile(selection)
      piece.unhighlight_selected
    end

    def execute_move(action, selection)
      piece = find_tile(selection)
      piece.update_coordinate(action)
      piece.moved_from_starting_square
      verify_pawn_moved_two_squares(piece, action, selection)
      update_board(action, selection, piece)
    end

    def verify_pawn_moved_two_squares(piece, action, selection)
      return unless piece.is_a?(Pawn)

      if (selection[1] - action[1]) == 2 || (selection[1] - action[1]) == -2
        piece.moved_two_squares
      else
        piece.did_not_move_two_squares
      end
    end

    def update_board(action, selection, piece)
      board[selection[1]][selection[0]] = ''
      board[action[1]][action[0]] = piece
    end

    def add_moves(moves)
      moves.each do |move|
        board[move[1]][move[0]] = 'o'.white
      end
    end

    def add_captures(captures)
      captures.each do |capture|
        piece = board[capture[1]][capture[0]]
        piece.can_be_captured
      end
    end

    def add_en_passant(captures)
      captures.each do |capture|
        board[capture[1]][capture[0]] = 'x'.red
      end
    end

    def revert_move(action, selection)
      piece = board[action[1]][action[0]]
      board[selection[1]][selection[0]] = piece
      board[action[1]][action[0]] = ''
      piece.update_coordinate(selection)
      piece.has_not_moved_from_starting_square if piece.starting_coordinate == selection
    end

    def remove_moves(moves, action)
      moves.each do |move|
        next if move == action

        board[move[1]][move[0]] = ''
      end
    end

    def remove_captures(captures, action)
      captures.each do |capture|
        next if capture == action

        piece = board[capture[1]][capture[0]]
        piece.remove_can_be_captured
      end
    end

    def remove_en_passant_capture(action, selection)
      if selection[1] == 4
        board[action[1] - 1][action[0]] = ''
      elsif selection[1] == 3
        board[action[1] + 1][action[0]] = ''
      end
    end

    def find_tile(coordinate)
      board[coordinate[1]][coordinate[0]]
    end

    private

    def setup_white_pieces
      setup_white_rooks
      setup_white_knights
      setup_white_bishops
      setup_white_queen
      setup_white_king
      setup_white_pawns
    end

    def setup_white_rooks
      board[7][0] = Rook.new(color: 'white', x_coordinate: 0, y_coordinate: 7, content: WHITE_ROOK, board: self)
      board[7][7] = Rook.new(color: 'white', x_coordinate: 7, y_coordinate: 7, content: WHITE_ROOK, board: self)
    end

    def setup_white_knights
      board[7][1] = Knight.new(color: 'white', x_coordinate: 1, y_coordinate: 7, content: WHITE_KNIGHT, board: self)
      board[7][6] = Knight.new(color: 'white', x_coordinate: 6, y_coordinate: 7, content: WHITE_KNIGHT, board: self)
    end

    def setup_white_bishops
      board[7][2] = Bishop.new(color: 'white', x_coordinate: 2, y_coordinate: 7, content: WHITE_BISHOP, board: self)
      board[7][5] = Bishop.new(color: 'white', x_coordinate: 5, y_coordinate: 7, content: WHITE_BISHOP, board: self)
    end

    def setup_white_queen
      board[7][3] = Queen.new(color: 'white', x_coordinate: 3, y_coordinate: 7, content: WHITE_QUEEN, board: self)
    end

    def setup_white_king
      board[7][4] = King.new(color: 'white', x_coordinate: 4, y_coordinate: 7, content: WHITE_KING, board: self)
    end

    def setup_white_pawns
      board[6].each_with_index do |_tile, index|
        board[6][index] = Pawn.new(color: 'white', x_coordinate: index, y_coordinate: 6, content: WHITE_PAWN, board: self)
      end
    end

    def setup_black_pieces
      setup_black_rooks
      setup_black_knights
      setup_black_bishops
      setup_black_queen
      setup_black_king
      setup_black_pawns
    end

    def setup_black_rooks
      board[0][0] = Rook.new(color: 'black', x_coordinate: 0, y_coordinate: 0, content: BLACK_ROOK, board: self)
      board[0][7] = Rook.new(color: 'black', x_coordinate: 7, y_coordinate: 0, content: BLACK_ROOK, board: self)
    end

    def setup_black_knights
      board[0][1] = Knight.new(color: 'black', x_coordinate: 1, y_coordinate: 0, content: BLACK_KNIGHT, board: self)
      board[0][6] = Knight.new(color: 'black', x_coordinate: 6, y_coordinate: 0, content: BLACK_KNIGHT, board: self)
    end

    def setup_black_bishops
      board[0][2] = Bishop.new(color: 'black', x_coordinate: 2, y_coordinate: 0, content: BLACK_BISHOP, board: self)
      board[0][5] = Bishop.new(color: 'black', x_coordinate: 5, y_coordinate: 0, content: BLACK_BISHOP, board: self)
    end

    def setup_black_queen
      board[0][3] = Queen.new(color: 'black', x_coordinate: 3, y_coordinate: 0, content: BLACK_QUEEN, board: self)
    end

    def setup_black_king
      board[0][4] = King.new(color: 'black', x_coordinate: 4, y_coordinate: 0, content: BLACK_KING, board: self)
    end

    def setup_black_pawns
      board[1].each_with_index do |_tile, index|
        board[1][index] = Pawn.new(color: 'black', x_coordinate: index, y_coordinate: 1, content: BLACK_PAWN, board: self)
      end
    end
  end
end
