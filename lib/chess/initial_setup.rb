# frozen_string_literal: true

module Chess
  # Sets pieces for a normal game of chess
  module InitialSetup
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