# frozen_string_literal: true

module Chess
  # Pawn
  class Pawn < Piece
    def possible_movements
      if color == 'white'
        possible_white_movements
      elsif color == 'black'
        possible_black_movements
      end
    end

    def possible_white_movements
      @movements = []
      move = [coordinate[0], coordinate[1] - 1]
      @movements << move if valid_move?(move)
      return unless valid_move?(move)

      unless moved
        additional_move = [coordinate[0], coordinate[1] - 2]
        @movements << additional_move if valid_move?(additional_move)
      end
    end

    def possible_black_movements
      @movements = []
      move = [coordinate[0], coordinate[1] + 1]
      @movements << move if valid_move?(move)
      return unless valid_move?(move)

      unless moved
        additional_move = [coordinate[0], coordinate[1] + 2]
        @movements << additional_move if valid_move?(additional_move)
      end
    end
  end
end
