# frozen_string_literal: true

module Chess
  # Utility functions for pieces
  module PieceHelper
    module_function

    def coordinate_outside_of_board?(coordinate)
      coordinate.any? { |number| number.negative? || number > 7 }
    end

    def add_moves_to_result(moves, result)
      moves.each { |move| result << move }
      result
    end
  end
end
