# frozen_string_literal: true

module Chess
  # controls the game flow
  class Game
    include Display
    attr_reader :board
    def initialize(board = Board.new)
      @board = board
      @referee = Referee.new(board: board)
    end

    Player = Struct.new(:name, :number)

    def intro
      title_message
      welcome_message
      ask_game_mode
      display_board(board.board)
    end
  end
end
