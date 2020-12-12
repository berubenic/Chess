# frozen_string_literal: true

# Queen spec
module Chess
  describe Queen do
    subject(:queen) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Q') }

    describe '#possible_movements' do
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', queen, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns result' do
        queen.instance_variable_set(:@board, board)
        expect(queen.possible_movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
                                                            [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4],
                                                            [0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
                                                            [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1])
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
          [enemy, '', '', '', queen, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns result' do
        queen.instance_variable_set(:@board, board)
        expect(queen.possible_captures).to contain_exactly([0, 4])
      end
    end
  end
end
