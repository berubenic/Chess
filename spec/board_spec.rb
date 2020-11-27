# frozen_string_literal: true

require_relative 'spec_helper'

# Board spec
module Chess
  describe Board do
    describe '#initialize' do
      subject(:board) { described_class.new }
      it 'assigns @board an array of arrays' do
        array = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        expect(board.board).to eq(array)
      end
    end

    describe '#highlight_selection' do
      subject(:board) { described_class.new }
      let(:piece) { instance_double(Piece, coordinate: [0, 6]) }

      before do
        allow(piece).to receive(:highlight_selected)
      end

      it 'sends #highlight_selected to piece' do
        array = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [piece, '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, array)
        selection = [0, 6]
        expect(piece).to receive(:highlight_selected)
        board.highlight_selection(selection)
      end
    end
  end
end
