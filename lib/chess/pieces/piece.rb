# frozen_string_literal: true

module Chess
  # Piece Superclass
  class Piece
    def initialize(content:, x_coordinate:, y_coordinate:, color:)
      @content = content
      @coordinate = [x_coordinate, y_coordinate]
      @color = color
    end
  end
end
