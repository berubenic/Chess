# frozen_string_literal: true

module Chess
  # finds coordinates between checking piece and king
  module CoordinateHelper
    module_function

    BOTTOM_RIGHT = [1, 1].freeze
    BOTTOM_LEFT = [-1, 1].freeze
    TOP_RIGHT = [1, -1].freeze
    TOP_LEFT = [-1, -1].freeze
    LEFT_HORIZONTAL = [-1, 0].freeze
    RIGHT_HORIZONTAL = [1, 0].freeze
    TOP_VERTICAL = [0, -1].freeze
    BOTTOM_VERTICAL = [0, 1].freeze

    def coordinates_between_king_and_checking_piece(king, piece, array)
      @array = array
      king_x = king.current_coordinate[0]
      king_y = king.current_coordinate[1]
      enemy_x = piece.current_coordinate[0]
      enemy_y = piece.current_coordinate[1]
      enemy_position(king_x, king_y, enemy_x, enemy_y, piece)
    end

    def enemy_position(king_x, king_y, enemy_x, enemy_y, piece)
      if bottom?(king_y, enemy_y)
        find_bottom_coordinates(piece, king_x, enemy_x)
      elsif top?(king_y, enemy_y)
        find_top_coordinates(piece, king_x, enemy_x)
      elsif horizontal?(king_x, king_y, enemy_x, enemy_y)
        find_horizontal_coordinates(piece, king_x, enemy_x)
      elsif vertical?(king_x, king_y, enemy_x, enemy_y)
        find_vertical_coordinates(piece, king_y, enemy_y)
      end
    end

    def find_bottom_coordinates(piece, king_x, enemy_x)
      find_coordinates(piece.current_coordinate, BOTTOM_RIGHT) if right?(king_x, enemy_x)
      find_coordinates(piece.current_coordinate, BOTTOM_LEFT) if left?(king_x, enemy_x)
    end

    def find_top_coordinates(piece, king_x, enemy_x)
      find_coordinates(piece.current_coordinate, TOP_RIGHT) if right?(king_x, enemy_x)
      find_coordinates(piece.current_coordinate, TOP_LEFT) if left?(king_x, enemy_x)
    end

    def find_horizontal_coordinates(piece, king_x, enemy_x)
      find_coordinates(piece.current_coordinate, RIGHT_HORIZONTAL) if right?(king_x, enemy_x)
      find_coordinates(piece.current_coordinate, LEFT_HORIZONTAL) if left?(king_x, enemy_x)
    end

    def find_vertical_coordinates(piece, king_y, enemy_y)
      find_coordinates(piece.current_coordinate, TOP_VERTICAL) if top?(king_y, enemy_y)
      find_coordinates(piece.current_coordinate, BOTTOM_VERTICAL) if bottom?(king_y, enemy_y)
    end

    def left?(king_x, enemy_x)
      king_x < enemy_x
    end

    def right?(king_x, enemy_x)
      king_x > enemy_x
    end

    def top?(king_y, enemy_y)
      king_y < enemy_y
    end

    def bottom?(king_y, enemy_y)
      king_y > enemy_y
    end

    def horizontal?(_king_x, king_y, _enemy_x, enemy_y)
      king_y == enemy_y
    end

    def vertical?(king_x, _king_y, enemy_x, _enemy_y)
      king_x == enemy_x
    end

    def find_coordinates(current_coordinate, shift, result = [])
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless @array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      find_coordinates(current_coordinate, shift, result)
    end
  end
end
