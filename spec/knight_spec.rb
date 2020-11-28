# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/BlockLength

# Knight spec
module Chess
  xdescribe Knight do
    describe '#possible_movements' do
      context 'Board is empty except for Knight' do
        subject(:knight) { described_class.new }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [knight, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [0, 0])
          knight.possible_movements
          expect(knight.movements.include?([1, 2])).to be true
          expect(knight.movements.include?([2, 1])).to be true
        end

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', knight, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [3, 3])
          knight.possible_movements
          expect(knight.movements.include?([2, 1])).to be true
          expect(knight.movements.include?([4, 1])).to be true
          expect(knight.movements.include?([5, 2])).to be true
          expect(knight.movements.include?([4, 5])).to be true
          expect(knight.movements.include?([5, 4])).to be true
          expect(knight.movements.include?([2, 5])).to be true
          expect(knight.movements.include?([1, 4])).to be true
          expect(knight.movements.include?([1, 2])).to be true
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:knight) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [knight, '', '', '', '', '', '', ''],
            ['', '', friendly, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [0, 0])
          knight.possible_movements
          expect(knight.movements.include?([1, 2])).to be true
          expect(knight.movements.include?([2, 1])).to be false
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:knight) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', friendly_1, ''],
            ['', '', '', '', knight, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', friendly_2, '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [4, 4])
          knight.possible_movements
          expect(knight.movements.include?([5, 2])).to be true
          expect(knight.movements.include?([6, 5])).to be true
          expect(knight.movements.include?([3, 6])).to be true
          expect(knight.movements.include?([2, 5])).to be true
          expect(knight.movements.include?([2, 3])).to be true
          expect(knight.movements.include?([3, 2])).to be true
          expect(knight.movements.include?([6, 3])).to be false
          expect(knight.movements.include?([5, 6])).to be false
        end
      end
      context "Enemy pieces don't matter" do
        subject(:knight) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', enemy_1, ''],
            ['', '', '', '', knight, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', enemy_2, '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          knight.instance_variable_set(:@board, board)
          knight.instance_variable_set(:@coordinate, [4, 4])
          knight.possible_movements
          expect(knight.movements.include?([5, 2])).to be true
          expect(knight.movements.include?([6, 5])).to be true
          expect(knight.movements.include?([3, 6])).to be true
          expect(knight.movements.include?([2, 5])).to be true
          expect(knight.movements.include?([2, 3])).to be true
          expect(knight.movements.include?([3, 2])).to be true
          expect(knight.movements.include?([6, 3])).to be false
          expect(knight.movements.include?([5, 6])).to be false
        end
      end
      describe '#possible_captures' do
        context 'Board is empty except for Knight' do
          subject(:knight) { described_class.new }

          it 'assigns @captures an empty array' do
            board = [
              [knight, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures.empty?).to be true
          end
        end

        context 'A enemy piece is in range' do
          subject(:knight) { described_class.new(color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }

          it "assigns @captures an array with it's possible capture" do
            board = [
              [knight, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', enemy, '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures).to eq([[1, 2]])
          end
        end

        context 'A enemy and friendly piece is in range' do
          subject(:knight) { described_class.new(color: 'white') }
          let(:friendly) { instance_double(Piece, color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }

          it "assigns @captures an array with it's possible capture" do
            board = [
              [knight, '', '', '', '', '', '', ''],
              ['', '', friendly, '', '', '', '', ''],
              ['', enemy, '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures).to eq([[1, 2]])
          end
        end

        context 'Two enemy pieces in range' do
          subject(:knight) { described_class.new(color: 'white') }
          let(:enemy_1) { instance_double(Piece, color: 'black') }
          let(:enemy_2) { instance_double(Piece, color: 'black') }

          it "assigns @captures an array with it's possible captures" do
            board = [
              [knight, '', '', '', '', '', '', ''],
              ['', '', enemy_1, '', '', '', '', ''],
              ['', enemy_2, '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_captures
            expect(knight.captures.include?([1, 2])).to be true
            expect(knight.captures.include?([2, 1])).to be true
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
# rubocop:enable Metrics/ModuleLength
