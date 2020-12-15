# frozen_string_literal: true

# King spec
module Chess
  describe King do
    subject(:king) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'K') }

    describe '#possible_movements' do
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', king, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }

      it 'returns result' do
        king.instance_variable_set(:@board, board)
        expect(king.possible_movements).to contain_exactly([4, 3], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5], [3, 4], [3, 3])
      end
    end

    describe '#possible_captures' do
      let(:enemy) { instance_double(Piece, color: 'black') }
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', king, '', '', ''],
          ['', '', '', '', enemy, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }

      it 'returns result' do
        king.instance_variable_set(:@board, board)
        expect(king.possible_captures).to contain_exactly([4, 5])
      end
    end

    describe '#castling_coordinate' do
      context 'when white king is short castling' do
        subject(:king) { described_class.new(x_coordinate: 4, y_coordinate: 7, color: 'white', content: 'K') }

        let(:rook) { instance_double(WhiteRook, starting_coordinate: [7, 7]) }

        it 'returns an array' do
          expect(king.castling_coordinate(rook)).to eq([6, 7])
        end
      end

      context 'when white king is long castling' do
        subject(:king) { described_class.new(x_coordinate: 4, y_coordinate: 7, color: 'white', content: 'K') }

        let(:rook) { instance_double(WhiteRook, starting_coordinate: [0, 7]) }

        it 'returns an array' do
          expect(king.castling_coordinate(rook)).to eq([2, 7])
        end
      end

      context 'when black king is short castling' do
        subject(:king) { described_class.new(x_coordinate: 4, y_coordinate: 0, color: 'black', content: 'K') }

        let(:rook) { instance_double(BlackRook, starting_coordinate: [7, 0]) }

        it 'returns an array' do
          expect(king.castling_coordinate(rook)).to eq([6, 0])
        end
      end

      context 'when black king is long castling' do
        subject(:king) { described_class.new(x_coordinate: 4, y_coordinate: 0, color: 'black', content: 'K') }

        let(:rook) { instance_double(BlackRook, starting_coordinate: [0, 0]) }

        it 'returns an array' do
          expect(king.castling_coordinate(rook)).to eq([2, 0])
        end
      end
    end
  end
end
