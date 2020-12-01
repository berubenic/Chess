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
      @executed_piece = nil
    end

    Player = Struct.new(:name, :color)

    def intro
      title_message
      welcome_message
      two_player_mode if ask_game_mode == 2
    end

    def two_player_mode
      setup_two_player_game
      referee.find_kings
      loop do
        return draw if referee.current_player_stalemate?(current_player)

        player_is_in_check_warning if referee.current_player_in_check?(current_player)
        player_selection_loop
        if referee.enemy_player_in_check?(current_player) && referee.enemy_player_mated?(current_player)
          return game_over
        end

        switch_player
      end
    end

    # piece selection logic

    def player_selection_loop
      display_board(board.board)
      select_piece
      translate_selection
      return invalid_input if selection == false

      return find_movements_and_captures if referee.valid_selection?(selection, current_player)

      invalid_selection
    end

    def select_piece
      @selection = ask_to_select_piece(current_player)
    end

    def translate_selection
      @selection = translate(selection)
    end

    # before choosing an action

    def find_movements_and_captures
      # binding.pry
      piece = board.find_tile(selection)
      piece_possibilities(piece)
      return no_movements_and_captures if no_movements? && no_captures? && no_en_passant?

      add_move_and_captures
      display_board(board.board)
      execute_movement_or_capture
    end

    def add_move_and_captures
      board.add_moves(movements) unless no_movements?
      board.add_captures(captures) unless no_captures?
      board.add_en_passant(en_passant_captures) unless no_en_passant?
    end

    def piece_possibilities(piece)
      piece.possible_movements
      piece.possible_captures
      piece.possible_en_passant if piece.is_a?(Pawn)
      assign_piece_possibilities(piece)
    end

    def assign_piece_possibilities(piece)
      @movements = piece.movements
      @captures = piece.captures
      @en_passant_captures = piece.en_passant_captures if piece.is_a?(Pawn)
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

    # choosing an action

    def execute_movement_or_capture
      display_board(board.board)
      select_movement_or_capture
      translate_action
      return invalid_movement_or_capture unless valid_action?

      assign_executed_piece(action)
      board.execute_move(action, selection)
      return revert_execution if king_is_in_check?

      remove_moves_and_captures
      revert_moves_and_captures
    end

    def select_movement_or_capture
      @action = ask_to_select_movement_or_capture(current_player)
    end

    def translate_action
      @action = translate(action)
    end

    def assign_executed_piece(action)
      return if board.board[action[1]][action[0]] == ''

      @executed_piece = board.board[action[1]][action[0]]
    end

    def valid_action?
      action_is_a_movement? || action_is_a_capture? || action_is_a_en_passant?
    end

    def action_is_a_movement?
      return false if no_movements?

      movements.include?(action)
    end

    def action_is_a_capture?
      return false if no_captures?

      captures.include?(action)
    end

    def action_is_a_en_passant?
      return false if no_en_passant?

      en_passant_captures.include?(action)
    end
    # error messages

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

    # revert

    def revert_execution
      king_is_in_check_message
      board.revert_move(action, selection)
      remove_moves_and_captures
      revert_moves_and_captures
      player_selection_loop
    end

    def revert_moves_and_captures
      revert_action
      revert_selection
      revert_captures
      revert_movements
      revert_en_passant
    end

    def invalid_movement_or_capture
      invalid_movement_or_capture_message
      revert_action
      execute_movement_or_capture
    end

    def no_movements_and_captures
      no_movements_or_captures_message
      revert_selection
      player_selection_loop
    end

    def remove_moves_and_captures
      board.remove_moves(movements, action) unless no_movements?
      board.remove_captures(captures, action) unless no_captures?
      board.remove_en_passant_capture(action, selection) unless no_en_passant?
    end

    def revert_selection
      @selection = nil
    end

    def revert_action
      @action = nil
    end

    def revert_movements
      @movements = []
    end

    def revert_captures
      @captures = []
    end

    def revert_en_passant
      @en_passant_captures = []
    end

    def king_is_in_check?
      referee.current_player_in_check?(current_player)
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
