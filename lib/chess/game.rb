# frozen_string_literal: true

require_relative './board'
require_relative './display'
require_relative './tile_helper'
require_relative './referee'
require_relative './pawn_promotion'
require_relative './save_load'

module Chess
  # Game has an overview of everything
  class Game
    include SaveLoad

    attr_reader :board, :player_one, :player_two, :current_player

    def initialize(board: Board.new, player_one: nil, player_two: nil, current_player: nil)
      @board = board
      @player_one = player_one
      @player_two = player_two
      @current_player = current_player
    end

    # holds player_one and player_two
    Player = Struct.new(:name, :color)

    def intro
      Display.title_message
      Display.welcome_message
      case Display.ask_game_mode
      when 1
        setup_game
      when 2
        load_game
      else
        NoMatchingPatternError
      end
    end

    def setup_game
      setup_players
      board.setup_board
      Display.display_board(board.array)
      game_loop
    end

    def game_loop
      loop do
        Display.player_is_in_check_warning(board) if current_player_in_check?
        return Display.draw(board, current_player) if stalemate?

        player_selection
        verify_pawn_promotion
        return Display.game_over(board, current_player) if checkmate?

        switch_player
      end
    end

    def player_selection
      loop do
        Display.display_board(board.array)
        selection = Display.ask_to_select_piece(current_player)
        return translate_selection(selection) if Translator.valid_input?(selection)

        Display.invalid_input_message
      end
    end

    def player_action(piece)
      loop do
        Display.display_board(board.array)
        action = Display.ask_to_select_action(current_player)
        return translate_action(action, piece) if Translator.valid_input?(action)

        Display.invalid_input_message
      end
    end

    def translate_selection(selection)
      case selection
      when 's'
        return define_game_state
      when 'long castle', 'short castle'
        return execute_castling(selection) if valid_castling?(selection)
      else
        translated_selection = Translator.translate(selection)
        return find_movements_and_captures(translated_selection) if valid_selection?(translated_selection)
      end

      invalid_selection
    end

    def verify_pawn_promotion(color = current_player.color)
      case color
      when 'white'
        PawnPromotion.white_pawn_promotion(board)
      when 'black'
        PawnPromotion.black_pawn_promotion(board)
      else
        NoMatchingPatternError
      end
    end

    def valid_selection?(selection, color = current_player.color)
      tile = TileHelper.find_tile(selection, board.array)
      return false unless TileHelper.tile_belongs_to_player?(color, tile)

      true
    end

    def valid_castling?(selection, array = board.array)
      king = TileHelper.find_king(current_player, array)
      rook = TileHelper.find_rook_for_castling(current_player, selection, array)

      return false if Referee.check?(array, king) ||
                      Referee.king_or_rook_have_moved?(king, rook) ||
                      TileHelper.tile_between_king_and_rook_are_not_empty?(rook, array) ||
                      Referee.castling_tile_can_be_attacked?(king, rook, array)

      true
    end

    def execute_action(translated_action, piece, array = board.array)
      board.execute_action(translated_action, piece)
      return revert_action(translated_action, piece) if current_player_in_check?

      piece.update_current_coordinate(translated_action)
      board.remove_moves_and_captures
      Display.display_board(array)
    end

    def execute_castling(selection, color = current_player.color)
      case selection
      when 'long castle'
        board.execute_long_castle(color)
      when 'short castle'
        board.execute_short_castle(color)
      else
        NoMatchingPatternError
      end
    end

    def find_movements_and_captures(selection, array = board.array)
      piece = TileHelper.find_tile(selection, array)
      return no_movements_and_captures if piece.can_not_move_or_capture?

      board.add_moves_and_captures(piece)
      Display.display_board(array)
      player_action(piece)
    end

    def translate_action(action, piece)
      translated_action = Translator.translate(action)
      return execute_action(translated_action, piece) if board.valid_action?(translated_action)

      invalid_action(piece)
    end

    def revert_action(translated_action, piece)
      Display.king_is_in_check_message
      board.revert_move(translated_action, piece)
      board.remove_moves_and_captures
      player_selection
    end

    def stalemate?
      king = TileHelper.find_king(current_player, board.array)
      return false if Referee.king_can_avoid_attack?(king, board)

      Referee.no_friendly_piece_can_move?(board, king)
    end

    def checkmate?
      king = TileHelper.find_king(enemy_player, board.array)
      return false unless Referee.check?(board.array, king)

      return false if Referee.king_can_avoid_attack?(king, board) ||
                      Referee.can_kill_checking_piece?(king, board) ||
                      Referee.friendly_can_block?(king, board)

      true
    end

    def current_player_in_check?(array = board.array)
      king = TileHelper.find_king(current_player, array)
      Referee.check?(array, king)
    end

    def invalid_selection
      Display.invalid_selection_message
      player_selection
    end

    def no_movements_and_captures
      Display.no_action_message
      player_selection
    end

    def invalid_action(piece)
      Display.invalid_action_message
      player_action(piece)
    end

    def switch_player
      if current_player == player_one
        @current_player = player_two
      elsif current_player == player_two
        @current_player = player_one
      end
    end

    def enemy_player
      if current_player == player_one
        player_two
      else
        player_one
      end
    end

    def setup_players
      create_player_one
      create_player_two
    end

    def create_player_one
      color = 'white'
      name = Display.ask_player_name('Player one')
      Display.welcome_player_message(name, color)
      @player_one = Player.new(name, color)
      @current_player = player_one
    end

    def create_player_two
      color = 'black'
      name = Display.ask_player_name('Player two')
      Display.welcome_player_message(name, color)
      @player_two = Player.new(name, color)
    end
  end
end
