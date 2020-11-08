# frozen_string_literal: true

require_relative 'spec_helper'

module Chess
  describe Board do
    describe '#create_board' do
      subject(:board) { described_class.new }

      before do
        board.create_board
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
  end
end
