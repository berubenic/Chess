# frozen_string_literal:true

require 'yaml'
module Chess
  # handles saving and loading
  module SaveLoad
    def define_game_state
      game_state = {
        'board' => @board,
        'referee' => @referee,
        'player_one' => @player_one,
        'player_two' => @player_two,
        'current_player' => @current_player,
        'selection' => @selection,
        'action' => @action,
        'movements' => @movements,
        'captures' => @captures,
        'en_passant_captures' => @en_passant_captures
      }
      save_game(game_state)
    end

    def save_game(game_state)
      save_file = File.open('chess_save.yml', 'w')
      YAML.dump(game_state, save_file)
      save_file.close
      exit
    end

    def load_game
      save_file = YAML.load(File.read('chess_save.yml'))
      @board = save_file['board']
      @referee = save_file['referee']
      @player_one = save_file['player_one']
      @player_two = save_file['player_two']
      @current_player = save_file['current_player']
      @selection = save_file['selection']
      @action = save_file['action']
      @movements = save_file['movements']
      @captures = save_file['captures']
      @en_passant_captures = save_file['en_passant_captures']
      game_loop
    end
  end
end
