# frozen_string_literal: true

module Chess
  # Piece Superclass
  class Piece
    attr_reader :coordinate, :board, :color, :moved
    attr_accessor :movements, :captures
    def initialize(content: nil, x_coordinate: nil, y_coordinate: nil, color: nil, board: nil)
      @content = content
      @coordinate = [x_coordinate, y_coordinate]
      @board = board
      @color = color
      @moved = false
      @movements = []
      @captures = []
    end

    def possible_movements
      raise 'Called abstract method: possible_movements'
    end

    def possible_captures
      raise 'Called abstract method: possible_captures'
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
