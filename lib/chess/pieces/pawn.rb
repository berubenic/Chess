# frozen_string_literal: true

module Chess
  # Pawn
  class Pawn < Piece
    include SingleMovement

    WHITE_MOVES = [
      -1,
      -2
    ].freeze

    WHITE_CAPTURES = [
      [1, -1],
      [-1, -1]
    ].freeze

    BLACK_MOVES = [
      1,
      2
    ].freeze

    BLACK_CAPTURES = [
      [1, 1],
      [-1, 1]
    ].freeze

    attr_reader :moved, :en_passant_captures

    attr_accessor :two_squared

    def initialize(**args)
      @moved = false
      @two_squared = false
      @en_passant_captures = []
      super
    end

    def possible_movements
      if color == 'white'
        first_possible_move(WHITE_MOVES)
      elsif color == 'black'
        first_possible_move(BLACK_MOVES)
      end
    end

    def possible_captures
      if color == 'white'
        @captures = find_captures(WHITE_CAPTURES)
        @en_passant_captures = find_en_passant unless find_en_passant.nil?
      elsif color == 'black'
        @captures = find_captures(BLACK_CAPTURES)
        @en_passant_captures = find_en_passant unless find_en_passant.nil?
      end
    end

    private

    def first_possible_move(moves)
      move = [coordinate[0], coordinate[1] + moves[0]]
      @movements << move if valid_move?(move)
      return unless valid_move?(move)
      return if moved

      second_possible_move(moves)
    end

    def second_possible_move(moves)
      additional_move = [coordinate[0], coordinate[1] + moves[1]]
      @movements << additional_move if valid_move?(additional_move)
    end

    def find_en_passant(result = [])
      return unless en_passant_correct_row?

      result << left_en_passant unless left_en_passant.nil?
      result << right_en_passant unless right_en_passant.nil?
      result
    end

    def left_en_passant(left_tile = nil)
      left_coordinate = [coordinate[0] - 1, coordinate[1]]
      left_tile = board[left_coordinate[1]][left_coordinate[0]] if within_board?(left_coordinate)
      return nil unless left_tile.class == Pawn && left_tile.two_squared

      return [left_coordinate[0], left_coordinate[1] - 1] if color == 'white'
      return [left_coordinate[0], left_coordinate[1] + 1] if color == 'black'
    end

    def right_en_passant(right_tile = nil)
      right_coordinate = [coordinate[0] + 1, coordinate[1]]
      right_tile = board[right_coordinate[1]][right_coordinate[0]] if within_board?(right_coordinate)
      return nil unless right_tile.class == Pawn && right_tile.two_squared

      return [right_coordinate[0], right_coordinate[1] - 1] if color == 'white'
      return [right_coordinate[0], right_coordinate[1] + 1] if color == 'black'
    end

    def en_passant_correct_row?
      if color == 'white'
        coordinate[1] == 3
      elsif color == 'black'
        coordinate[1] == 4
      end
    end
  end
end
