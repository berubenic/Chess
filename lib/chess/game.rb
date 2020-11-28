# frozen_string_literal: true

require 'pry'

module Chess
  # controls the game flow
  class Game
    include Display
    include Translator

    attr_reader :board, :player_one, :player_two, :current_player, :referee, :selection, :action, :movements, :captures

    def initialize(board = Board.new)
      @board = board
      @referee = Referee.new(board: board)
      @player_one = nil
      @player_two = nil
      @current_player = nil
      @selection = nil
      @action = nil
      @movements = []
      @captures = []
    end

    Player = Struct.new(:name, :color)

    def intro
      title_message
      welcome_message
      two_player_mode if ask_game_mode == 2
    end

    def two_player_mode
      setup_two_player_game
      loop do
        player_selection_loop
        switch_player
      end
    end

    def setup_two_player_game
      setup_two_players
      setup_board
    end

    def setup_two_players
      create_player_one
      create_player_two
    end

    def setup_board
      board.setup_board
    end

    def switch_player
      if current_player == player_one
        @current_player = player_two
      elsif current_player == player_two
        @current_player = player_one
      end
    end

    def player_selection_loop
      display_board(board.board)
      select_piece
      translate_selection
      invalid_input if selection == false

      return find_movements_and_captures if referee.valid_selection?(selection, current_player)

      invalid_selection
    end

    def invalid_input
      invalid_input_message
      revert_selection
      display_board(board.board)
      player_selection_loop
    end

    def invalid_selection
      invalid_selection_message
      revert_selection
      display_board(board.board)
      player_selection_loop
    end

    def find_movements_and_captures
      piece = board.find_tile(selection)
      @movements = piece.possible_movements
      @captures = piece.possible_captures
      return no_movements_and_captures if movements.empty? && captures.empty?

      board.add_moves(movements)
      display_board(board.board)
      execute_movement_or_capture
    end

    def execute_movement_or_capture
      display_board(board.board)
      select_movement_or_capture
      translate_action
      return invalid_movement_or_capture unless movements.include?(action) || captures.include?(action)

      board.execute_move(action, selection)
      board.remove_moves(movements, action)
    end

    def invalid_movement_or_capture
      invalid_movement_or_capture_message
      revert_action
      execute_movement_or_capture
    end

    def no_movements_and_captures
      no_movements_or_captures_message
      board.revert_highlight(selection)
      revert_selection
      player_selection_loop
    end

    def select_movement_or_capture
      @action = ask_to_select_movement_or_capture(current_player)
    end

    def translate_action
      @action = translate(action)
    end

    def select_piece
      @selection = ask_to_select_piece(current_player)
    end

    def translate_selection
      @selection = translate(selection)
    end

    def revert_selection
      @selection = nil
    end

    def revert_action
      @action = nil
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
