# frozen_string_literal: true

module Chess
  # controls the game flow
  class Game
    include Display
    attr_reader :board
    def initialize(board = Board.new)
      @board = board
      @referee = Referee.new(board: board)
      @player_one = nil
      @player_two = nil
      @current_player = nil
    end

    Player = Struct.new(:name, :color)

    def intro
      title_message
      welcome_message
      two_player_mode if ask_game_mode == 2
    end

    def two_player_mode
      setup_two_players
    end

    def setup_two_players
      # create_player_one
      # create_player_two
      board.setup_board
      display_board(board.board)
    end

    def create_player_one
      color = 'white'
      name = ask_player_name('Player one')
      welcome_player_message(name, color)
      @player_one = Player.new(name: name, color: color)
    end

    def create_player_two
      color = 'black'
      name = ask_player_name('Player two')
      welcome_player_message(name, color)
      @player_two = Player.new(name: name, color: color)
    end
  end
end
