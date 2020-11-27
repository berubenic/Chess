# frozen_string_literal: false

module Chess
  describe Translator do
    describe '#translate' do
      subject(:dummy_class) { Class.new { extend Translator } }

      before do
        allow(dummy_class).to receive(:puts)
      end

      it 'returns false' do
        move = 'A20'
        expect(dummy_class.translate(move)).to be false
      end

      it 'returns false' do
        move = 'some_move123'
        expect(dummy_class.translate(move)).to be false
      end

      it 'returns [0, 1]' do
        move = 'A2'
        expect(dummy_class.translate(move)).to eq([0, 1])
      end

      it 'returns [7, 7]' do
        move = 'H8'
        expect(dummy_class.translate(move)).to eq([7, 7])
      end
    end
  end
end
