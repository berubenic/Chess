# frozen_string_literal: true

require_relative './board'
require_relative './display'
require_relative './tile_helper'

module Chess
  # Game has an overview of everything
  class Game
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
        player_selection
        switch_player
      end
    end

    def player_selection
      loop do
        selection = Display.ask_to_select_piece(current_player)
        return translate_selection(selection) if Translator.valid_input?(selection)

        Display.invalid_input_message
      end
    end

    def translate_selection(selection)
      case selection
      when 's'
        return save_game
      when 'long castle' || 'short castle'
        # do nothing
      else
        selection = Translator.translate(selection)
      end
      return add_moves_and_captures if valid_selection?(selection)

      invalid_selection
    end

    def valid_selection?(selection, color = current_player.color)
      return valid_castling?(selection) if ['long castle', 'short castle'].include?(selection)

      tile = TileHelper.find_tile(selection, board.array)
      return false unless TileHelper.tile_belongs_to_player?(color, tile)

      true
    end

    def valid_castling?(_selection, array = board.array)
      king = TileHelper.find_king(player, array)
      rook = TileHelper.find_rook(player, selection, array)

      return false unless board.valid_castling?(king, rook)

      true
    end

    def invalid_selection
      Display.invalid_selection_message
      player_selection
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
