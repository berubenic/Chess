# frozen_string_literal: true

# Piece specs
module Chess
  describe Piece do
    describe '#belongs_to_player?' do
      subject(:piece) { described_class.new(x_coordinate: 0, y_coordinate: 0, color: 'white', content: 'some_unicode') }

      context 'when player_color is the same as piece color' do
        let(:player) { double('Player', color: 'white') }

        it 'returns true' do
          player_color = player.color
          expect(piece.belongs_to_player?(player_color)).to be true
        end
      end

      context 'when player_color is not the same as piece color' do
        let(:player) { double('Player', color: 'black') }

        it 'returns false' do
          player_color = player.color
          expect(piece.belongs_to_player?(player_color)).to be false
        end
      end
    end

    describe '#moved_from_starting_coordinate?' do
      subject(:piece) { described_class.new(x_coordinate: 0, y_coordinate: 0, color: 'white', content: 'some_unicode') }

      context 'when starting_coordinate is the same as current_coordinate' do
        it 'returns false' do
          expect(piece.moved_from_starting_coordinate?).to be false
        end
      end

      context 'when starting_coordinate is not the same as current_coordinate' do
        it 'returns true' do
          piece.instance_variable_set(:@current_coordinate, [1, 1])
          expect(piece.moved_from_starting_coordinate?).to be true
        end
      end
    end
  end
end
