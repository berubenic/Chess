# frozen_string_literal: true

# King spec
module Chess
  describe King do
    subject(:king) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'K') }

    describe '#all_possible_movements' do
      it 'returns result' do
        expect(king.all_possible_movements).to contain_exactly([4, 3], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5], [3, 4], [3, 3])
      end
    end
    describe '#all_possible_captures' do
      it 'returns result' do
        expect(king.all_possible_captures).to contain_exactly([4, 3], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5], [3, 4], [3, 3])
      end
    end
  end
end
