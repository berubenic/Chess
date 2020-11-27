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
      piece.unhightlight_selected
    end

    def add_moves(moves)
      moves.each do |move|
        board[move[1]][move[0]] = 'o'
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
      board[7][0] = Rook.new(color: 'white', x_coordinate: 0, y_coordinate: 7, content: WHITE_ROOK, board: board)
      board[7][7] = Rook.new(color: 'white', x_coordinate: 7, y_coordinate: 7, content: WHITE_ROOK, board: board)
    end

    def setup_white_knights
      board[7][1] = Knight.new(color: 'white', x_coordinate: 1, y_coordinate: 7, content: WHITE_KNIGHT, board: board)
      board[7][6] = Knight.new(color: 'white', x_coordinate: 6, y_coordinate: 7, content: WHITE_KNIGHT, board: board)
    end

    def setup_white_bishops
      board[7][2] = Bishop.new(color: 'white', x_coordinate: 2, y_coordinate: 7, content: WHITE_BISHOP, board: board)
      board[7][5] = Bishop.new(color: 'white', x_coordinate: 5, y_coordinate: 7, content: WHITE_BISHOP, board: board)
    end

    def setup_white_queen
      board[7][3] = Queen.new(color: 'white', x_coordinate: 2, y_coordinate: 7, content: WHITE_QUEEN, board: board)
    end

    def setup_white_king
      board[7][4] = King.new(color: 'white', x_coordinate: 2, y_coordinate: 7, content: WHITE_KING, board: board)
    end

    def setup_white_pawns
      board[6].each_with_index do |_tile, index|
        board[6][index] = Pawn.new(color: 'white', x_coordinate: index, y_coordinate: 6, content: WHITE_PAWN, board: board)
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
      board[0][0] = Rook.new(color: 'black', x_coordinate: 0, y_coordinate: 0, content: BLACK_ROOK, board: board)
      board[0][7] = Rook.new(color: 'black', x_coordinate: 7, y_coordinate: 0, content: BLACK_ROOK, board: board)
    end

    def setup_black_knights
      board[0][1] = Knight.new(color: 'black', x_coordinate: 1, y_coordinate: 0, content: BLACK_KNIGHT, board: board)
      board[0][6] = Knight.new(color: 'black', x_coordinate: 6, y_coordinate: 0, content: BLACK_KNIGHT, board: board)
    end

    def setup_black_bishops
      board[0][2] = Bishop.new(color: 'black', x_coordinate: 2, y_coordinate: 0, content: BLACK_BISHOP, board: board)
      board[0][5] = Bishop.new(color: 'black', x_coordinate: 5, y_coordinate: 0, content: BLACK_BISHOP, board: board)
    end

    def setup_black_queen
      board[0][3] = Queen.new(color: 'black', x_coordinate: 2, y_coordinate: 0, content: BLACK_QUEEN, board: board)
    end

    def setup_black_king
      board[0][4] = King.new(color: 'black', x_coordinate: 2, y_coordinate: 0, content: BLACK_KING, board: board)
    end

    def setup_black_pawns
      board[1].each_with_index do |_tile, index|
        board[1][index] = Pawn.new(color: 'black', x_coordinate: index, y_coordinate: 1, content: BLACK_PAWN, board: board)
      end
    end
  end
end
