# frozen_string_literal: true

# Pawn spec
module Chess
  describe Pawn do
    describe '#first_possible_move' do
      context 'pawn is at starting_coordinate' do
        subject(:pawn) { described_class.new(x_coordinate: 1, y_coordinate: 6, color: 'white', content: 'P') }
        it 'returns result' do
          direction = [-1, -2]
          expect(pawn.first_possible_move(direction)).to eq([[1, 5]])
        end
      end
      context 'pawn is not at starting_coordinate' do
        subject(:pawn) { described_class.new(x_coordinate: 1, y_coordinate: 5, color: 'white', content: 'P') }
        it 'sends #second_possible_move to self' do
          pawn.instance_variable_set(:@starting_coordinate, [1, 6])
          direction = [-1, -2]
          expect(pawn).to receive(:second_possible_move).with(direction, kind_of(Array))
          pawn.first_possible_move(direction)
        end
      end
    end
    describe '#second_possible_move' do
      subject(:pawn) { described_class.new(x_coordinate: 1, y_coordinate: 6, color: 'white', content: 'P') }
      it 'returns result' do
        direction = [-1, -2]
        result = [[1, 5]]
        expect(pawn.second_possible_move(direction, result)).to eq([[1, 5], [1, 4]])
      end
    end
  end
end
