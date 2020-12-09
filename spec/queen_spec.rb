# frozen_string_literal: true

# Queen spec
module Chess
  describe Queen do
    subject(:queen) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Q') }

    describe '#all_possible_movements' do
      it 'returns result' do
        expect(queen.all_possible_movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
                                                                [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4],
                                                                [0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
                                                                [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1])
      end
    end

    describe '#directional_movements' do
      it 'returns arrays up to y_coordinate 7' do
        direction = [0, 1]
        expect(queen.directional_movements(direction)).to contain_exactly([4, 5], [4, 6], [4, 7])
      end
    end

    describe '#all_possible_captures' do
      it 'returns result' do
        expect(queen.all_possible_captures).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
                                                               [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4],
                                                               [0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
                                                               [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1])
      end
    end
  end
end
