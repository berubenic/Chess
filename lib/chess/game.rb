# frozen_string_literal: true

module Chess
  class Game
    def initialize(board = Board.new, player_one = Player.new, player_two = Player.new)
      @board = board
      @player_one = player_one
      @player_two = player_two
    end
  end
end