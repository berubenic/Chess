# frozen_string_literal: true

# Knight specs
module Chess
  describe Knight do
    subject(:knight) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Kn') }

    describe '#all_possible_movements' do
      it 'returns result' do
        expect(knight.all_possible_movements).to contain_exactly([5, 2], [6, 3], [6, 5], [5, 6], [3, 6], [2, 5], [2, 3], [3, 2])
      end
    end

    describe '#all_possible_captures' do
      it 'returns result' do
        expect(knight.all_possible_captures).to contain_exactly([5, 2], [6, 3], [6, 5], [5, 6], [3, 6], [2, 5], [2, 3], [3, 2])
      end
    end
  end
end
