# frozen_string_literal: true

module Chess
  # Game
  class Game
    attr_reader :board, :player_one, :player_two, :move, :printer, :selected_piece

    LETTERS = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7
    }.freeze

    def initialize(board = Board.new, player_one = Player.new(turn: true), player_two = Player.new, printer = Printer.new)
      @board = board
      @player_one = player_one
      @player_two = player_two
      @selected_piece = nil
      @move = nil
      @printer = printer
    end

    def prepare_game
      board.prepare_game
      player_one.prepare_game('white')
      player_two.prepare_game('black')
    end

    def select_piece_loop
      print_ask_to_select_piece
      select_piece
      convert_move
      if valid_select?
        highlight_selected_piece
        possible_moves
        print_board
      else
        puts 'Invalid move, please try again.'
        select_piece_loop
      end
    end

    def select_move_loop
      select_move
      if valid_move?
        execute_move
        print_board
      else
        puts 'Invalid move, please try again'
        select_move_loop
      end
    end

    def select_piece(player = current_player)
      @selected_piece = player.select_piece
    end

    def select_move(player = current_player)
      @move = player.select_move
    end

    def convert_move(result = [])
      result << LETTERS.values_at(move[0])[0]
      result << move[1].to_i - 1
      @move = result
    end

    def convert_selected_piece(result = [])
      result << LETTERS.values_at(move[0])[0]
      result << move[1].to_i - 1
      @selected_piece = result
    end

    def valid_select?
      board.valid_select?(selected_piece, current_player.color)
    end

    def valid_move?
      board.valid_move?(move)
    end

    def highlight_selected_piece
      board.highlight_selected_piece(selected_piece)
    end

    def possible_moves
      board.possible_moves(selected_piece, current_player.color)
    end

    def execute_move
      board.execute_move(move)
    end

    def print_board
      printer.print_board(board)
    end

    def print_ask_to_select_piece
      printer.select_piece(current_player.name)
    end

    private

    def current_player
      return player_one if player_one.turn == true
      return player_two if player_two.turn == true
    end
  end
end
