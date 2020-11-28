# frozen_string_literal: true

module Chess
  # controls the game flow
  class Game
    include Display
    include Translator

    attr_reader :board, :player_one, :player_two, :current_player, :referee, :selection, :movements, :captures

    def initialize(board = Board.new)
      @board = board
      @referee = Referee.new(board: board)
      @player_one = nil
      @player_two = nil
      @current_player = nil
      @selection = nil
      @movements = nil
      @captures = nil
    end

    Player = Struct.new(:name, :color)

    def intro
      title_message
      welcome_message
      two_player_mode if ask_game_mode == 2
    end

    def two_player_mode
      setup_two_player_game
      player_selection_loop
    end

    def setup_two_player_game
      setup_two_players
      setup_board
      display_board(board.board)
    end

    def setup_two_players
      create_player_one
      create_player_two
    end

    def setup_board
      board.setup_board
    end

    def player_selection_loop
      select_piece
      translate_piece
      invalid_input if selection == false

      return if referee.valid_selection?(selection, current_player)

      invalid_selection
    end

    def invalid_input
      invalid_input_message
      revert_selection
      display_board(board.board)
      player_selection_loop
    end

    def invalid_selection
      invalid_selection_message
      revert_selection
      display_board(board.board)
      player_selection_loop
    end

    # def select_piece_loop
    #  select_piece
    #  translate_piece
    #  # piece can't be translated
    #  if selection == false
    #    invalid_input_message
    #    revert_selection
    #    display_board(board.board)
    #    return select_piece_loop
    #  end
    #
    #  return true if referee.valid_selection?(selection, current_player.color)
    #
    #  invalid_selection_message
    #  revert_selection
    #  display_board(board.board)
    #  select_piece_loop
    # end

    # def two_player_mode
    #  setup_two_players
    #  setup_board
    #  display_board(board.board)
    #  @current_player = player_one
    #  select_piece_loop
    #  board.highlight_selection(selection)
    #  display_board(board.board)
    #  find_movements_and_captures
    #  display_board(board.board)
    # end

    # def find_movements_and_captures
    #  piece = board.find_tile(selection)
    #  @movements = piece.possible_movements
    #  @captures = piece.possible_captures
    #  if movements.empty? && captures.empty?
    #    no_movements_or_captures_message
    #    board.revert_highlight(selection)
    #    revert_selection
    #    return select_piece_loop
    #  end
    #  board.add_moves(movements)
    # end

    # def setup_two_players
    #  create_player_one
    #  create_player_two
    # end

    # def setup_board
    #  board.setup_board
    # end

    def select_piece
      @selection = ask_to_select_piece(current_player)
    end

    def translate_piece
      @selection = translate(selection)
    end

    def revert_selection
      @selection = nil
    end

    def create_player_one
      color = 'white'
      name = ask_player_name('Player one')
      welcome_player_message(name, color)
      @player_one = Player.new(name, color)
      @current_player = player_one
    end

    def create_player_two
      color = 'black'
      name = ask_player_name('Player two')
      welcome_player_message(name, color)
      @player_two = Player.new(name, color)
    end
  end
end
