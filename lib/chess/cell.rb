# frozen_string_literal: true

module Chess
  # Cell
  class Cell
    attr_reader :coordinate, :content, :highlight

    def initialize(x_coordinate:, y_coordinate:, content: nil, highlight: false)
      @coordinate = [x_coordinate, y_coordinate]
      @content = content
      @highlight = highlight
    end

    def update_content(content)
      @content = content
      content.update_position(coordinate)
    end

    def create_pawn(color)
      @content = Pawn.new(color: color, current_position: coordinate)
    end

    def create_rook(color)
      @content = Rook.new(color: color, current_position: coordinate)
    end

    def create_knight(color)
      @content = Knight.new(color: color, current_position: coordinate)
    end

    def create_bishop(color)
      @content = Bishop.new(color: color, current_position: coordinate)
    end

    def create_queen(color)
      @content = Queen.new(color: color, current_position: coordinate)
    end

    def create_king(color)
      @content = King.new(color: color, current_position: coordinate)
    end
  end
end
