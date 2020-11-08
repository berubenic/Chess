# frozen_string_literal: true

module Chess
  # Cell
  class Cell
    attr_reader :coordinate, :content

    def initialize(x, y, content = nil)
      @coordinate = [x, y]
      @content = content
    end

    def create_pawn(color)
      @content = Pawn.new(color, coordinate)
    end

    def create_rook(color)
      @content = Rook.new(color, coordinate)
    end

    def create_knight(color)
      @content = Knight.new(color, coordinate)
    end

    def create_bishop(color)
      @content = Bishop.new(color, coordinate)
    end

    def create_queen(color)
      @content = Queen.new(color, coordinate)
    end

    def create_king(color)
      @content = King.new(color, coordinate)
    end
  end
end
