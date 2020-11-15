# frozen_string_literal: true

module Chess
  # Pieces
  class Piece
    attr_reader :color, :current_position, :count, :symbol
    def initialize(color:, current_position:, count: 0, symbol: nil)
      @color = color
      @current_position = current_position
      @count = count
      @symbol = symbol
    end

    def update_position(coordinate)
      @current_position = coordinate
    end

    def to_s
      symbol
    end

    private

    def with_in_board?(coord)
      coord.all? { |num| num >= 0 && num <= 7 }
    end
  end

  # Pawn
  class Pawn < Piece
    def possible_movements(x = current_position[0], y = current_position[1], possibilities = [])
      if color == 'white'
        possibilities << [x, y - 1]
        possibilities << [x, y - 2] if count.zero?
      elsif color == 'black'
        possibilities << [x, y + 1]
        possibilities << [x, y + 2] if count.zero?
      end

      possibilities.keep_if { |coord| with_in_board?(coord) }
    end

    def possible_captures(x = current_position[0], y = current_position[1], possibilities = [])
      if color == 'white'
        possibilities << [x - 1, y - 1]
        possibilities << [x + 1, y - 1]
      elsif color == 'black'
        possibilities << [x - 1, y + 1]
        possibilities << [x + 1, y + 1]
      end

      possibilities.keep_if { |coord| with_in_board?(coord) }
    end
  end

  class Rook < Piece
  end

  class Bishop < Piece
  end

  # Knight
  class Knight < Piece
    private

    def possible_moves
      x = current_position[0]
      y = current_position[1]
      possibilities = [
        [x + 1, y + 2],
        [x + 1, y - 2],
        [x - 1, y + 2],
        [x - 1, y - 2],
        [x + 2, y + 1],
        [x + 2, y - 1],
        [x - 2, y + 1],
        [x - 2, y - 1]
      ]
      possibilities.keep_if { |coord| with_in_board?(coord) }
    end
  end

  class Queen < Piece
  end

  class King < Piece
  end
end
