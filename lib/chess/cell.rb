# frozen_string_literal: true

module Chess
  # Cell
  class Cell
    attr_reader :coordinate, :content

    def initialize(coordinate, content = nil)
      @coordinate = coordinate
      @content = content
    end
  end
end
