# frozen_string_literal: true

# Knight spec

module Chess
  describe Rook do
    describe '#possible_movements' do
      context 'Board is empty except for Rook' do
        subject(:rook) { described_class.new }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [rook, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_movements
          expect(rook.movements.include?([0, 1])).to be true
          expect(rook.movements.include?([0, 2])).to be true
          expect(rook.movements.include?([0, 3])).to be true
          expect(rook.movements.include?([0, 4])).to be true
          expect(rook.movements.include?([0, 5])).to be true
          expect(rook.movements.include?([0, 6])).to be true
          expect(rook.movements.include?([0, 7])).to be true
          expect(rook.movements.include?([1, 0])).to be true
          expect(rook.movements.include?([2, 0])).to be true
          expect(rook.movements.include?([3, 0])).to be true
          expect(rook.movements.include?([4, 0])).to be true
          expect(rook.movements.include?([5, 0])).to be true
          expect(rook.movements.include?([6, 0])).to be true
          expect(rook.movements.include?([7, 0])).to be true
        end

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', rook, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [3, 3])
          rook.possible_movements
          expect(rook.movements.include?([3, 0])).to be true
          expect(rook.movements.include?([3, 1])).to be true
          expect(rook.movements.include?([3, 2])).to be true
          expect(rook.movements.include?([3, 4])).to be true
          expect(rook.movements.include?([3, 5])).to be true
          expect(rook.movements.include?([3, 6])).to be true
          expect(rook.movements.include?([3, 7])).to be true
          expect(rook.movements.include?([0, 3])).to be true
          expect(rook.movements.include?([1, 3])).to be true
          expect(rook.movements.include?([2, 3])).to be true
          expect(rook.movements.include?([4, 3])).to be true
          expect(rook.movements.include?([5, 3])).to be true
          expect(rook.movements.include?([6, 3])).to be true
          expect(rook.movements.include?([7, 3])).to be true
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:rook) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [rook, '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_movements
          expect(rook.movements.include?([1, 0])).to be true
          expect(rook.movements.include?([2, 0])).to be true
          expect(rook.movements.include?([3, 0])).to be true
          expect(rook.movements.include?([4, 0])).to be true
          expect(rook.movements.include?([5, 0])).to be true
          expect(rook.movements.include?([6, 0])).to be true
          expect(rook.movements.include?([7, 0])).to be true
          expect(rook.movements.include?([0, 1])).to be false
          expect(rook.movements.include?([0, 2])).to be false
          expect(rook.movements.include?([0, 3])).to be false
          expect(rook.movements.include?([0, 4])).to be false
          expect(rook.movements.include?([0, 5])).to be false
          expect(rook.movements.include?([0, 6])).to be false
          expect(rook.movements.include?([0, 7])).to be false
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:rook) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, rook, '', '', ''],
            ['', '', '', '', friendly_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [4, 4])
          rook.possible_movements
          expect(rook.movements.include?([4, 0])).to be true
          expect(rook.movements.include?([4, 1])).to be true
          expect(rook.movements.include?([4, 2])).to be true
          expect(rook.movements.include?([4, 3])).to be true
          expect(rook.movements.include?([5, 4])).to be true
          expect(rook.movements.include?([6, 4])).to be true
          expect(rook.movements.include?([7, 4])).to be true
          expect(rook.movements.include?([4, 5])).to be false
          expect(rook.movements.include?([4, 6])).to be false
          expect(rook.movements.include?([4, 7])).to be false
          expect(rook.movements.include?([3, 4])).to be false
          expect(rook.movements.include?([2, 4])).to be false
          expect(rook.movements.include?([1, 4])).to be false
          expect(rook.movements.include?([0, 4])).to be false
        end
      end
      context "Enemy pieces don't matter" do
        subject(:rook) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, rook, '', '', ''],
            ['', '', '', '', enemy_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [4, 4])
          rook.possible_movements
          expect(rook.movements.include?([4, 0])).to be true
          expect(rook.movements.include?([4, 1])).to be true
          expect(rook.movements.include?([4, 2])).to be true
          expect(rook.movements.include?([4, 3])).to be true
          expect(rook.movements.include?([5, 4])).to be true
          expect(rook.movements.include?([6, 4])).to be true
          expect(rook.movements.include?([7, 4])).to be true
          expect(rook.movements.include?([4, 5])).to be false
          expect(rook.movements.include?([4, 6])).to be false
          expect(rook.movements.include?([4, 7])).to be false
          expect(rook.movements.include?([3, 4])).to be false
          expect(rook.movements.include?([2, 4])).to be false
          expect(rook.movements.include?([1, 4])).to be false
          expect(rook.movements.include?([0, 4])).to be false
        end
      end
    end
  end
end
