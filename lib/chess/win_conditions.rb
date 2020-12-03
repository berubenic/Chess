require 'pry'

module Chess
  module WinConditions
    def can_kill_future_checking_piece?(king)
      king.movements.each do |move|
        @futur_checking_pieces = find_pieces_that_could_check(king, move)
      end
      futur_checking_pieces.all? { |piece| can_kill_checking_piece?(king, piece) }
    end

    def find_pieces_that_could_check(king, move, result = [])
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String) || tile == king || tile.color == king.color

          if tile.is_a?(Pawn)
            result << tile if pawn_can_attack?(move, tile)

            next
          end
          tile.possible_movements
          next if tile.movements.nil?

          result << tile if tile.movements.include?(move)
        end
      end
      result = result.uniq
    end

    def friendly_can_block_future_checking_piece?(king)
      return true if futur_checking_pieces.empty?

      futur_checking_pieces.all? { |piece| friendly_can_block?(king, piece) }
    end

    # both

    def can_kill_checking_piece?(king, piece)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String) || tile.color != king.color

          tile.possible_captures
          next if tile.captures.nil?

          return true if tile.captures.include?(piece.coordinate)
        end
      end
      false
    end

    def king_can_avoid_attack?(king)
      king.possible_movements
      return false if king.movements.nil? || king.movements.empty?

      return true if king.movements.any? { |move| can_not_be_attacked?(move, king) }

      false
    end

    # mate

    def can_not_be_attacked?(move, king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String) || tile == king || tile.color == king.color

          if tile.is_a?(Pawn)
            return false if pawn_can_attack?(move, tile)

            next
          end
          tile.possible_movements
          next if tile.movements.nil?
          return false if tile.movements.include?(move)
        end
      end
      true
    end

    def pawn_can_attack?(move, pawn)
      if pawn.color == 'black'
        black_pawn_can_attack?(move, pawn)
      elsif pawn.color == 'white'
        white_pawn_can_attack?(move, pawn)
      end
    end

    def black_pawn_can_attack?(move, pawn)
      left_attack = [pawn.coordinate[0] - 1, pawn.coordinate[1] + 1]
      right_attack = [pawn.coordinate[0] + 1, pawn.coordinate[1] + 1]
      return true if left_attack == move || right_attack == move

      false
    end

    def white_pawn_can_attack?(move, pawn)
      left_attack = [pawn.coordinate[0] - 1, pawn.coordinate[1] - 1]
      right_attack = [pawn.coordinate[0] + 1, pawn.coordinate[1] - 1]
      return true if left_attack == move || right_attack == move

      false
    end

    def friendly_can_block?(king, piece)
      return false unless piece.is_a?(Queen) || piece.is_a?(Rook) || piece.is_a?(Bishop)

      blocking_coordinates = coordinates_between_king_and_checking_piece(king, piece)

      blocking_coordinates.any? { |coordinate| friendly_can_move_to_blocking_coordinate?(king, coordinate) }
    end

    def friendly_can_move_to_blocking_coordinate?(king, coordinate)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String) || tile == king || tile.color != king.color

          tile.possible_movements
          next if tile.movements.nil?
          return true if tile.movements.include?(coordinate)
        end
      end
      false
    end

    def coordinates_between_king_and_checking_piece(king, piece)
      binding.pry
      king_x = king.coordinate[0]
      king_y = king.coordinate[1]
      enemy_x = piece.coordinate[0]
      enemy_y = piece.coordinate[1]
      enemy_position(king_x, king_y, enemy_x, enemy_y)
    end

    def enemy_position(king_x, king_y, enemy_x, enemy_y)
      if bottom_right?(king_x, king_y, enemy_x, enemy_y)
        bottom_right
      elsif bottom_left?(king_x, king_y, enemy_x, enemy_y)
        bottom_left
      elsif top_right?(king_x, king_y, enemy_x, enemy_y)
        top_right
      elsif top_left?(king_x, king_y, enemy_x, enemy_y)
        top_left
      elsif horizontal?(king_x, king_y, enemy_x, enemy_y)
        horizontal(king_x, king_y, enemy_x, enemy_y)
      elsif vertical?(king_x, king_y, enemy_x, enemy_y)
        vertical(king_x, king_y, enemy_x, enemy_y)
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

    def horizontal?(king_x, _king_y, enemy_x, _enemy_y)
      king_x == enemy_x
    end

    def vertical?(_king_x, king_y, _enemy_x, enemy_y)
      king_y == enemy_y
    end

    def bottom_right(result = [], current_coordinate = checking_piece.coordinate)
      shift = [1, 1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless board.board[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      bottom_right(result, current_coordinate)
    end

    def bottom_left(result = [], current_coordinate = checking_piece.coordinate)
      shift = [-1, 1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless board.board[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      bottom_left(result, current_coordinate)
    end

    def top_right(result = [], current_coordinate = checking_piece.coordinate)
      shift = [1, -1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless board.board[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      top_right(result, current_coordinate)
    end

    def top_left(result = [], current_coordinate = checking_piece.coordinate)
      shift = [-1, -1]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless board.board[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      top_left(result, current_coordinate)
    end

    def horizontal(king_x, _king_y, enemy_x, _enemy_y)
      return left_horizontal if king_x < enemy_x
      return right_horizontal if king x > enemy_x
    end

    def left_horizontal(result = [], current_coordinate = checking_piece.coordinate)
      shift = [-1, 0]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless board.board[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      left_horizontal(result, current_coordinate)
    end

    def right_horizontal(result = [], current_coordinate = checking_piece.coordinate)
      shift = [-1, 0]
      coordinate = [current_coordinate[0] + shift[0], current_coordinate[1] + shift[1]]
      return result unless board.board[coordinate[1]][coordinate[0]] == ''

      result << coordinate
      current_coordinate = coordinate
      right_horizontal(result, current_coordinate)
    end
  end
end
