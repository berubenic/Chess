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

    def ask_to_select_piece(player)
      prompt = TTY::Prompt.new
      prompt.ask("#{player.name}, select a piece to move. (ex. A1)")
    end

    def ask_to_select_movement_or_capture(player)
      prompt = TTY::Prompt.new
      prompt.ask("#{player.name}, select a tile to move to or a piece to capture. (ex. A1)")
    end

    def invalid_movement_or_capture_message
      puts 'Invalid movement or capture, please try again.'
      sleep 1
      clear
    end

    def invalid_input_message
      puts 'Invalid input, please try again.'
      sleep 1
      clear
    end

    def invalid_selection_message
      puts 'Invalid selection, please select a valid piece.'
      sleep 1
      clear
    end

    def no_movements_or_captures_message
      puts 'No possible moves or captures, please select a valid piece.'
      sleep 1
      clear
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
      if tile.is_a?(String) || tile.capturable == false
        print " #{print_tile(tile)} ".bg_primary
      elsif tile.capturable
        print " #{print_tile(tile)} ".bg_red
      end
    end

    def secondary_color_tile(tile)
      if tile.is_a?(String) || tile.capturable == false
        print " #{print_tile(tile)} ".bg_secondary
      elsif tile.capturable
        print " #{print_tile(tile)} ".bg_red
      end
    end

    def print_tile(tile)
      if tile == ''
        ' '
      elsif tile == 'o'
        tile
      else
        tile.content.to_s
      end
    end
  end
end
