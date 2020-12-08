# frozen_string_literal: true

module Chess
  # Piece superclass
  class Piece
    attr_reader :current_coordinate, :starting_coordinate, :color, :content

    def initialize(**opts)
      @current_coordinate = [opts[:x_coordinate], opts[:y_coordinate] || default_y_coordinate]
      @starting_coordinate = current_coordinate
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
end
