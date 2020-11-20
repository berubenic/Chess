# frozen_string_literal: true

# Bishop

module Chess
  describe Bishop do
    describe '#possible_movements' do
      context 'Board is empty except for bishop' do
        subject(:bishop) { described_class.new }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [bishop, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_movements
          expect(bishop.movements.include?([1, 1])).to be true
          expect(bishop.movements.include?([2, 2])).to be true
          expect(bishop.movements.include?([3, 3])).to be true
          expect(bishop.movements.include?([4, 4])).to be true
          expect(bishop.movements.include?([5, 5])).to be true
          expect(bishop.movements.include?([6, 6])).to be true
          expect(bishop.movements.include?([7, 7])).to be true
        end

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', bishop, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [3, 3])
          bishop.possible_movements
          expect(bishop.movements.include?([0, 0])).to be true
          expect(bishop.movements.include?([1, 1])).to be true
          expect(bishop.movements.include?([2, 2])).to be true
          expect(bishop.movements.include?([4, 4])).to be true
          expect(bishop.movements.include?([5, 5])).to be true
          expect(bishop.movements.include?([6, 6])).to be true
          expect(bishop.movements.include?([7, 7])).to be true
          expect(bishop.movements.include?([0, 6])).to be true
          expect(bishop.movements.include?([1, 5])).to be true
          expect(bishop.movements.include?([2, 4])).to be true
          expect(bishop.movements.include?([4, 2])).to be true
          expect(bishop.movements.include?([5, 1])).to be true
          expect(bishop.movements.include?([6, 0])).to be true
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [bishop, '', '', '', '', '', '', ''],
            ['', friendly, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_movements
          expect(bishop.movements.empty?).to be true
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:bishop) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, '', '', '', ''],
            ['', '', '', '', bishop, '', '', ''],
            ['', '', '', friendly_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [4, 4])
          bishop.possible_movements
          expect(bishop.movements.include?([5, 3])).to be true
          expect(bishop.movements.include?([6, 2])).to be true
          expect(bishop.movements.include?([7, 1])).to be true
          expect(bishop.movements.include?([5, 5])).to be true
          expect(bishop.movements.include?([6, 6])).to be true
          expect(bishop.movements.include?([7, 7])).to be true
          expect(bishop.movements.include?([3, 3])).to be false
          expect(bishop.movements.include?([2, 2])).to be false
          expect(bishop.movements.include?([1, 1])).to be false
          expect(bishop.movements.include?([0, 0])).to be false
          expect(bishop.movements.include?([3, 5])).to be false
          expect(bishop.movements.include?([2, 6])).to be false
          expect(bishop.movements.include?([1, 7])).to be false
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:bishop) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, '', '', '', ''],
            ['', '', '', '', bishop, '', '', ''],
            ['', '', '', enemy_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [4, 4])
          bishop.possible_movements
          expect(bishop.movements.include?([5, 3])).to be true
          expect(bishop.movements.include?([6, 2])).to be true
          expect(bishop.movements.include?([7, 1])).to be true
          expect(bishop.movements.include?([5, 5])).to be true
          expect(bishop.movements.include?([6, 6])).to be true
          expect(bishop.movements.include?([7, 7])).to be true
          expect(bishop.movements.include?([3, 3])).to be false
          expect(bishop.movements.include?([2, 2])).to be false
          expect(bishop.movements.include?([1, 1])).to be false
          expect(bishop.movements.include?([0, 0])).to be false
          expect(bishop.movements.include?([3, 5])).to be false
          expect(bishop.movements.include?([2, 6])).to be false
          expect(bishop.movements.include?([1, 7])).to be false
        end
      end
    end
    describe '#possible_captures' do
      context 'Board is empty except for Rook' do
        subject(:bishop) { described_class.new }

        it 'assigns @captures an empty array' do
          board = [
            [bishop, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_captures
          expect(bishop.captures.empty?).to be true
        end
      end
      context 'A enemy piece is in range' do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }

        it "assigns @captures an array with it's possible capture" do
          board = [
            [bishop, '', '', '', '', '', '', ''],
            ['', enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_captures
          expect(bishop.captures).to eq([[1, 1]])
        end
      end
      context 'A enemy and friendly piece is in range' do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }

        it "assigns @captures an array with it's possible capture" do
          board = [
            [friendly, '', '', '', '', '', '', ''],
            ['', bishop, '', '', '', '', '', ''],
            ['', '', enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [1, 1])
          bishop.possible_captures
          expect(bishop.captures).to eq([[2, 2]])
        end
      end
      context 'Two enemy pieces in range' do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }

        it "assigns @captures an array with it's possible captures" do
          board = [
            [enemy_1, '', '', '', '', '', '', ''],
            ['', bishop, '', '', '', '', '', ''],
            ['', '', enemy_2, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [1, 1])
          bishop.possible_captures
          expect(bishop.captures.include?([0, 0])).to be true
          expect(bishop.captures.include?([2, 2])).to be true
        end
      end
    end
  end
end
