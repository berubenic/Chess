# frozen_string_literal: true

require_relative './piece'

module Chess
  # Knight piece
  class Knight < Piece
    attr_reader :board

    def initialize(**opts)
      @board = opts[:board]
      super(opts)
    end

    DIRECTIONS = [
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2],
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1]
    ].freeze

    def default_color
      raise NotImplementedError
    end

    def default_content
      raise NotImplementedError
    end

    def default_y_coordinate
      raise NotImplementedError
    end

    def possible_movements(directions = DIRECTIONS, result = [])
      directions.each do |x_coordinate, y_coordinate|
        move = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << move if PieceHelper.valid_move?(move, board)
      end
      result
    end

    def possible_captures(directions = DIRECTIONS, result = [])
      directions.each do |x_coordinate, y_coordinate|
        capture = [current_coordinate[0] + x_coordinate, current_coordinate[1] + y_coordinate]
        result << capture if PieceHelper.valid_capture?(capture, board, color)
      end
      result
    end
  end

  # WhiteKnight piece
  class WhiteKnight < Knight
    def default_color
      'white'
    end

    def default_content
      "\u2657"
    end

    def default_y_coordinate
      7
    end
  end

  # BlackKnight piece
  class BlackKnight < Knight
    def default_color
      'black'
    end

    def default_content
      "\u265E"
    end

    def default_y_coordinate
      0
    end
  end
end
