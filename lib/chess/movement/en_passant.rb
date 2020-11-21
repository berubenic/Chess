# frozen_string_literal: true

module EnPassant
  def find_en_passant(result = [])
    return unless en_passant_correct_row?

    result << left_en_passant unless left_en_passant.nil?
    result << right_en_passant unless right_en_passant.nil?
    result
  end

  def left_en_passant
    left_coordinate = [coordinate[0] - 1, coordinate[1]]
    return nil unless tile_valid?(left_coordinate)

    return [left_coordinate[0], left_coordinate[1] - 1] if color == 'white'
    return [left_coordinate[0], left_coordinate[1] + 1] if color == 'black'
  end

  def right_en_passant
    right_coordinate = [coordinate[0] + 1, coordinate[1]]
    return nil unless tile_valid?(right_coordinate)
    # tile_valid? is defined in pawn.rb

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
