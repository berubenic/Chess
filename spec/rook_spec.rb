# frozen_string_literal: true

# Rook spec
module Chess
  describe Rook do
    subject(:rook) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'R') }

    describe '#possible_movements' do
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', rook, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns result' do
        rook.instance_variable_set(:@board, board)
        expect(rook.possible_movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
                                                           [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4])
      end
    end

    describe '#directional_movements' do
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', rook, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end

      it 'returns arrays up to y_coordinate 7' do
        rook.instance_variable_set(:@board, board)
        direction = [0, 1]
        expect(rook.directional_movements(direction)).to contain_exactly([4, 5], [4, 6], [4, 7])
      end
    end

    describe '#directional_captures' do
      context 'when the enemy is capturable' do
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:board) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', rook, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns the enemy coordinate' do
          rook.instance_variable_set(:@board, board)
          direction = [-1, 0]
          expect(rook.directional_captures(direction)).to eq([0, 4])
        end
      end

      context 'when a friendly blocks the enemy' do
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:board) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', friendly, '', rook, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns an empty array' do
          rook.instance_variable_set(:@board, board)
          direction = [-1, 0]
          expect(rook.directional_captures(direction)).to eq([])
        end
      end
    end

    describe '#possible_captures' do
      let(:enemy) { instance_double(Piece, color: 'black') }
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', rook, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', enemy, '', '', '']
        ]
      end

      it 'returns result' do
        rook.instance_variable_set(:@board, board)
        expect(rook.possible_captures).to contain_exactly([4, 7])
      end
    end
  end
end
