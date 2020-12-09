# frozen_string_literal: true

# Bishop spec
module Chess
  describe Bishop do
    subject(:bishop) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'B') }

    describe '#all_possible_movements' do
      it 'returns result' do
        expect(bishop.all_possible_movements).to contain_exactly([0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
                                                                 [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1])
      end
    end
    describe '#directional_movements' do
      it 'returns arrays up to y_coordinate 7' do
        direction = [0, 1]
        expect(bishop.directional_movements(direction)).to contain_exactly([4, 5], [4, 6], [4, 7])
      end
    end
    describe '#all_possible_captures' do
      it 'returns result' do
        expect(bishop.all_possible_captures).to contain_exactly([0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
                                                                [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1])
      end
    end
  end
end
