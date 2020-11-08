# frozen_string_literal: true

module Chess
  # Board
  class Board
    attr_reader :cells

    def initialize(cells = nil)
      @cells = cells
    end

    def create_board
      @cells = []
      (0..7).each do |y_coordinate|
        @cells << create_row(y_coordinate)
      end
    end

    def create_row(y_coordinate)
      row = []
      (0..7).each do |x_coordinate|
        row << Cell.new(x_coordinate, y_coordinate)
      end
      row
    end
  end
end
