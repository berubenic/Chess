# frozen_string_literal: true

require_relative 'spec_helper'

# Board_spec
module Chess
  describe Board do
    describe '#prepare_game' do
      subject(:board) { described_class.new }

      before do
        board.prepare_game
      end

      it 'assigns @cells an array of array with elements being instances of Cell' do
        expect(board.cells.all? { |arr| arr.all? { |cell| cell.class == Cell } }).to be true
      end

      it 'assigns @cells an array of length 8' do
        expect(board.cells.length).to eq(8)
      end

      it 'assigns @cells an array with nested elements of length 8' do
        expect(board.cells[0].length).to eq(8)
        expect(board.cells[1].length).to eq(8)
        expect(board.cells[2].length).to eq(8)
        expect(board.cells[3].length).to eq(8)
        expect(board.cells[4].length).to eq(8)
        expect(board.cells[5].length).to eq(8)
        expect(board.cells[6].length).to eq(8)
        expect(board.cells[7].length).to eq(8)
      end
    end

    describe '#valid_select?' do
      subject(:board) { described_class.new }

      context '#verify_cell_for_move? returns true' do
        before do
          allow(board).to receive(:retrieve_cell)
          allow(board).to receive(:verify_cell_to_select?).and_return(true)
        end

        it 'returns true' do
          selected_piece = 'some_move'
          color = 'some_color'
          expect(board.valid_select?(selected_piece, color)).to be true
        end
      end

      context '#verify_cell_for_move? returns false' do
        before do
          allow(board).to receive(:retrieve_cell)
          allow(board).to receive(:verify_cell_to_select?).and_return(false)
        end

        it 'returns false' do
          selected_piece = 'some_move'
          color = 'some_color'
          expect(board.valid_select?(selected_piece, color)).to be false
        end
      end

      context '#highlight_selected_piece' do
        subject(:board) { described_class.new }
        let(:cell) { instance_double(Cell) }

        before do
          allow(board).to receive(:retrieve_cell).and_return(cell)
          allow(cell).to receive(:toggle_highlight)
        end

        it 'sends Cell #toggle_highlight' do
          selected_piece = 'some_move'
          expect(cell).to receive(:toggle_highlight)
          board.highlight_selected_piece(selected_piece)
        end
      end
    end

    describe '#possible_moves' do
      subject(:board) { described_class.new }

      before do
        board.prepare_game
      end

      it 'assigns @moves an array of possible moves' do
        selected_piece = [0, 1]
        player_color = 'black'
        board.possible_moves(selected_piece, player_color)
        expect(board.moves).to eq([[0, 2], [0, 3]])
      end

      it 'assigns @captures an array of possible captures' do
        selected_piece = [0, 1]
        player_color = 'black'
        board.possible_moves(selected_piece, player_color)
        expect(board.captures).to eq([])
      end
    end
  end
end
