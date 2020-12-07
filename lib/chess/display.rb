# frozen_string_literal: true

require 'ruby_figlet'
using RubyFiglet

require 'tty-prompt'

module Chess
  # Prints Board and messages
  module Display
    module_function

    COLUMN_HEADER = '   A  B  C  D  E  F  G  H    '

    def title_message
      clear
      puts "--------\n             Chess\n--------".art
      puts "\n\n\n"
    end

    def welcome_message
      puts "Let's play Chess!"
      puts "\n"
    end

    def ask_game_mode
      prompt = TTY::Prompt.new
      choices = { Play: 1, Load: 2 }
      prompt.select('Select a game mode.', choices)
    end

    def clear
      system('clear') || system('cls')
    end
  end
end
