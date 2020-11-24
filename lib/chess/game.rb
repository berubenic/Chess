# frozen_string_literal: true

module Chess
  # controls the game flow
  class Game
    include Display
    def initialize(board = Board.new)
      @board = board
      @referee = Referee.new(board: board)
    end

    Player = Struct.new(:name, :number)

    def intro
      title_message
      welcome_message
      ask_game_mode
    end
  end
end
