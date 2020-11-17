# frozen_string_literal: true

module Chess
  # Piece Superclass
  class Piece
    attr_reader :movements, :coordinate
    def initialize(content: nil, x_coordinate: nil, y_coordinate: nil, color: nil, board: nil)
      @content = content
      @coordinate = [x_coordinate, y_coordinate]
      @board = nil
      @color = color
      @movements = nil
      @captures = nil
    end

    def possible_movements
      raise 'Called abstract method: possible_movements'
    end

    def possible_captures
      raise 'Called abstract method: possible_captures'
    end
  end
end
