# frozen_string_literal: true

require 'pry'

module Chess
  # looks for check, checkmate and stalemate
  class Referee
    include Castling

    attr_reader :board, :white_king, :black_king, :checking_piece

    def initialize(board: nil)
      @board = board
      @white_king = nil
      @black_king = nil
      @checking_piece = nil
    end

    def valid_selection?(selection, player)
      return false if selection.nil?

      color = player.color
      tile = board.board[selection[1]][selection[0]]
      return false if tile == '' || tile.color != color

      true
    end

    def enemy_player_checkmated?(player)
      enemy_player_checked?(player) && enemy_player_mated?(player)
    end

    def current_player_checked?(player)
      if player.color == 'white'
        check?(white_king)
      elsif player.color == 'black'
        check?(black_king)
      end
    end

    def enemy_player_checked?(player)
      if player.color == 'white'
        check?(black_king)
      elsif player.color == 'black'
        check?(white_king)
      end
    end

    def current_player_stalemated?(player)
      if player.color == 'white'
        stalemate?(white_king)
      elsif player.color == 'black'
        stalemate?(black_king)
      end
    end

    def enemy_player_mated?(player)
      if player.color == 'white'
        mate?(black_king)
      elsif player.color == 'black'
        mate?(white_king)
      end
    end

    def check?(king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)
          next if tile == king

          tile.possible_captures
          next if tile.captures.nil?

          return king_is_in_check(tile) if tile.captures.include?(king.coordinate)
        end
      end
      @checking_piece = nil
      false
    end

    def king_is_in_check(tile)
      @checking_piece = tile
      true
    end

    def stalemate?(king)
      king.possible_movements
      return false if king.movements.any? { |move| can_avoid_attack?(move, king) }

      true
    end

    def mate?(king)
      return false if can_kill_checking_piece?(king) || king_can_avoid_attack?(king) || friendly_can_block?(king)

      true
    end

    def can_kill_checking_piece?(king)
      board.board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String) || tile.color != king.color

          tile.possible_captures
          next if tile.captures.nil?

          return true if tile.captures.include?(checking_piece.coordinate)
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
      if tile.color == 'black'
        black_pawn_can_attack?(move, pawn)
      elsif tile.color == 'white'
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

    def friendly_can_block?(king)
      return false unless checking_piece.is_a?(Queen) || checking_piece.is_a?(Rook) || checking_piece.is_a?(Bishop)

      blocking_coordinates = coordinates_between_king_and_checking_piece(king)

      blocking_coordinates.any? { |coordinate| friendly_can_move_to_blocking_coordinate?(coordinate) }
    end

    def friendly_can_move_to_blocking_coordinate?(coordinate)
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

    def coordinates_between_king_and_checking_piece(king)
      king_x = king.coordinate[0]
      king_y = king.coordinate[1]
      enemy_x = checking_piece.coordinate[0]
      enemy_y = checking_piece.coordinate[1]
      enemy_positions(king_x, king_y, enemy_x, enemy_y)
    end

    def enemy_position(king_x, king_y, enemy_x, enemy_y)
      case enemy_position
      when bottom_right?(king_x, king_y, enemy_x, enemy_y)
        bottom_right
      when bottom_left?(king_x, king_y, enemy_x, enemy_y)
        bottom_left
      when top_right?(king_x, king_y, enemy_x, enemy_y)
        top_right
      when top_left?(king_x, king_y, enemy_x, enemy_y)
        top_left
      when horizontal?(king_x, king_y, enemy_x, enemy_y)
        horizontal(king_x, king_y, enemy_x, enemy_y)
      when vertical?(king_x, king_y, enemy_x, enemy_y)
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

    def castling(king, rook)
      return unvalid_castling(king, rook) if king.check

      short_castling(king, rook)
      long_castling(king, rook)
    end

    def find_kings
      board.board.each do |row|
        row.each do |tile|
          next if tile == ''

          assign_kings(tile) if tile.is_a?(King)
        end
      end
    end

    private

    def assign_kings(tile)
      @white_king = tile if tile.color == 'white'
      @black_king = tile if tile.color == 'black'
    end
  end
end
