# frozen_string_literal: true

require_relative 'spec_helper'

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
  end
end
