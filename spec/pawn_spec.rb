# frozen_string_literal: true

# Pawn spec
module Chess
  describe Pawn do
    subject(:pawn) { described_class.new(x_coordinate: 1, y_coordinate: 6, color: 'white', content: 'P') }

    describe '#possible_movements' do
      context 'when pawn is at starting_coordinate' do
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, array: array) }

        it 'returns result' do
          pawn.instance_variable_set(:@board, board)
          directions = [-1, -2]
          result = [[1, 5], [1, 4]]
          expect(pawn.possible_movements(directions)).to eq(result)
        end
      end

      context 'when pawn is not at starting_coordinate' do
        subject(:pawn) { described_class.new(x_coordinate: 1, y_coordinate: 5, color: 'white', content: 'P') }

        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, array: array) }

        it 'returns result' do
          pawn.instance_variable_set(:@starting_coordinate, [1, 6])
          pawn.instance_variable_set(:@board, board)
          directions = [-1, -2]
          result = [[1, 4]]
          expect(pawn.possible_movements(directions)).to eq(result)
        end
      end
    end

    describe '#first_possible_move' do
      context 'when pawn is at starting_coordinate' do
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, array: array) }

        it 'returns result' do
          pawn.instance_variable_set(:@board, board)
          direction = -1
          expect(pawn.first_possible_move(direction)).to eq([[1, 5]])
        end
      end
    end

    describe '#second_possible_move' do
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', pawn, '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }

      it 'returns result' do
        pawn.instance_variable_set(:@board, board)
        direction = -2
        result = [[1, 5]]
        expect(pawn.second_possible_move(direction, result)).to eq([[1, 5], [1, 4]])
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
          ['', '', '', '', '', '', '', ''],
          [enemy, '', enemy, '', '', '', '', ''],
          ['', pawn, '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }

      it 'returns result' do
        pawn.instance_variable_set(:@board, board)
        directions = [[1, -1], [-1, -1]]
        expect(pawn.possible_captures(directions)).to contain_exactly([0, 5], [2, 5])
      end
    end
  end
end
