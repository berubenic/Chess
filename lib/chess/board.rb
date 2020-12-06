# frozen_string_literal: true

module Chess
  # Board
  class Board
    include PawnPromotion
    include InitialSetup

    attr_reader :board

    attr_accessor :board, :captured_piece

    def initialize(board: Array.new(8) { Array.new(8, '') })
      @board = board
      @captured_piece = nil
    end

    def setup_board
      setup_white_pieces
      setup_black_pieces
    end

    def find_king(player)
      board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)
          return tile if tile.is_a?(King) && tile.color == player.color
        end
      end
    end

    def find_rook(player, selection)
      x_coordinate = short_or_long_rook_x_coordinate(selection)
      board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)
          return tile if tile.is_a?(Rook) && tile.color == player.color && tile.coordinate[0] == x_coordinate
        end
      end
    end

    def short_or_long_rook_x_coordinate(selection)
      return 7 if selection == 'short castle'
      return 0 if selection == 'long castle'
    end

    def tiles_between_two_pieces(coordinate_one, coordinate_two, direction, result = [])
      current_coordinate = coordinate_one
      next_coordinate = [current_coordinate[0] + direction[0], current_coordinate[1] + direction[1]]
      return result if next_coordinate == coordinate_two

      result << find_tile(next_coordinate)

      current_coordinate = next_coordinate

      tiles_between_two_pieces(current_coordinate, coordinate_two, direction, result)
    end

    def empty_tiles_between_king_and_rook?(king, rook, direction = nil)
      if king.coordinate[0] > rook.coordinate[0]
        direction = [-1, 0]
      elsif king.coordinate[0] < rook.coordinate[0]
        direction = [1, 0]
      end
      tiles_between_two_pieces(king.coordinate, rook.coordinate, direction).all? { |tile| tile.is_a?(String) }
    end

    def tile_can_be_attacked?(coordinate, friendly_color)
      board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String) || tile.color == friendly_color

          if tile.class == Pawn
            return true if tile.can_attack_tile?(coordinate)

            next
          end
          tile.possible_movements
          return true if tile.movements.include?(coordinate)
        end
      end
      false
    end

    # placing pieces

    def execute_move(action, selection)
      piece = find_tile(selection)
      piece.update_coordinate(action)
      piece.moved_from_starting_square
      verify_pawn_moved_two_squares(piece, action, selection)
      update_piece_turn_count(piece)
      update_captured_piece(action)
      update_board(action, selection, piece)
    end

    def update_captured_piece(action)
      @captured_piece = if board[action[1]][action[0]].is_a?(String)
                          nil
                        else
                          board[action[1]][action[0]]
                        end
    end

    def update_piece_turn_count(piece)
      board.each do |row|
        row.each do |tile|
          next if tile.is_a?(String)

          if tile == piece
            piece.reset_turn_count
          else
            tile.add_turn_count
          end
        end
      end
    end

    def verify_pawn_moved_two_squares(piece, action, selection)
      return unless piece.is_a?(Pawn)

      if (selection[1] - action[1]) == 2 || (selection[1] - action[1]) == -2
        piece.moved_two_squares
      else
        piece.did_not_move_two_squares
      end
    end

    def update_board(action, selection, piece)
      board[selection[1]][selection[0]] = ''
      board[action[1]][action[0]] = piece
      return unless piece.is_a?(Pawn) && piece.en_passant_captures.include?(action)

      update_en_passant_execution(action, selection, piece)
    end

    def update_en_passant_execution(action, selection, piece)
      return if piece.en_passant_captures.nil?

      board[action[1] - 1][action[0]] = '' if selection[1] == 4

      board[action[1] + 1][action[0]] = '' if selection[1] == 3
    end

    def add_moves(moves)
      moves.each do |move|
        board[move[1]][move[0]] = 'o'.green
      end
    end

    def add_en_passant(captures)
      captures.each do |capture|
        board[capture[1]][capture[0]] = 'x'.red
      end
    end

    def add_captures(captures)
      captures.each do |capture|
        piece = board[capture[1]][capture[0]]
        piece.can_be_captured
      end
    end

    # revert and remove pieces

    def revert_move(action, selection)
      piece = board[action[1]][action[0]]
      board[selection[1]][selection[0]] = piece
      revert_captured_piece(action)
      piece.update_coordinate(selection)
      piece.has_not_moved_from_starting_square if piece.starting_coordinate == selection
    end

    def revert_captured_piece(action)
      captured_piece&.remove_can_be_captured

      board[action[1]][action[0]] = if captured_piece.nil?
                                      ''
                                    else
                                      captured_piece
                                    end
      @captured_piece = nil
    end

    def reset_captured_piece
      @captured_piece = nil
    end

    def remove_moves(moves, action)
      moves.each do |move|
        next if move == action

        board[move[1]][move[0]] = ''
      end
    end

    def remove_en_passant_capture(en_passant_captures, action)
      en_passant_captures.each do |capture|
        next if capture == action

        board[capture[1]][capture[0]] = ''
      end
    end

    def remove_captures(captures, action)
      captures.each do |capture|
        next if capture == action

        piece = board[capture[1]][capture[0]]
        piece.remove_can_be_captured
      end
    end

    # castling

    def execute_castling(selection, player)
      execute_long_castling(player) if selection == 'long castle'
      execute_short_castling(player) if selection == 'short castle'
    end

    def execute_short_castling(player)
      if player.color == 'white'
        remove_white_pieces_for_short_castling
      elsif player.color == 'black'
        remove_black_pieces_for_short_castling
      end
    end

    def execute_long_castling(player)
      if player.color == 'white'
        remove_white_pieces_for_long_castling
      elsif player.color == 'black'
        remove_black_pieces_for_long_castling
      end
    end

    def verify_pawn_promotion(player)
      if player.color == 'white'
        white_pawn_promotion
      elsif player.color == 'black'
        black_pawn_promotion
      end
    end

    def remove_white_pieces_for_short_castling
      king = board[7][4]
      rook = board[7][7]
      board[7][4] = ''
      board[7][7] = ''
      place_white_pieces_for_short_castling(king, rook)
    end

    def remove_black_pieces_for_short_castling
      king = board[0][4]
      rook = board[0][7]
      board[0][4] = ''
      board[0][7] = ''
      place_black_pieces_for_short_castling(king, rook)
    end

    def place_white_pieces_for_short_castling(king, rook)
      board[7][6] = king
      board[7][5] = rook
      king.update_coordinate([6, 7])
      rook.update_coordinate([5, 7])
    end

    def place_black_pieces_for_short_castling(king, rook)
      board[0][6] = king
      board[0][5] = rook
      king.update_coordinate([6, 0])
      rook.update_coordinate([5, 0])
    end

    def remove_white_pieces_for_long_castling
      king = board[7][4]
      rook = board[7][0]
      board[7][4] = ''
      board[7][0] = ''
      place_white_pieces_for_long_castling(king, rook)
    end

    def remove_black_pieces_for_long_castling
      king = board[0][4]
      rook = board[0][0]
      board[0][4] = ''
      board[0][0] = ''
      place_black_pieces_for_long_castling(king, rook)
    end

    def place_white_pieces_for_long_castling(king, rook)
      board[7][2] = king
      board[7][3] = rook
      king.update_coordinate([2, 7])
      rook.update_coordinate([3, 7])
    end

    def place_black_pieces_for_long_castling(king, rook)
      board[0][2] = king
      board[0][3] = rook
      king.update_coordinate([2, 0])
      rook.update_coordinate([3, 0])
    end

    def find_tile(coordinate)
      board[coordinate[1]][coordinate[0]]
    end
  end
end
