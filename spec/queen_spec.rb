# frozen_string_literal: true

# Queen

module Chess
  describe Queen do
    describe '#possible_movements' do
      context 'Board is empty except for Rook' do
        subject(:queen) { described_class.new }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [queen, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_movements
          expect(queen.movements.include?([1, 1])).to be true
          expect(queen.movements.include?([2, 2])).to be true
          expect(queen.movements.include?([3, 3])).to be true
          expect(queen.movements.include?([4, 4])).to be true
          expect(queen.movements.include?([5, 5])).to be true
          expect(queen.movements.include?([6, 6])).to be true
          expect(queen.movements.include?([7, 7])).to be true
          expect(queen.movements.include?([0, 1])).to be true
          expect(queen.movements.include?([0, 2])).to be true
          expect(queen.movements.include?([0, 3])).to be true
          expect(queen.movements.include?([0, 4])).to be true
          expect(queen.movements.include?([0, 5])).to be true
          expect(queen.movements.include?([0, 6])).to be true
          expect(queen.movements.include?([0, 7])).to be true
          expect(queen.movements.include?([1, 0])).to be true
          expect(queen.movements.include?([2, 0])).to be true
          expect(queen.movements.include?([3, 0])).to be true
          expect(queen.movements.include?([4, 0])).to be true
          expect(queen.movements.include?([5, 0])).to be true
          expect(queen.movements.include?([6, 0])).to be true
          expect(queen.movements.include?([7, 0])).to be true
        end
        it 'assigns @movements an array of possible moves when at [3, 3]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', queen, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [3, 3])
          queen.possible_movements
          expect(queen.movements.include?([0, 0])).to be true
          expect(queen.movements.include?([1, 1])).to be true
          expect(queen.movements.include?([2, 2])).to be true
          expect(queen.movements.include?([4, 4])).to be true
          expect(queen.movements.include?([5, 5])).to be true
          expect(queen.movements.include?([6, 6])).to be true
          expect(queen.movements.include?([7, 7])).to be true
          expect(queen.movements.include?([0, 6])).to be true
          expect(queen.movements.include?([1, 5])).to be true
          expect(queen.movements.include?([2, 4])).to be true
          expect(queen.movements.include?([4, 2])).to be true
          expect(queen.movements.include?([5, 1])).to be true
          expect(queen.movements.include?([6, 0])).to be true
          expect(queen.movements.include?([3, 0])).to be true
          expect(queen.movements.include?([3, 1])).to be true
          expect(queen.movements.include?([3, 2])).to be true
          expect(queen.movements.include?([3, 4])).to be true
          expect(queen.movements.include?([3, 5])).to be true
          expect(queen.movements.include?([3, 6])).to be true
          expect(queen.movements.include?([3, 7])).to be true
          expect(queen.movements.include?([0, 3])).to be true
          expect(queen.movements.include?([1, 3])).to be true
          expect(queen.movements.include?([2, 3])).to be true
          expect(queen.movements.include?([4, 3])).to be true
          expect(queen.movements.include?([5, 3])).to be true
          expect(queen.movements.include?([6, 3])).to be true
          expect(queen.movements.include?([7, 3])).to be true
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:queen) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [queen, friendly, '', '', '', '', '', ''],
            [friendly, friendly, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_movements
          expect(queen.movements.empty?).to be true
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:queen) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, '', '', '', ''],
            ['', '', '', '', queen, '', '', ''],
            ['', '', '', friendly_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [4, 4])
          queen.possible_movements
          expect(queen.movements.include?([4, 0])).to be true
          expect(queen.movements.include?([4, 1])).to be true
          expect(queen.movements.include?([4, 2])).to be true
          expect(queen.movements.include?([4, 3])).to be true
          expect(queen.movements.include?([4, 5])).to be true
          expect(queen.movements.include?([4, 6])).to be true
          expect(queen.movements.include?([4, 7])).to be true
          expect(queen.movements.include?([5, 3])).to be true
          expect(queen.movements.include?([6, 2])).to be true
          expect(queen.movements.include?([7, 1])).to be true
          expect(queen.movements.include?([5, 5])).to be true
          expect(queen.movements.include?([6, 6])).to be true
          expect(queen.movements.include?([7, 7])).to be true
          expect(queen.movements.include?([0, 4])).to be true
          expect(queen.movements.include?([1, 4])).to be true
          expect(queen.movements.include?([2, 4])).to be true
          expect(queen.movements.include?([3, 4])).to be true
          expect(queen.movements.include?([5, 4])).to be true
          expect(queen.movements.include?([6, 4])).to be true
          expect(queen.movements.include?([7, 4])).to be true
          expect(queen.movements.include?([3, 3])).to be false
          expect(queen.movements.include?([2, 2])).to be false
          expect(queen.movements.include?([1, 1])).to be false
          expect(queen.movements.include?([0, 0])).to be false
          expect(queen.movements.include?([3, 5])).to be false
          expect(queen.movements.include?([2, 6])).to be false
          expect(queen.movements.include?([1, 7])).to be false
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:queen) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, '', '', '', ''],
            ['', '', '', '', queen, '', '', ''],
            ['', '', '', enemy_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [4, 4])
          queen.possible_movements
          expect(queen.movements.include?([4, 0])).to be true
          expect(queen.movements.include?([4, 1])).to be true
          expect(queen.movements.include?([4, 2])).to be true
          expect(queen.movements.include?([4, 3])).to be true
          expect(queen.movements.include?([4, 5])).to be true
          expect(queen.movements.include?([4, 6])).to be true
          expect(queen.movements.include?([4, 7])).to be true
          expect(queen.movements.include?([5, 3])).to be true
          expect(queen.movements.include?([6, 2])).to be true
          expect(queen.movements.include?([7, 1])).to be true
          expect(queen.movements.include?([5, 5])).to be true
          expect(queen.movements.include?([6, 6])).to be true
          expect(queen.movements.include?([7, 7])).to be true
          expect(queen.movements.include?([0, 4])).to be true
          expect(queen.movements.include?([1, 4])).to be true
          expect(queen.movements.include?([2, 4])).to be true
          expect(queen.movements.include?([3, 4])).to be true
          expect(queen.movements.include?([5, 4])).to be true
          expect(queen.movements.include?([6, 4])).to be true
          expect(queen.movements.include?([7, 4])).to be true
          expect(queen.movements.include?([3, 3])).to be false
          expect(queen.movements.include?([2, 2])).to be false
          expect(queen.movements.include?([1, 1])).to be false
          expect(queen.movements.include?([0, 0])).to be false
          expect(queen.movements.include?([3, 5])).to be false
          expect(queen.movements.include?([2, 6])).to be false
          expect(queen.movements.include?([1, 7])).to be false
        end
      end
    end
    describe '#possible_captures' do
      context 'Board is empty except for Queen' do
        subject(:queen) { described_class.new }

        it 'assigns @captures an empty array' do
          board = [
            [queen, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures.empty?).to be true
        end
      end
      context 'A enemy piece is in range' do
        subject(:queen) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }

        it "assigns @captures an array with it's possible capture" do
          board = [
            [queen, '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures).to eq([[0, 1]])
        end
      end
      context 'A enemy and friendly piece is in range' do
        subject(:queen) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }

        it "assigns @captures an array with it's possible capture" do
          board = [
            [queen, friendly, '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures).to eq([[0, 1]])
        end
      end
      context 'Two enemy pieces in range' do
        subject(:queen) { described_class.new(color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }

        it "assigns @captures an array with it's possible captures" do
          board = [
            [queen, enemy_1, '', '', '', '', '', ''],
            [enemy_2, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures.include?([1, 0])).to be true
          expect(queen.captures.include?([0, 1])).to be true
        end
      end
    end
  end
end
