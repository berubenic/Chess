# frozen_string_literal: true

require_relative './piece'

module Chess
  # Pawn piece
  class Pawn < Piece
    def default_color
      raise NotImplementedError
    end

    def default_content
      raise NotImplementedError
    end

    def default_y_coordinate
      raise NotImplementedError
    end

    def first_possible_move(direction, result = [])
      move = [current_coordinate[0], current_coordinate[1] + direction[0]]
      result << move
      return result if current_coordinate == starting_coordinate

      second_possible_move(direction, result)
    end

    def second_possible_move(direction, result)
      additional_move = [current_coordinate[0], current_coordinate[1] + direction[1]]
      result << additional_move
      result
    end
  end
  # WhitePawn piece
  class WhitePawn < Pawn
    WHITE_MOVES = [
      -1,
      -2
    ].freeze

    WHITE_CAPTURES = [
      [1, -1],
      [-1, -1]
    ].freeze

    def default_color
      'white'
    end

    def default_content
      "\u2659"
    end

    def default_y_coordinate
      6
    end

    def possible_movements
      first_possible_move(WHITE_MOVES)
    end
  end
  # BlackPawn piece
  class BlackPawn < Pawn
    BLACK_MOVES = [
      1,
      2
    ].freeze

    BLACK_CAPTURES = [
      [1, 1],
      [-1, 1]
    ].freeze

    def default_color
      'black'
    end

    def default_content
      "\u265F"
    end

    def default_y_coordinate
      1
    end
  end
end
