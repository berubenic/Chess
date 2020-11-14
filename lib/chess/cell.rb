# frozen_string_literal: true

module Chess
  # Cell
  class Cell
    attr_reader :coordinate, :content, :highlight

    def initialize(x_coordinate:, y_coordinate:, content: nil, highlight: false, color: nil)
      @coordinate = [x_coordinate, y_coordinate]
      @content = content
      @highlight = highlight
      @color = color
    end

    def update_content(content)
      @content = content
      content.update_position(coordinate)
    end

    def toggle_highlight
      return @highlight = true if highlight == false

      @highlight = false if highlight == true
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

    def color_tile(primary)
      @color = 'primary' if primary
      @color = 'secondary' unless primary
    end

    def to_s
      if color == 'primary'
        content.bg_primary
      elsif color == 'secondary'
        content.bg_secondary
      end
    end
  end
end
