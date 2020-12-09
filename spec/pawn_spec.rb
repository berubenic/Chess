# frozen_string_literal: true

# Pawn spec
module Chess
  describe Pawn do
    subject(:pawn) { described_class.new(x_coordinate: 1, y_coordinate: 6, color: 'white', content: 'P') }

    describe '#all_possible_movements' do
      context 'when pawn is at starting_coordinate' do
        it 'returns result' do
          directions = [-1, -2]
          result = [[1, 5], [1, 4]]
          expect(pawn.all_possible_movements(directions)).to eq(result)
        end
      end

      context 'when pawn is not at starting_coordinate' do
        subject(:pawn) { described_class.new(x_coordinate: 1, y_coordinate: 5, color: 'white', content: 'P') }

        it 'returns result' do
          pawn.instance_variable_set(:@starting_coordinate, [1, 6])
          directions = [-1, -2]
          result = [[1, 4]]
          expect(pawn.all_possible_movements(directions)).to eq(result)
        end
      end
    end

    describe '#first_possible_move' do
      context 'when pawn is at starting_coordinate' do
        it 'returns result' do
          direction = -1
          expect(pawn.first_possible_move(direction)).to eq([[1, 5]])
        end
      end
    end

    describe '#second_possible_move' do
      it 'returns result' do
        direction = -2
        result = [[1, 5]]
        expect(pawn.second_possible_move(direction, result)).to eq([[1, 5], [1, 4]])
      end
    end

    describe '#all_possible_captures' do
      it 'returns result' do
        directions = [[1, -1], [-1, -1]]
        expect(pawn.all_possible_captures(directions)).to contain_exactly([0, 5], [2, 5])
      end
    end
  end
end
