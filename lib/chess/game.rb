# frozen_string_literal: true

require 'observer'

module Chess
  class Game
    include Observable

    def initialize(board, referee)
      @board = board
      @referee = referee
    end
  end
end
