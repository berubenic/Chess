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
      verify_input(player_input)
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

    def verify_input(input)
      if input.length == 2 && input[0].downcase == /[A-Ga-g]/ && input[1] >= 1 && input[1] <= 8
        input.downcase!
      else
        puts 'Invalid move, please try again.'
        player_input
      end
    end
  end
end
