# frozen_string_literal:true

require 'yaml'
require 'pathname'

module Chess
  # handles saving and loading
  module SaveLoad

    def define_game_state
      game_state = {
        'board' => @board,
        'player_one' => @player_one,
        'player_two' => @player_two,
        'current_player' => @current_player,
      }
      save_game(game_state)
    end

    def save_game(game_state)
      Dir.mkdir 'saves' unless Dir.exist? 'saves'
      save_file = File.open('saves/chess_save.yml', 'w')
      YAML.dump(game_state, save_file)
      save_file.close
      save_message
      exit
    end

    def load_game
      load_error unless File.exist? 'saves/chess_save.yml'
      save_file = YAML.load(File.read('saves/chess_save.yml'))
      @board = save_file['board']
      @player_one = save_file['player_one']
      @player_two = save_file['player_two']
      @current_player = save_file['current_player']
      game_loop
    end

    def save_message
      puts "Game saved!"
      sleep 2
    end
    
    def load_error
      puts 'No saved file found.'
      sleep 2
      load './game/game.rb'
    end
  end
end