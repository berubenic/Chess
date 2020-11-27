# frozen_string_literal: true

module Chess
  # Piece Superclass
  class Piece
    attr_reader :coordinate, :board, :color, :content
    attr_reader :movements, :captures, :selected
    def initialize(**args)
      @content = args[:content]
      @coordinate = [args[:x_coordinate], args[:y_coordinate]]
      @board = args[:board]
      @color = args[:color]
      @movements = []
      @captures = []
      @selected = false
    end

    def possible_movements
      raise 'Called abstract method: possible_movements'
    end

    def possible_captures
      raise 'Called abstract method: possible_captures'
    end

    def highlight_selected
      @selected = true
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
      board_tile = board[move[1]][move[0]]
      board_tile == ''
    end

    def valid_capture?(capture)
      within_board?(capture) && !not_occupied?(capture) && !friendly_occupied?(capture)
    end

    def friendly_occupied?(capture)
      piece = board[capture[1]][capture[0]]
      piece.color == color
    end
  end
end
