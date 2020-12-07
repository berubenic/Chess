# frozen_string_literal: true

module Chess
  # creates white and black chess pieces
  class PieceFactory
    WHITE_PIECES = {
      pawn: WhitePawn,
      rook: WhiteRook,
      knight: WhiteKnight,
      bishop: WhiteBishop,
      king: WhiteKing,
      queen: WhiteQueen
    }.freeze

    BLACK_PIECES = {
      pawn: BlackPawn,
      rook: BlackRook,
      knight: BlackKnight,
      bishop: BlackBishop,
      king: BlackKing,
      queen: BlackQueen
    }.freeze

    def self.create_white_piece(piece, x_coordinate)
      (WHITE_PIECES[piece] || Piece).new(x_coordinate)
    end

    def self.create_black_piece(piece, x_coordinate)
      (BLACK_PIECES[piece] || Piece).new(x_coordinate)
    end
  end
end
