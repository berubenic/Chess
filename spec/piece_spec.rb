# frozen_string_literal: true

# Piece specs
module Chess
  describe Piece do
    subject(:piece) { described_class.new(x_coordinate: 0, y_coordinate: 0, color: 'white', content: 'some_unicode') }

    describe '#belongs_to_player?' do
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

    describe '#moved_from_initial_coordinate?' do
      context 'when starting_coordinate is the same as current_coordinate' do
        it 'returns false' do
          expect(piece.moved_from_initial_coordinate?).to be false
        end
      end

      context 'when starting_coordinate is not the same as current_coordinate' do
        it 'returns true' do
          piece.instance_variable_set(:@current_coordinate, [1, 1])
          expect(piece.moved_from_initial_coordinate?).to be true
        end
      end
    end

    describe '#can_not_move_or_capture?' do
      context 'when both possible_movements and possible_captures return empty array' do
        before do
          allow(piece).to receive(:possible_movements).and_return([])
          allow(piece).to receive(:possible_captures).and_return([])
        end

        it 'returns true' do
          expect(piece.can_not_move_or_capture?).to be true
        end
      end

      context 'when either possible_movements or possible_captures return an array that is not empty' do
        before do
          allow(piece).to receive(:possible_movements).and_return([])
          allow(piece).to receive(:possible_captures).and_return([[1, 1]])
        end

        it 'returns false' do
          expect(piece.can_not_move_or_capture?).to be false
        end
      end
    end

    describe '#can_be_captured' do
      it 'assigns @capturable true' do
        expect { piece.can_be_captured }.to change { piece.capturable }.from(false).to(true)
      end
    end

    describe '#possible_movements' do
      subject(:piece) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Q') }

      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', piece, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }
      let(:directions) { [[1, -1], [1, 1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]] }

      it 'returns result' do
        piece.instance_variable_set(:@board, board)
        expect(piece.possible_movements(directions)).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
                                                                        [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4],
                                                                        [0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
                                                                        [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1])
      end
    end

    describe '#possible_captures' do
      subject(:piece) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Q') }

      let(:enemy) { instance_double(Piece, color: 'black') }
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [enemy, '', '', '', piece, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }
      let(:directions) { [[1, -1], [1, 1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]] }

      it 'returns result' do
        piece.instance_variable_set(:@board, board)
        expect(piece.possible_captures(directions)).to contain_exactly([0, 4])
      end
    end

    describe '#directional_movements' do
      subject(:piece) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Q') }

      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', piece, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, array: array) }

      it 'returns arrays up to y_coordinate 7' do
        piece.instance_variable_set(:@board, board)
        direction = [0, 1]
        expect(piece.directional_movements(direction)).to contain_exactly([4, 5], [4, 6], [4, 7])
      end
    end

    describe '#directional_captures' do
      subject(:piece) { described_class.new(x_coordinate: 4, y_coordinate: 4, color: 'white', content: 'Q') }

      context 'when the enemy is capturable' do
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', piece, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, array: array) }

        it 'returns the enemy coordinate' do
          piece.instance_variable_set(:@board, board)
          direction = [-1, 0]
          expect(piece.directional_captures(direction)).to eq([0, 4])
        end
      end

      context 'when a friendly blocks the enemy' do
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', friendly, '', piece, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, array: array) }

        it 'returns an empty array' do
          piece.instance_variable_set(:@board, board)
          direction = [-1, 0]
          expect(piece.directional_captures(direction)).to eq([])
        end
      end
    end
  end
end
