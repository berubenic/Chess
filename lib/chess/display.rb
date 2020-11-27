# frozen_string_literal: true

require 'ruby_figlet'
using RubyFiglet

require 'tty-prompt'

module Chess
  # Prints Board and messages
  module Display
    COLUMN_HEADER = '   A  B  C  D  E  F  G  H'

    def title_message
      clear
      puts '--------'.art
      puts '             Chess'.art
      puts '--------'.art
      puts "\n\n\n"
    end

    def welcome_message
      puts "Let's play Chess!"
      puts "\n"
    end

    def ask_game_mode
      prompt = TTY::Prompt.new
      choices = { single_player: 1, local_multiplayer: 2 }
      prompt.select('Select a game mode.', choices)
    end

    def clear
      system('clear') || system('cls')
    end

    def ask_player_name(player)
      clear
      title_message
      prompt = TTY::Prompt.new
      prompt.ask("What is your name? (#{player})")
    end

    def welcome_player_message(name, color)
      puts "Welcome, #{name}. You are assigned the #{color} pieces."
      sleep 1.5
    end

    def display_board(board)
      clear
      puts COLUMN_HEADER
      board.each_with_index do |row, y|
        print "#{y + 1} "
        odd_row(row) if y.odd?
        even_row(row) if y.even?
        print " #{y + 1} "
        print "\n"
      end
      puts COLUMN_HEADER
    end

    def odd_row(row)
      row.each_with_index do |tile, x|
        primary_color_tile(tile) if x.odd?
        secondary_color_tile(tile) if x.even?
      end
    end

    def even_row(row)
      row.each_with_index do |tile, x|
        primary_color_tile(tile) if x.even?
        secondary_color_tile(tile) if x.odd?
      end
    end

    def primary_color_tile(tile)
      print " #{print_content(tile)} ".bg_primary
    end

    def secondary_color_tile(tile)
      print " #{print_content(tile)} ".bg_secondary
    end

    def print_content(tile)
      if tile == ''
        ' '
      else
        tile.content.to_s
      end
    end
  end
end
