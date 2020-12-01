# frozen_string_literal: false

module Chess
  describe Translator do
    describe '#translate' do
      subject(:dummy_class) { Class.new { extend Translator } }

      it 'returns [0, 1]' do
        input = 'A2'
        expect(dummy_class.translate(input)).to eq([0, 1])
      end

      it 'returns [7, 7]' do
        input = 'H8'
        expect(dummy_class.translate(input)).to eq([7, 7])
      end

      it 'return [0, 0]' do
        input = 'a1'
        expect(dummy_class.translate(input)).to eq([0, 0])
      end
    end

    describe '#valid_input?' do
      subject(:dummy_class) { Class.new { extend Translator } }

      it 'returns true' do
        input = 'a8'
        expect(dummy_class.valid_input?(input)).to be true
      end

      it 'returns false' do
        input = 'invalid'
        expect(dummy_class.valid_input?(input)).to be false
      end

      it 'returns false' do
        input = nil
        expect(dummy_class.valid_input?(input)).to be false
      end
    end
  end
end
