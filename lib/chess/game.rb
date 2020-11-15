# frozen_string_literal: true

module Chess
  # Game
  class Game
    attr_reader :board, :player_one, :player_two, :move, :printer

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
      @move = nil
      @printer = printer
    end

    def prepare_game
      board.prepare_game
      player_one.prepare_game('white')
      player_two.prepare_game('black')
    end

    def game_loop
      print_ask_to_select_piece
      select_piece
      convert_move
      if valid_select?
        highlight_move
        possible_moves
        print_board
        player_one.switch_turn
        player_two.switch_turn
      else
        puts 'Invalid move, please try again'
      end
      game_loop
    end

    def select_piece(player = current_player)
      @move = player.select_piece
    end

    def select_move(player = current_player)
      @move = player.select_move
    end

    def convert_move(result = [])
      result << LETTERS.values_at(move[0])[0]
      result << move[1].to_i - 1
      @move = result
    end

    def valid_select?
      board.valid_select?(move, current_player.color)
    end

    def highlight_move
      board.highlight_move(move)
    end

    def possible_moves
      board.possible_moves(move, current_player.color)
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
