# frozen_string_literal: true

module Chess
  class Game
    def initialize(board = Board.new, player_one = Player.new, player_two = Player.new)
      @board = board
      @player_one = player_one
      @player_two = player_two
    end

    def setup_game
      board.create_board
      board.setup_board
      player_one.input_name
      player_two.input_name
      player_one.assign_color('white')
      player_two.assign_color('black')
    end
  end
end
