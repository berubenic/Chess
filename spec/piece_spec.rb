# frozen_string_literal: true

# Piece spec
module Chess
  describe Piece do
    describe '#possible_movements' do
      subject(:piece) { described_class.new }

      it 'raises an error' do
        expect { piece.possible_movements }.to raise_error('Called abstract method: possible_movements')
      end
    end

    describe '#possible_captures' do
      subject(:piece) { described_class.new }

      it 'raises an error' do
        expect { piece.possible_captures }.to raise_error('Called abstract method: possible_captures')
      end
    end
  end
end
