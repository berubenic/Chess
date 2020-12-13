# frozen_string_literal: true

# King spec
module Chess
  describe King do
    subject(:king) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'K') }

    describe '#possible_movements' do
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', king, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns result' do
        king.instance_variable_set(:@board, board)
        expect(king.possible_movements).to contain_exactly([4, 3], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5], [3, 4], [3, 3])
      end
    end

    describe '#possible_captures' do
      let(:enemy) { instance_double(Piece, color: 'black') }
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', king, '', '', ''],
          ['', '', '', '', enemy, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns result' do
        king.instance_variable_set(:@board, board)
        expect(king.possible_captures).to contain_exactly([4, 5])
      end
    end
  end
end
