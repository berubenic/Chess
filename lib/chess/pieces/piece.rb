# frozen_string_literal: true

module Chess
  # Piece Superclass
  class Piece
    attr_reader :coordinate, :board, :color, :content, :starting_coordinate
    attr_reader :movements, :captures, :selected, :moved, :capturable
    def initialize(**args)
      @content = args[:content]
      @coordinate = [args[:x_coordinate], args[:y_coordinate]]
      @board = args[:board]
      @color = args[:color]
      @starting_coordinate = [args[:x_coordinate], args[:y_coordinate]]
      @movements = []
      @captures = []
      @moved = false
      @capturable = false
    end

    def possible_movements
      raise 'Called abstract method: possible_movements'
    end

    def possible_captures
      raise 'Called abstract method: possible_captures'
    end

    def reset_movements
      @movements = []
    end

    def reset_captures
      @captures = []
    end

    def update_coordinate(coordinate)
      @coordinate = coordinate
    end

    def can_be_captured
      @capturable = true
    end

    def remove_can_be_captured
      @capturable = false
    end

    def moved_from_starting_square
      @moved = true
    end

    def has_not_moved_from_starting_square
      @moved = false
    end

    def to_s
      if selected == false
        content
      elsif selected == true
        content.green
      end
    end

    private

    def valid_move?(move)
      within_board?(move) && not_occupied?(move)
    end

    def within_board?(move)
      move.all? { |coordinate| coordinate.between? 0, 7 }
    end

    def not_occupied?(move)
      return false unless within_board?(coordinate)

      board_tile = board.board[move[1]][move[0]]
      board_tile.is_a?(String)
    end

    def valid_capture?(coordinate)
      within_board?(coordinate) && !not_occupied?(coordinate) && !friendly_occupied?(coordinate)
    end

    def friendly_occupied?(coordinate)
      return false unless within_board?(coordinate)

      piece = board.board[coordinate[1]][coordinate[0]]
      return false if piece.is_a?(String)

      piece.color == color
    end
  end
end
