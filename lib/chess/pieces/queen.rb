# frozen_string_literal: true

module Chess
  # Queen piece
  class Queen
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
  # WhiteQueen piece
  class WhiteQueen < Queen
    def default_color
      'white'
    end

    def default_content
      "\u2655"
    end

    def default_y_coordinate
      7
    end
  end
  # BlackQueen piece
  class BlackQueen < Queen
    def default_color
      'black'
    end

    def default_content
      "\u265B"
    end

    def default_y_coordinate
      0
    end
  end
end
