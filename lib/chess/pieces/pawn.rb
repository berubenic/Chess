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
  end
  # WhitePawn piece
  class WhitePawn < Pawn
    def default_color
      'white'
    end

    def default_content
      "\u2659"
    end

    def default_y_coordinate
      6
    end
  end
  # BlackPawn piece
  class BlackPawn < Pawn
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
