# frozen_string_literal: true

# Knight spec
module Chess
  describe King do
    describe '#possible_movements' do
      context 'Board is empty except for Knight' do
        subject(:king) { described_class.new }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [king, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [0, 0])
          king.possible_movements
          expect(king.movements.include?([1, 0])).to be true
          expect(king.movements.include?([1, 1])).to be true
          expect(king.movements.include?([0, 1])).to be true
        end

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', king, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [3, 3])
          king.possible_movements
          expect(king.movements.include?([3, 2])).to be true
          expect(king.movements.include?([4, 2])).to be true
          expect(king.movements.include?([4, 3])).to be true
          expect(king.movements.include?([4, 4])).to be true
          expect(king.movements.include?([3, 4])).to be true
          expect(king.movements.include?([2, 4])).to be true
          expect(king.movements.include?([2, 3])).to be true
          expect(king.movements.include?([2, 2])).to be true
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:king) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [king, '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [0, 0])
          king.possible_movements
          expect(king.movements.include?([1, 0])).to be true
          expect(king.movements.include?([1, 1])).to be true
          expect(king.movements.include?([0, 1])).to be false
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:king) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, king, '', '', ''],
            ['', '', '', '', friendly_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [4, 4])
          king.possible_movements
          expect(king.movements.include?([3, 3])).to be true
          expect(king.movements.include?([4, 3])).to be true
          expect(king.movements.include?([5, 3])).to be true
          expect(king.movements.include?([5, 4])).to be true
          expect(king.movements.include?([5, 5])).to be true
          expect(king.movements.include?([3, 5])).to be true
          expect(king.movements.include?([4, 5])).to be false
          expect(king.movements.include?([3, 4])).to be false
        end
      end
      context "Enemy pieces don't matter" do
        subject(:king) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, king, '', '', ''],
            ['', '', '', '', enemy_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [4, 4])
          king.possible_movements
          expect(king.movements.include?([3, 3])).to be true
          expect(king.movements.include?([4, 3])).to be true
          expect(king.movements.include?([5, 3])).to be true
          expect(king.movements.include?([5, 4])).to be true
          expect(king.movements.include?([5, 5])).to be true
          expect(king.movements.include?([3, 5])).to be true
          expect(king.movements.include?([4, 5])).to be false
          expect(king.movements.include?([3, 4])).to be false
        end
      end
      describe '#possible_captures' do
        context 'Board is empty except for King' do
          subject(:king) { described_class.new }

          it 'assigns @captures an empty array' do
            board = [
              [king, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures.empty?).to be true
          end
        end
        context 'A enemy piece is in range' do
          subject(:king) { described_class.new(color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }

          it "assigns @captures an array with it's possible capture" do
            board = [
              [king, '', '', '', '', '', '', ''],
              [enemy, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures).to eq([[0, 1]])
          end
        end
        context 'A enemy and friendly piece is in range' do
          subject(:king) { described_class.new(color: 'white') }
          let(:friendly) { instance_double(Piece, color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }

          it "assigns @captures an array with it's possible capture" do
            board = [
              [king, friendly, '', '', '', '', '', ''],
              [enemy, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures).to eq([[0, 1]])
          end
        end
        context 'Two enemy pieces in range' do
          subject(:king) { described_class.new(color: 'white') }
          let(:enemy_1) { instance_double(Piece, color: 'black') }
          let(:enemy_2) { instance_double(Piece, color: 'black') }

          it "assigns @captures an array with it's possible captures" do
            board = [
              [king, enemy_1, '', '', '', '', '', ''],
              [enemy_2, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures.include?([1, 0])).to be true
            expect(king.captures.include?([0, 1])).to be true
          end
        end
      end
    end
  end
end
