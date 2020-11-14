# frozen_string_literal: true

module Chess
  # Board
  class Board
    attr_reader :cells

    def initialize(cells = nil)
      @cells = cells
    end

    def prepare_game
      create_board
      setup_board
    end

    def valid_select?(move, player_color)
      cell = retrieve_cell(move)
      verify_cell_for_move?(cell, player_color)
    end

    def highlight_move(move)
      cell = retrieve_cell(move)
      cell.toggle_highlight
    end

    private

    def verify_cell_for_move?(cell, player_color)
      return false if cell.content.nil?
      return false if cell.content.color != player_color

      true
    end

    def retrieve_cell(move)
      x = move[0]
      y = move[1]
      cells[y][x]
    end

    def create_board
      @cells = []
      (0..7).each do |y_coordinate|
        @cells << create_row(y_coordinate)
      end
    end

    def setup_board
      setup_pawns
      setup_rooks
      setup_knights
      setup_bishops
      setup_queen
      setup_king
    end

    def create_row(y_coordinate)
      row = []
      (0..7).each do |x_coordinate|
        row << Cell.new(x_coordinate: x_coordinate, y_coordinate: y_coordinate)
      end
      row
    end

    def setup_pawns
      black_row = cells[1]
      black_row.each do |cell|
        cell.create_pawn('black')
      end
      white_row = cells[6]
      white_row.each do |cell|
        cell.create_pawn('white')
      end
    end

    def setup_rooks
      black_cells = [cells[0][0], cells[0][7]]
      black_cells.each do |cell|
        cell.create_rook('black')
      end
      white_cells = [cells[7][0], cells[7][7]]
      white_cells.each do |cell|
        cell.create_rook('white')
      end
    end

    def setup_knights
      black_cells = [cells[0][1], cells[0][6]]
      black_cells.each do |cell|
        cell.create_knight('black')
      end
      white_cells = [cells[7][1], cells[7][6]]
      white_cells.each do |cell|
        cell.create_knight('white')
      end
    end

    def setup_bishops
      black_cells = [cells[0][2], cells[0][5]]
      black_cells.each do |cell|
        cell.create_bishop('black')
      end
      white_cells = [cells[7][2], cells[7][5]]
      white_cells.each do |cell|
        cell.create_bishop('white')
      end
    end

    def setup_queen
      black_cell = cells[0][4]
      black_cell.create_queen('black')
      white_cell = cells[7][4]
      white_cell.create_queen('white')
    end

    def setup_king
      black_cell = cells[0][3]
      black_cell.create_king('black')
      white_cell = cells[7][3]
      white_cell.create_king('white')
    end
  end
end
