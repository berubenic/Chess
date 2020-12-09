# frozen_string_literal: true

# Rook spec
module Chess
  describe Rook do
    subject(:rook) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'R') }

    describe '#all_possible_movements' do
      it 'returns result' do
        expect(rook.all_possible_movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
                                                               [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4])
      end
    end

    describe '#directional_movements' do
      it 'returns arrays up to y_coordinate 7' do
        direction = [0, 1]
        expect(rook.directional_movements(direction)).to contain_exactly([4, 5], [4, 6], [4, 7])
      end
    end

    describe '#all_possible_captures' do
      it 'returns result' do
        expect(rook.all_possible_captures).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
                                                              [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4])
      end
    end
  end
end
