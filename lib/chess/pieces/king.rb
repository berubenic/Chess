# frozen_string_literal: true

require_relative './piece'

module Chess
  # King piece
  class King < Piece
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
  # WhiteKing piece
  class WhiteKing < King
    def default_color
      'white'
    end

    def default_content
      "\u2654"
    end

    def default_y_coordinate
      7
    end
  end
  # BlackKing piece
  class BlackKing < King
    def default_color
      'black'
    end

    def default_content
      "\u265A"
    end

    def default_y_coordinate
      0
    end
  end
end
