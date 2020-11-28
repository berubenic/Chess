# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/BlockLength

# Knight spec
module Chess
  describe Knight do
    describe '#possible_movements' do
      context 'knight is at [0, 0]' do
        subject(:knight) { described_class.new }
        let(:array) do
          [
            [knight, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [0, 0])
          knight.possible_movements
          expect(knight.movements).to contain_exactly([1, 2], [2, 1])
        end
      end
      context 'knight is at [0, 0]' do
        subject(:knight) { described_class.new }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', knight, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [3, 3])
          knight.possible_movements
          expect(knight.movements).to contain_exactly([2, 1], [4, 1], [5, 2], [4, 5], [5, 4], [2, 5], [1, 4], [1, 2])
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:knight) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            [knight, '', '', '', '', '', '', ''],
            ['', '', friendly, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [0, 0])
          knight.possible_movements
          expect(knight.movements).to contain_exactly([1, 2])
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:knight) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', friendly_1, ''],
            ['', '', '', '', knight, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', friendly_2, '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [4, 4])
          knight.possible_movements
          expect(knight.movements).to contain_exactly([5, 2], [6, 5], [3, 6], [2, 5], [2, 3], [3, 2])
        end
      end
      context "Enemy pieces don't matter" do
        subject(:knight) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', enemy_1, ''],
            ['', '', '', '', knight, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', enemy_2, '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [4, 4])
          knight.possible_movements
          expect(knight.movements).to contain_exactly([5, 2], [6, 5], [3, 6], [2, 5], [2, 3], [3, 2])
        end
      end
      describe '#possible_captures' do
        context 'Board is empty except for Knight' do
          subject(:knight) { described_class.new }
          let(:array) do
            [
              [knight, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
          end
          let(:board) { instance_double(Board, board: array) }

          it 'assigns @captures an empty array' do
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures.empty?).to be true
          end
        end

        context 'A enemy piece is in range' do
          subject(:knight) { described_class.new(color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }
          let(:array) do
            [
              [knight, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', enemy, '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
          end
          let(:board) { instance_double(Board, board: array) }

          it "assigns @captures an array with it's possible capture" do
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures).to contain_exactly([1, 2])
          end
        end

        context 'A enemy and friendly piece is in range' do
          subject(:knight) { described_class.new(color: 'white') }
          let(:friendly) { instance_double(Piece, color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }
          let(:array) do
            [
              [knight, '', '', '', '', '', '', ''],
              ['', '', friendly, '', '', '', '', ''],
              ['', enemy, '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
          end
          let(:board) { instance_double(Board, board: array) }

          it "assigns @captures an array with it's possible capture" do
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures).to contain_exactly([1, 2])
          end
        end

        context 'Two enemy pieces in range' do
          subject(:knight) { described_class.new(color: 'white') }
          let(:enemy_1) { instance_double(Piece, color: 'black') }
          let(:enemy_2) { instance_double(Piece, color: 'black') }
          let(:array) do
            [
              [knight, '', '', '', '', '', '', ''],
              ['', '', enemy_1, '', '', '', '', ''],
              ['', enemy_2, '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
          end
          let(:board) { instance_double(Board, board: array) }

          it "assigns @captures an array with it's possible captures" do
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures).to contain_exactly([1, 2], [2, 1])
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
# rubocop:enable Metrics/ModuleLength
