# frozen_string_literal: true

module Chess
  # controls the game flow
  class Game
    include Display
    include Translator
    include SaveLoad

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
      case ask_game_mode
      when 1
        two_player_mode
      when 2
        load_game
      end
    end

    def two_player_mode
      setup_two_player_game
      referee.find_kings
      referee.find_rooks
      game_loop
    end

    def game_loop
      loop do
        return draw if referee.current_player_stalemated?(current_player)

        player_is_in_check_warning if referee.current_player_checked?(current_player)
        player_selection
        board.verify_pawn_promotion(current_player)
        return game_over if referee.enemy_player_checkmated?(current_player)

        switch_player
      end
    end

    # piece selection logic

    def player_selection
      display_board(board.board)
      select_piece
      return define_game_state if selection == 's'
      return execute_castling if referee.valid_castling?(selection, current_player)
      return invalid_selection_input unless valid_input?(selection)

      translate_selection

      return find_movements_and_captures if referee.valid_selection?(selection, current_player)

      invalid_selection_piece
    end

    def select_piece
      @selection = ask_to_select_piece(current_player)
    end

    def translate_selection
      @selection = translate(selection)
    end

    def invalid_selection_input
      invalid_input_message
      reset_player_selection
    end

    def invalid_selection_piece
      invalid_selection_message
      reset_player_selection
    end

    def reset_player_selection
      revert_selection
      display_board(board.board)
      player_selection
    end

    # display possible moves and/or captures

    def find_movements_and_captures
      piece = board.find_tile(selection)
      piece_possibilities(piece)
      return no_movements_and_captures if no_movements? && no_captures? && no_en_passant?

      add_move_and_captures
      player_action
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

    def no_movements_and_captures
      no_movements_or_captures_message
      revert_selection
      player_selection
    end

    # select move or capture
    def player_action
      display_board(board.board)
      select_movement_or_capture
      return invalid_action_input unless valid_input?(action)

      translate_action
      return invalid_movement_or_capture unless valid_action?

      execute_movement_or_capture
    end

    def select_movement_or_capture
      @action = ask_to_select_movement_or_capture(current_player)
    end

    def translate_action
      @action = translate(action)
    end

    def invalid_action_input
      invalid_movement_or_capture_message
      reset_player_action
    end

    def invalid_movement_or_capture
      invalid_movement_or_capture_message
      reset_player_action
    end

    def reset_player_action
      revert_action
      player_action
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
    # execute move or capture

    def execute_movement_or_capture
      board.execute_move(action, selection)
      return revert_execution if referee.current_player_checked?(current_player)

      remove_moves_and_captures
    end

    def execute_castling
      board.execute_castling(selection, current_player)
    end

    def revert_execution
      king_is_in_check_message
      board.revert_move(action, selection)
      remove_moves_and_captures
      revert_moves_and_captures
      player_selection
    end

    def remove_moves_and_captures
      board.remove_moves(movements, action) unless no_movements?
      board.remove_captures(captures, action) unless no_captures?
      board.remove_en_passant_capture(en_passant_captures, action) unless no_en_passant?
      revert_moves_and_captures
    end

    def revert_moves_and_captures
      revert_action
      revert_selection
      revert_captures
      revert_movements
      revert_en_passant
      revert_captured_piece
    end

    # revert variables

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

    def revert_captured_piece
      board.reset_captured_piece
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
