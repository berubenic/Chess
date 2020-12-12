# frozen_string_literal: true

# Knight specs
module Chess
  describe Knight do
    subject(:knight) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Kn') }

    describe '#possible_movements' do
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', knight, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns result' do
        knight.instance_variable_set(:@board, board)
        expect(knight.possible_movements).to contain_exactly([5, 2], [6, 3], [6, 5], [5, 6], [3, 6], [2, 5], [2, 3], [3, 2])
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
          ['', '', '', '', knight, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', enemy, '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns result' do
        knight.instance_variable_set(:@board, board)
        expect(knight.possible_captures).to contain_exactly([3, 6])
      end
    end
  end
end
