# frozen_string_literal: true

# Bishop spec
module Chess
  describe Bishop do
    subject(:bishop) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'B') }

    describe '#possible_movements' do
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', bishop, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }

      it 'returns result' do
        bishop.instance_variable_set(:@board, board)
        expect(bishop.possible_movements).to contain_exactly([0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
                                                             [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1])
      end
    end

    describe '#possible_captures' do
      let(:enemy) { instance_double(Piece, color: 'black') }
      let(:array) do
        [
          [enemy, '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', bishop, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }

      it 'returns result' do
        bishop.instance_variable_set(:@board, board)
        expect(bishop.possible_captures).to contain_exactly([0, 0])
      end
    end
  end
end
