# frozen_string_literal: false

module Chess
  # translates player input to coordinate
  module Translator
    module_function

    LETTERS = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7
    }.freeze

    def translate(input, result = [])
      input = input.downcase
      result << LETTERS.values_at(input[0])[0]
      result << input[1].to_i - 1
      result
    end

    def valid_input?(input)
      return false if input == ''

      return true if input.length == 2 && input[0].match?(/[a-hA-H]/) && input[1].match?(/[1-8]/)
      return true if ['s', 'long castle', 'short castle'].include?(input)

      false
    end
  end
end
