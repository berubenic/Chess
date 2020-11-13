# frozen_string_literal: true

module Chess
  class Game
    attr_reader :board, :player_one, :player_two
    def initialize(board = Board.new, player_one = Player.new, player_two = Player.new)
      @board = board
      @player_one = player_one
      @player_two = player_two
    end

    def prepare_game
      board.prepare_game
      player_one.prepare_game('white')
      player_two.prepare_game('black')
    end

    def select_piece(player = current_player)
      player.select_piece
    end

    private

    def current_player
      player_one if player_one.turn == true
      player_two if player_two.turn == true
    end
  end
end
