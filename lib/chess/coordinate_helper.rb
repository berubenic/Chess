# frozen_string_literal: true

module Chess
  module CoordinateHelper
    module_function

    def coordinates_between_king_and_checking_piece(king, piece, array)
      king_x = king.current_coordinate[0]
      king_y = king.current_coordinate[1]
      enemy_x = piece.current_coordinate[0]
      enemy_y = piece.current_coordinate[1]
      enemy_position(king_x, king_y, enemy_x, enemy_y, piece, array)
    end

    def enemy_position(king_x, king_y, enemy_x, enemy_y, piece, array)
      if bottom_right?(king_x, king_y, enemy_x, enemy_y)
        bottom_right(piece.current_coordinate, array)
      elsif bottom_left?(king_x, king_y, enemy_x, enemy_y)
        bottom_left(piece.current_coordinate, array)
      elsif top_right?(king_x, king_y, enemy_x, enemy_y)
        top_right(piece.current_coordinate, array)
      elsif top_left?(king_x, king_y, enemy_x, enemy_y)
        top_left(piece.current_coordinate, array)
      elsif horizontal?(king_x, king_y, enemy_x, enemy_y)
        horizontal(king_x, enemy_x, piece.current_coordinate, array)
      elsif vertical?(king_x, king_y, enemy_x, enemy_y)
        vertical(king_y, enemy_y, piece.current_coordinate, array)
      end
    end

    def bottom_right?(king_x, king_y, enemy_x, enemy_y)
      king_x > enemy_x && king_y > enemy_y
    end

    def bottom_left?(king_x, king_y, enemy_x, enemy_y)
      king_x < enemy_x && king_y > enemy_y
    end

    def top_right?(king_x, king_y, enemy_x, enemy_y)
      king_x > enemy_x && king_y < enemy_y
    end

    def top_left?(king_x, king_y, enemy_x, enemy_y)
      king_x < enemy_x && king_y < enemy_y
    end

    def horizontal?(_king_x, king_y, _enemy_x, enemy_y)
      king_y == enemy_y
    end

    def vertical?(king_x, _king_y, enemy_x, _enemy_y)
      king_x == enemy_x
    end

    def bottom_right(current_coordinate, array, result = [])
      shift = [1, 1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      bottom_right(current_coordinate, array, result)
    end

    def bottom_left(current_coordinate, array, result = [])
      shift = [-1, 1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      bottom_left(current_coordinate, array, result)
    end

    def top_right(current_coordinate, array, result = [])
      shift = [1, -1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      top_right(current_coordinate, array, result)
    end

    def top_left(current_coordinate, array, result = [])
      shift = [-1, -1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      top_left(current_coordinate, array, result)
    end

    def horizontal(king_x, enemy_x, coordinate, array)
      return left_horizontal(coordinate, array) if king_x < enemy_x

      right_horizontal(coordinate, array) if king_x > enemy_x
    end

    def left_horizontal(current_coordinate, array, result = [])
      shift = [-1, 0]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      left_horizontal(current_coordinate, array, result)
    end

    def right_horizontal(current_coordinate, array, result = [])
      shift = [1, 0]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      right_horizontal(current_coordinate, array, result)
    end

    def vertical(king_y, enemy_y, coordinate, array)
      return top_vertical(coordinate, array) if king_y < enemy_y

      bottom_vertical(coordinate, array) if king_y > enemy_y
    end

    def top_vertical(current_coordinate, array, result = [])
      shift = [0, -1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      top_vertical(current_coordinate, array, result)
    end

    def bottom_vertical(current_coordinate, array, result = [])
      shift = [0, 1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless array[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      bottom_vertical(current_coordinate, array, result)
    end
  end
end
