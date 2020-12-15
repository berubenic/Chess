# frozen_string_literal: true

module Chess
  describe PieceHelper do
    subject(:piece_helper) { described_class }

    describe '#coordinate_outside_of_board?' do
      context 'when coordinate is outside of board' do
        it 'returns true' do
          coordinate = [-1, 8]
          expect(piece_helper.coordinate_outside_of_board?(coordinate)).to be true
        end
      end

      context 'when coordinate it not outside of the board' do
        it 'returns false' do
          coordinate = [0, 0]
          expect(piece_helper.coordinate_outside_of_board?(coordinate)).to be false
        end
      end
    end

    describe '#add_moves_to_result' do
      it 'inserts elements into a given array' do
        moves = [[1, 2], [1, 2]]
        result = []
        expect(piece_helper.add_moves_to_result(moves, result)).to eq([[1, 2], [1, 2]])
      end
    end

    describe '#valid_move?' do
      let(:tile_helper) { TileHelper }

      context 'when both #within_board? and TileHelper#not_occupied? are true' do
        it 'returns true' do
          coordinate = [1, 1]
          array = []
          allow(piece_helper).to receive(:within_board?).with(coordinate).and_return true
          allow(tile_helper).to receive(:not_occupied?).with(coordinate, array).and_return true
          expect(piece_helper.valid_move?(coordinate, array)).to be true
        end
      end

      context 'when either #within_board? or TileHelper#not_occupied? is false' do
        it 'returns false' do
          coordinate = [1, 1]
          array = []
          allow(piece_helper).to receive(:within_board?).with(coordinate).and_return true
          allow(tile_helper).to receive(:not_occupied?).with(coordinate, array).and_return false
          expect(piece_helper.valid_move?(coordinate, array)).to be false
        end
      end
    end

    describe '#within_board?' do
      context 'when coordinate is within board' do
        it 'returns true' do
          coordinate = [0, 0]
          expect(piece_helper.within_board?(coordinate)).to be true
        end
      end

      context 'when coordinate is not within board' do
        it 'returns false' do
          coordinate = [-1, 8]
          expect(piece_helper.within_board?(coordinate)).to be false
        end
      end
    end
  end
end