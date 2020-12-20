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
      puts "#{player.name}, enter the coordinate of the piece you wish to move. (ex. A1)"
      puts "If castling, enter 'short castle' or 'long castle'"
      puts "Enter 's' to save."
      prompt = TTY::Prompt.new
      prompt.ask
    end

    def ask_to_select_action(player)
      prompt = TTY::Prompt.new
      prompt.ask("#{player.name}, select a tile to move to or a piece to capture. (ex. A1)")
    end

    def draw(board, player)
      clear
      display_board(board.array)
      puts "It's a draw... #{player.name} is stalemated..."
      prompt = TTY::Prompt.new
      prompt.keypress('Press space or enter to continue', keys: %i[space return])
      clear
      load './game/game.rb'
    end

    def game_over(board, player)
      clear
      display_board(board.array)
      puts "Game over! #{player.name} has won!"
      prompt = TTY::Prompt.new
      prompt.keypress('Press space or enter to continue', keys: %i[space return])
      clear
      load './game/game.rb'
    end

    def invalid_input_message
      puts 'Invalid input, please try again.'
      sleep 2
      clear
    end

    def invalid_selection_message
      puts 'Invalid selection, please select a valid piece.'
      sleep 2
      clear
    end

    def no_action_message
      puts 'No possible moves or captures, please select a valid piece.'
      sleep 2
      clear
    end

    def invalid_action_message
      puts 'Invalid movement or capture, please try again.'
      sleep 2
      clear
    end

    def king_is_in_check_message
      puts 'You put your king in check! Please try again!'
      sleep 2
      clear
    end

    def clear
      system('clear') || system('cls')
    end

    def display_board(board)
      clear
      display_header
      display_tiles(board)
      display_header
      puts
    end

    def display_tiles(board)
      board.each_with_index do |row, y_coordinate|
        display_left_sidebar(y_coordinate)
        odd_row(row) if y_coordinate.odd?
        even_row(row) if y_coordinate.even?
        display_right_sidebar(y_coordinate)
      end
    end

    def display_left_sidebar(y_coordinate)
      print "#{y_coordinate + 1} "
    end

    def display_right_sidebar(y_coordinate)
      print " #{y_coordinate + 1} \n"
    end

    def display_header
      puts COLUMN_HEADER
    end

    def odd_row(row)
      row.each_with_index do |tile, x_coordinate|
        primary_color_tile(tile) if x_coordinate.odd?
        secondary_color_tile(tile) if x_coordinate.even?
      end
    end

    def even_row(row)
      row.each_with_index do |tile, x_coordinate|
        primary_color_tile(tile) if x_coordinate.even?
        secondary_color_tile(tile) if x_coordinate.odd?
      end
    end

    #noinspection RubyResolve
    def primary_color_tile(tile)
      pastel = Pastel.new
      print pastel.on_bright_white(" #{print_tile(tile)} ")
    end

    def secondary_color_tile(tile)
      pastel = Pastel.new
      #noinspection RubyResolve
      print pastel.on_cyan(" #{print_tile(tile)} ")
    end

    def print_tile(tile)
      pastel = Pastel.new
      if tile == ''
        ' '
      elsif %w[o].include?(tile)
        #noinspection RubyResolve
        pastel.bright_magenta(tile)
      elsif %w[x].include?(tile)
        pastel.red(tile)
      else
        print_piece(tile)
      end
    end

    def print_piece(tile, piece = tile.content)
      pastel = Pastel.new
      if tile.capturable
        pastel.red.bold(piece)
      else
        pastel.black(piece)
      end
    end
  end
end
