# frozen_string_literal: true

module Chess
  module Translator
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

    def translate(move, result = [])
      move = verify_move(move)
      return move unless move

      result << LETTERS.values_at(move[0])[0]
      result << move[1].to_i - 1
      result
    end

    def verify_move(move)
      move = move.dup
      if move.length == 2 && move[0].match?(/[a-hA-H]/) && move[1].match?(/[1-8]/)
        move.downcase!
      else
        puts 'Invalid input, please try again.'
        false
      end
    end
  end
end
