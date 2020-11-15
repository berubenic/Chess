# frozen_string_literal: true

# Player
module Chess
  # Player
  class Player
    attr_reader :name, :turn, :color

    def initialize(name: nil, turn: false, color: nil)
      @name = name
      @turn = turn
      @color = color
    end

    def prepare_game(color)
      input_name
      assign_color(color)
    end

    def select_piece
      input = player_input
      if verify_input?(input)
        input.downcase
      else
        puts 'Invalid move, please try again.'
        select_piece
      end
    end

    def switch_turn
      if turn == false
        @turn = true
      elsif turn == true
        @turn = false
      end
    end

    private

    def assign_color(color)
      @color = color
    end

    def input_name
      @name = player_input
    end

    def player_input
      gets.chomp
    end

    def verify_input?(input)
      return true if input.length == 2 && input[0] =~ /[a-gA-G]/ && input[1].to_i >= 1 && input[1].to_i <= 8
    end
  end
end
