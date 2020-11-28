# frozen_string_literal: true

module Chess
  # Movement and captures for Queen, Rook and Bishop
  module DirectionalMovement
    def find_moves(directions, moves = [])
      directions.each do |direction|
        result = validate_movements(direction)
        result.each { |coordinate| moves << coordinate }
      end
      moves
    end

    def validate_movements(direction, result = [], current = coordinate)
      next_move = [current[0] + direction[0], current[1] + direction[1]]
      if valid_move?(next_move)
        result << next_move
        current = next_move
        validate_movements(direction, result, current)
      else
        result
      end
    end

    def find_captures(directions, result = [])
      directions.each do |direction|
        result << validate_captures(direction) unless validate_captures(direction).nil?
      end
      result
    end

    def validate_captures(direction, current = coordinate)
      return nil unless within_board?(current)

      next_move = [current[0] + direction[0], current[1] + direction[1]]
      if valid_capture?(next_move)
        next_move
      else
        current = next_move
        validate_captures(direction, current)
      end
    end
  end
end
