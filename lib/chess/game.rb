# frozen_string_literal: true

require_relative './board'
require_relative './display'

module Chess
  # Game has an overview of everything
  class Game
    include Display

    attr_reader :board, :player_one, :player_two, :current_player

    def initialize(board: Board.new, player_one: nil, player_two: nil, current_player: nil)
      @board = board
      @player_one = player_one
      @player_two = player_two
      @current_player = current_player
    end

    # holds player_one and player_two
    Player = Struct.new(:color, :name)

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

    def setup_game
      setup_players
      board.setup_board
      display_board(board.array)
      game_loop
    end

    def setup_players
      create_player_one
      create_player_two
    end

    def create_player_one
      color = 'white'
      name = ask_player_name('Player one')
      welcome_player_message(name, color)
      @player_one = Player.new(name, color)
      @current_player = player_one
    end

    def create_player_two
      color = 'black'
      name = ask_player_name('Player two')
      welcome_player_message(name, color)
      @player_two = Player.new(name, color)
    end
  end
end
