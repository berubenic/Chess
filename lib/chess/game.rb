# frozen_string_literal: true

require 'pry'

module Chess
  # controls the game flow
  class Game
    include Display
    include Translator

    attr_reader :board, :player_one, :player_two, :current_player, :referee, :selection, :action, :movements, :captures, :en_passant_captures

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
      @en_passant_captures = []
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

    def player_selection_loop
      display_board(board.board)
      select_piece
      translate_selection
      invalid_input if selection == false

      return find_movements_and_captures if referee.valid_selection?(selection, current_player)

      invalid_selection
    end

    def find_movements_and_captures
      piece = board.find_tile(selection)
      piece_possibilities(piece)
      return no_movements_and_captures if no_movements? && no_captures? && no_en_passant?

      add_move_and_captures
      display_board(board.board)
      execute_movement_or_capture
    end

    def execute_movement_or_capture
      display_board(board.board)
      select_movement_or_capture
      translate_action
      return invalid_movement_or_capture unless valid_action?

      board.execute_move(action, selection)
      remove_moves_and_captures
    end

    private

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

    def no_movements?
      movements.nil? || movements.empty?
    end

    def no_captures?
      captures.nil? || captures.empty?
    end

    def no_en_passant?
      en_passant_captures.nil? || en_passant_captures.empty?
    end

    def add_move_and_captures
      board.add_moves(movements) unless no_movements?
      board.add_captures(captures) unless no_captures?
      board.add_en_passant(en_passant_captures) unless no_en_passant?
    end

    def piece_possibilities(piece)
      @movements = piece.possible_movements
      @captures = piece.possible_captures
      @en_passant_captures = piece.possible_en_passant if piece.is_a?(Pawn)
    end

    def remove_moves_and_captures
      board.remove_moves(movements, action) unless no_movements?
      board.remove_captures(captures, action) unless no_captures?
    end

    def valid_action?
      action_is_a_movement? || action_is_a_capture?
    end

    def action_is_a_movement?
      return false if no_movements?

      movements.include?(action)
    end

    def action_is_a_capture?
      return false if no_captures?

      captures.include?(action)
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
