# frozen_string_literal: true

# Player
module Chess
  class Player
    attr_reader :name, :turn, :color

    def initialize(name: nil, turn: false, color: nil)
      @name = name
      @turn = turn
      @color = color
    end

    def input_name
      @name = player_input
    end

    def assign_color(color)
      @color = color
    end

    def switch_turn
      if turn == false
        @turn = true
      elsif turn == true
        @turn = false
      end
    end

    private

    def player_input
      gets.chomp
    end
  end
end
