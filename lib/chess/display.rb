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

    def primary_color_tile(tile)
      pastel = Pastel.new
      print pastel.on_bright_white(" #{print_tile(tile)} ")
    end

    def secondary_color_tile(tile)
      pastel = Pastel.new
      print pastel.on_cyan(" #{print_tile(tile)} ")
    end

    def print_tile(tile)
      if tile == ''
        ' '
      elsif tile == 'o' || tile == 'x'
        tile
      else
        print_piece(tile)
      end
    end

    def print_piece(tile, _color = tile.color, piece = tile.content)
      pastel = Pastel.new
      pastel.black.bold(piece)
    end
  end
end
