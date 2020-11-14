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
          allow(board).to receive(:verify_cell_for_move?).and_return(true)
        end

        it 'returns true' do
          move = 'some_move'
          color = 'some_color'
          expect(board.valid_select?(move, color)).to be true
        end
      end

      context '#verify_cell_for_move? returns false' do
        before do
          allow(board).to receive(:retrieve_cell)
          allow(board).to receive(:verify_cell_for_move?).and_return(false)
        end

        it 'returns false' do
          move = 'some_move'
          color = 'some_color'
          expect(board.valid_select?(move, color)).to be false
        end
      end
    end
  end
end
