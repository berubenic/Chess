# frozen_string_literal: true

require 'ruby_figlet'
using RubyFiglet

require 'tty-prompt'

module Chess
  # Prints Board and messages
  module Display
    COLUMN_HEADER = '   A  B  C  D  E  F  G  H    '

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
      choices = { Play: 1, Load: 2 }
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
      puts "#{player.name}, enter the coordinate of the piece you wish to move. (ex. A1) \nIf castling, enter 'short castle' or 'long castle' \nEnter 's' to save.".default.bg_default
      prompt = TTY::Prompt.new
      prompt.ask
    end

    def ask_to_select_movement_or_capture(player)
      prompt = TTY::Prompt.new
      prompt.ask("#{player.name}, select a tile to move to or a piece to capture. (ex. A1)".default.bg_default)
    end

    def invalid_movement_or_capture_message
      puts 'Invalid movement or capture, please try again.'.red.bg_default
      sleep 2
      clear
    end

    def invalid_input_message
      puts 'Invalid input, please try again.'.red.bg_default
      sleep 2
      clear
    end

    def invalid_selection_message
      puts 'Invalid selection, please select a valid piece.'.red.bg_default
      sleep 2
      clear
    end

    def no_movements_or_captures_message
      puts 'No possible moves or captures, please select a valid piece.'.red.bg_default
      sleep 2
      clear
    end

    def king_is_in_check_message
      puts 'You put your king in check! Please try again!'.red.bg_default
      sleep 2
      clear
    end

    def player_is_in_check_warning
      clear
      display_board(board.board)
      puts 'Warning! Your king is in check!'.red.bg_default
      sleep 2
      clear
    end

    def draw
      clear
      display_board(board.board)
      puts "It's a draw... #{current_player.name} is stalemated...".default.bg_default
      prompt = TTY::Prompt.new
      prompt.keypress('Press space or enter to continue', keys: %i[space return])
      clear
      load './game/game.rb'
    end

    def game_over
      clear
      display_board(board.board)
      puts "Game over! #{current_player.name} has won!".default.bg_default
      prompt = TTY::Prompt.new
      prompt.keypress('Press space or enter to continue', keys: %i[space return])
      clear
      load './game/game.rb'
    end

    def display_board(board)
      clear
      puts COLUMN_HEADER.default.bg_default
      board.each_with_index do |row, y|
        print "#{y + 1} ".default.bg_default
        odd_row(row) if y.odd?
        even_row(row) if y.even?
        print " #{y + 1} ".default.bg_default
        print "\n".bg_default
      end
      puts COLUMN_HEADER.default.bg_default
      puts
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
      elsif tile == 'o'.green
        tile
      elsif tile == 'x'.red
        tile
      else
        tile.content.to_s
      end
    end
  end
end
