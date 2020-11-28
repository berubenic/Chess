# frozen_string_literal: true

module Chess
  # movements and captures for King, Knight, and Pawn(captures)
  module SingleMovement
    def find_movements(moves, result = [])
      moves.each do |x, y|
        move = [coordinate[0] + x, coordinate[1] + y]
        result << move if valid_move?(move)
      end
      result
    end

    def find_captures(moves, result = [])
      moves.each do |x, y|
        capture = [coordinate[0] + x, coordinate[1] + y]
        result << capture if valid_capture?(capture)
      end
      result
    end
  end
end
