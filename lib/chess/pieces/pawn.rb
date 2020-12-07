# frozen_string_literal: true

module Chess
  # Pawn piece
  class Pawn
    def initialize(**opts)
      @coordinate = [opts[:x_coordinate], opts[:y_coordinate] || default_y_coordinate]
      @color = opts[:color] || default_color
      @content = opts[:content] || default_content
    end

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
