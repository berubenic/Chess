# frozen_string_literal: true

# Translator specs
module Chess
  describe Translator do
    subject(:translator) { described_class }

    describe '#translate' do
      it 'returns a array' do
        input = 'a1'
        result = [0, 0]
        expect(translator.translate(input)).to eq(result)
      end

      it 'returns a array' do
        input = 'h8'
        result = [7, 7]
        expect(translator.translate(input)).to eq(result)
      end
    end

    describe '#valid_input?' do
      context 'when input is empty' do
        it 'returns false' do
          input = ''
          expect(translator.valid_input?(input)).to be false
        end
      end

      context 'when input is valid coordinate' do
        it 'returns true' do
          input = 'a1'
          expect(translator.valid_input?(input)).to be true
        end
      end

      context 'when input in a invalid coordinate' do
        it 'returns false' do
          input = 'a9'
          expect(translator.valid_input?(input)).to be false
        end
      end

      context 'when input is a string' do
        it 'returns true' do
          input = 's'
          expect(translator.valid_input?(input)).to be true
        end

        it 'returns true' do
          input = 'long castle'
          expect(translator.valid_input?(input)).to be true
        end

        it 'returns true' do
          input = 'short castle'
          expect(translator.valid_input?(input)).to be true
        end

        it 'returns false' do
          input = 'blah blah'
          expect(translator.valid_input?(input)).to be false
        end
      end
    end
  end
end
