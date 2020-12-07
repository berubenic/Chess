# frozen_string_literal: true

module Chess
  # Game has an overview of everything
  class Game
    include Display
    
    attr_reader :board, :player_one, :player_two, :current_player

    def initialize(board: Board.new, player_one: nil, player_two: nil, current_player: player_one)
      @board = board
      @player_one = player_one
      @player_two = player_two
      @current_player = current_player
    end

    def intro
      title_message
      welcome_message
      case ask_game_mode
      when 1
        setup_game
      when 2
        load_game
      end
    end
  end
end
