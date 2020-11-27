# frozen_string_literal: true

require 'pry'

module Chess
  # controls the game flow
  class Game
    include Display
    include Translator

    attr_reader :board, :player_one, :player_two, :current_player, :referee, :selection

    def initialize(board = Board.new)
      @board = board
      @referee = Referee.new(board: board)
      @player_one = nil
      @player_two = nil
      @current_player = nil
      @selection = nil
    end

    Player = Struct.new(:name, :color)

    def intro
      title_message
      welcome_message
      two_player_mode if ask_game_mode == 2
    end

    def two_player_mode
      setup_two_players
      setup_board
      display_board(board.board)
      @current_player = player_one
      loop until select_piece_loop == true
      @board = board.highlight_selection(selection)
      display_board(board.board)
    end

    def setup_two_players
      create_player_one
      create_player_two
    end

    def setup_board
      board.setup_board
    end

    def select_piece_loop
      select_piece
      translate_piece
      # piece can't be translated
      if selection == false
        invalid_input_message
        revert_selection
        display_board(board.board)
        return false
      end

      return true if referee.valid_selection?(selection, current_player.color)

      invalid_selection_message
      revert_selection
      display_board(board.board)
      false
    end

    def select_piece
      @selection = ask_to_select_piece(current_player.name)
    end

    def translate_piece
      @selection = translate(selection)
    end

    def revert_selection
      @selection = nil
    end

    def create_player_one
      color = 'white'
      name = ask_player_name('Player one')
      welcome_player_message(name, color)
      @player_one = Player.new(name, color)
    end

    def create_player_two
      color = 'black'
      name = ask_player_name('Player two')
      welcome_player_message(name, color)
      @player_two = Player.new(name, color)
    end
  end
end
