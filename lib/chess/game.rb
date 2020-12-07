# frozen_string_literal: true

module Chess
  # Game has an overview of everything
  class Game
    attr_reader :board, :player_one, :player_two, :current_player

    def initialize(board: nil, player_one: nil, player_two: nil, current_player: nil)
      @board = board
      @player_one = player_one
      @player_two = player_two
      @current_player = current_player
    end
  end
end
