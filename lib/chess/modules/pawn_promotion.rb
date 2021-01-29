# frozen_string_literal: true

require 'tty-prompt'

module Chess
  # promotes pawn
  module PawnPromotion
    module_function

    def white_pawn_promotion(board, pawn = nil)
      array = board.array
      return unless array[0].any? { |tile| tile.is_a?(Pawn) }

      array[0].each { |tile| pawn = tile if tile.is_a?(Pawn) }
      promote_pawn(pawn, board)
    end

    def black_pawn_promotion(board, pawn = nil)
      array = board.array
      return unless array[7].any? { |tile| tile.is_a?(Pawn) }

      array[7].each { |tile| pawn = tile if tile.is_a?(Pawn) }
      promote_pawn(pawn, board)
    end

    def promote_pawn(pawn, board)
      new_piece = ask_for_promotion
      case new_piece
      when 1
        promote_to_queen(pawn, board)
      when 2
        promote_to_rook(pawn, board)
      when 3
        promote_to_knight(pawn, board)
      when 4
        promote_to_bishop(pawn, board)
      else
        NoMatchingPatternError
      end
    end

    def promote_to_queen(pawn, board, array = board.array)
      coordinate = pawn.current_coordinate
      case pawn.color
      when 'white'
        array[coordinate[1]][coordinate[0]] =
          WhiteQueen.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      when 'black'
        array[coordinate[1]][coordinate[0]] =
          BlackQueen.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      else
        NoMatchingPatternError
      end
    end

    def promote_to_rook(pawn, board, array = board.array)
      coordinate = pawn.current_coordinate
      case pawn.color
      when 'white'
        array[coordinate[1]][coordinate[0]] =
          WhiteRook.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      when 'black'
        array[coordinate[1]][coordinate[0]] =
          BlackRook.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      else
        NoMatchingPatternError
      end
    end

    def promote_to_knight(pawn, board, array = board.array)
      coordinate = pawn.current_coordinate
      case pawn.color
      when 'white'
        array[coordinate[1]][coordinate[0]] =
          WhiteKnight.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      when 'black'
        array[coordinate[1]][coordinate[0]] =
          BlackKnight.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      else
        NoMatchingPatternError
      end
    end

    def promote_to_bishop(pawn, board, array = board.array)
      coordinate = pawn.current_coordinate
      case pawn.color
      when 'white'
        array[coordinate[1]][coordinate[0]] =
          WhiteBishop.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      when 'black'
        array[coordinate[1]][coordinate[0]] =
          BlackBishop.new(x_coordinate: coordinate[0], y_coordinate: coordinate[1], board: board)
      else
        NoMatchingPatternError
      end
    end

    def ask_for_promotion
      prompt = TTY::Prompt.new
      choices = { Queen: 1, Rook: 2, Knight: 3, Bishop: 4 }
      prompt.select('Select the piece that will replace your pawn.', choices)
    end
  end
end
