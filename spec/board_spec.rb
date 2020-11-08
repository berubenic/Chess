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

    describe '#setup_board' do
      subject(:board) { described_class.new }

      before do
        board.create_board
        board.setup_board
      end

      it 'black pawns are assigned to cell.content on the second row' do
        expect(board.cells[1][0].content).to be_a(Pawn)
        expect(board.cells[1][1].content).to be_a(Pawn)
        expect(board.cells[1][2].content).to be_a(Pawn)
        expect(board.cells[1][3].content).to be_a(Pawn)
        expect(board.cells[1][4].content).to be_a(Pawn)
        expect(board.cells[1][5].content).to be_a(Pawn)
        expect(board.cells[1][6].content).to be_a(Pawn)
        expect(board.cells[1][7].content).to be_a(Pawn)
      end

      it 'white pawns are assigned to cell.content on the seventh row' do
        expect(board.cells[6][0].content).to be_a(Pawn)
        expect(board.cells[6][1].content).to be_a(Pawn)
        expect(board.cells[6][2].content).to be_a(Pawn)
        expect(board.cells[6][3].content).to be_a(Pawn)
        expect(board.cells[6][4].content).to be_a(Pawn)
        expect(board.cells[6][5].content).to be_a(Pawn)
        expect(board.cells[6][6].content).to be_a(Pawn)
        expect(board.cells[6][7].content).to be_a(Pawn)
      end

      it 'black rooks are assigned to cell.content on the first row' do
        expect(board.cells[0][0].content).to be_a(Rook)
        expect(board.cells[0][7].content).to be_a(Rook)
      end

      it 'white rooks are assigned to cell.content on the eigth row' do
        expect(board.cells[7][0].content).to be_a(Rook)
        expect(board.cells[7][7].content).to be_a(Rook)
      end

      it 'black knights are assigned to cell.content on the first row' do
        expect(board.cells[0][1].content).to be_a(Knight)
        expect(board.cells[0][6].content).to be_a(Knight)
      end

      it 'white knights are assigned to cell.content on the eigth row' do
        expect(board.cells[7][1].content).to be_a(Knight)
        expect(board.cells[7][6].content).to be_a(Knight)
      end

      it 'black bishops are assigned to cell.content on the first row' do
        expect(board.cells[0][2].content).to be_a(Bishop)
        expect(board.cells[0][5].content).to be_a(Bishop)
      end

      it 'white bishops are assigned to cell.content on the eigth row' do
        expect(board.cells[7][2].content).to be_a(Bishop)
        expect(board.cells[7][5].content).to be_a(Bishop)
      end

      it 'black queen is assigned to cell.content on the first row' do
        expect(board.cells[0][4].content).to be_a(Queen)
      end

      it 'white queen is assigned to cell.content on the eigth row' do
        expect(board.cells[7][4].content).to be_a(Queen)
      end

      it 'black king is assigned to cell.content on the first row' do
        expect(board.cells[0][3].content).to be_a(King)
      end

      it 'white king is assigned to cell.content on the eigth row' do
        expect(board.cells[7][3].content).to be_a(King)
      end
    end
  end
end
