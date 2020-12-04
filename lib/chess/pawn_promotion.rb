# frozen_string_literal: true

require 'tty-prompt'

module Chess
  # promotes pawn
  module PawnPromotion
    WHITE_ROOK = "\u2656".white
    WHITE_KNIGHT = "\u2658".white
    WHITE_BISHOP = "\u2657".white
    WHITE_QUEEN = "\u2655".white
    BLACK_ROOK = "\u265C".black
    BLACK_KNIGHT = "\u265E".black
    BLACK_BISHOP = "\u265D".black
    BLACK_QUEEN = "\u265B".black

    def white_pawn_promotion(pawn = nil)
      return unless board[0].any? { |tile| tile.is_a?(Pawn) }

      board[0].each { |tile| pawn = tile if tile.is_a?(Pawn) }
      promote_pawn(pawn)
    end

    def black_pawn_promotion(pawn = nil)
      return unless board[7].any? { |tile| tile.is_a?(Pawn) }

      board[7].each { |tile| pawn = tile if tile.is_a?(Pawn) }
      promote_pawn(pawn)
    end

    def promote_pawn(pawn)
      new_piece = ask_for_promotion
      case new_piece
      when 1
        promote_to_queen(pawn)
      when 2
        promote_to_rook(pawn)
      when 3
        promote_to_knight(pawn)
      when 4
        promote_to_bishop(pawn)
      end
    end

    def promote_to_queen(pawn)
      board[pawn.coordinate[1]][pawn.coordinate[0]] = Queen.new(color: pawn.color, x_coordinate: pawn.coordinate[0], y_coordinate: pawn.coordinate[1], content: queen_content(pawn), board: self)
    end

    def queen_content(pawn)
      if pawn.color == 'white'
        WHITE_QUEEN
      elsif pawn.color == 'black'
        BLACK_QUEEN
      end
    end

    def promote_to_rook(pawn)
      board[pawn.coordinate[1]][pawn.coordinate[0]] = Rook.new(color: pawn.color, x_coordinate: pawn.coordinate[0], y_coordinate: pawn.coordinate[1], content: rook_content(pawn), board: self)
    end

    def rook_content(pawn)
      if pawn.color == 'white'
        WHITE_ROOK
      elsif pawn.color == 'black'
        BLACK_ROOK
      end
    end

    def promote_to_knight(pawn)
      board[pawn.coordinate[1]][pawn.coordinate[0]] = Knight.new(color: pawn.color, x_coordinate: pawn.coordinate[0], y_coordinate: pawn.coordinate[1], content: knight_content(pawn), board: self)
    end

    def knight_content(pawn)
      if pawn.color == 'white'
        WHITE_KNIGHT
      elsif pawn.color == 'black'
        BLACK_KNIGHT
      end
    end

    def promote_to_bishop(pawn)
      board[pawn.coordinate[1]][pawn.coordinate[0]] = Bishop.new(color: pawn.color, x_coordinate: pawn.coordinate[0], y_coordinate: pawn.coordinate[1], content: bishop_content(pawn), board: self)
    end

    def bishop_content(pawn)
      if pawn.color == 'white'
        WHITE_BISHOP
      elsif pawn.color == 'black'
        BLACK_BISHOP
      end
    end

    def ask_for_promotion
      prompt = TTY::Prompt.new
      choices = { Queen: 1, Rook: 2, Knight: 3, Bishop: 4 }
      prompt.select('Select the piece that will replace your pawn.', choices)
    end
  end
end
