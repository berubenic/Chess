# frozen_string_literal: true

module Chess
  class Printer
    WHITE_PAWN = "\u2659"
    WHITE_ROOK = "\u2656"
    WHITE_KNIGHT = "\u2658"
    WHITE_BISHOP = "\u2657"
    WHITE_QUEEN = "\u2655"
    WHITE_KING = "\u2654"
    BLACK_PAWN = "\u265F"
    BLACK_ROOK = "\u265C"
    BLACK_KNIGHT = "\u265E"
    BLACK_BISHOP = "\u265D"
    BLACK_QUEEN = "\u265B"
    BLACK_KING = "\u265A"
    COLUMN_HEADER = '   A  B  C  D  E  F  G  H'

    def print_board(board)
      cells = board.cells
      puts COLUMN_HEADER
      cells.each_with_index do |x, y|
        print "#{y + 1} "
        x.each { |cell| print cell.to_s }
        print " #{y + 1}"
        print "\n"
      end
      puts COLUMN_HEADER
    end

    def select_piece(player_name)
      puts "#{player_name} select the piece you want to move. ex.[A8]"
    end
  end
end
