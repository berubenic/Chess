# frozen_string_literal: true

module Chess
  # Cell
  class Cell
    attr_reader :coordinate, :content, :highlight, :color

    def initialize(x_coordinate:, y_coordinate:, content: nil, highlight: false, color: nil)
      @coordinate = [x_coordinate, y_coordinate]
      @content = content
      @highlight = highlight
      @color = color
    end

    def update_content(content)
      @content = content
    end

    def remove_content
      @content = nil
    end

    def update_position(content)
      content.update_position(coordinate)
    end

    def toggle_highlight
      return @highlight = true if highlight == false

      @highlight = false if highlight == true
    end

    def create_pawn(color)
      symbol = color == 'white' ? "\u2659" : "\u265F"
      @content = Pawn.new(color: color, current_position: coordinate, symbol: symbol)
    end

    def create_rook(color)
      symbol = color == 'white' ? "\u2656" : "\u265C"
      @content = Rook.new(color: color, current_position: coordinate, symbol: symbol)
    end

    def create_knight(color)
      symbol = color == 'white' ? "\u2658" : "\u265E"
      @content = Knight.new(color: color, current_position: coordinate, symbol: symbol)
    end

    def create_bishop(color)
      symbol = color == 'white' ? "\u2657" : "\u265D"
      @content = Bishop.new(color: color, current_position: coordinate, symbol: symbol)
    end

    def create_queen(color)
      symbol = color == 'white' ? "\u2655" : "\u265B"
      @content = Queen.new(color: color, current_position: coordinate, symbol: symbol)
    end

    def create_king(color)
      symbol = color == 'white' ? "\u2654" : "\u265A"
      @content = King.new(color: color, current_position: coordinate, symbol: symbol)
    end

    def color_tile(primary)
      @color = 'primary' if primary
      @color = 'secondary' unless primary
    end

    def to_s
      if color == 'primary'
        " #{print_content} ".bg_primary
      elsif color == 'secondary'
        " #{print_content} ".bg_secondary
      end
    end

    def print_content
      if content.nil?
        ' '
      else
        content
      end
    end
  end
end
