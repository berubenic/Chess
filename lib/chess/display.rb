# frozen_string_literal: true

require 'ruby_figlet'
using RubyFiglet

require 'tty-prompt'

module Chess
  # Prints Board and messages
  module Display
    def title_message
      clear
      puts '--------'.art
      puts '             Chess'.art
      puts '--------'.art
      puts "\n\n\n"
    end

    def welcome_message
      puts "Let's play Chess!"
    end

    def ask_game_mode
      prompt = TTY::Prompt.new
      choices = { single_player: 1, multiplayer: 2 }
      prompt.select('Select a game mode.', choices)
    end

    def clear
      system('clear') || system('cls')
    end
  end
end
