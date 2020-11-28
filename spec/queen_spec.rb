# frozen_string_literal: true

# Queen

module Chess
  describe Queen do
    describe '#possible_movements' do
      context 'queen is at [0, 0]' do
        subject(:queen) { described_class.new }
        let(:array) do
          [
            [queen, '', '', '', '', '', '', ''],
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
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_movements
          expect(queen.movements).to contain_exactly([1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [0, 1],
                                                     [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0], [2, 0],
                                                     [3, 0], [4, 0], [5, 0], [6, 0], [7, 0])
        end
      end
      context 'queen is at [3, 3]' do
        subject(:queen) { described_class.new }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', queen, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        it 'assigns @movements an array of possible moves when at [3, 3]' do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [3, 3])
          queen.possible_movements
          expect(queen.movements).to contain_exactly([0, 0], [1, 1], [2, 2], [4, 4], [5, 5], [6, 6], [7, 7], [0, 6],
                                                     [1, 5], [2, 4], [4, 2], [5, 1], [6, 0], [3, 0], [3, 1], [3, 2],
                                                     [3, 4], [3, 5], [3, 6], [3, 7], [0, 3], [1, 3], [2, 3], [4, 3],
                                                     [5, 3], [6, 3], [7, 3])
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:queen) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            [queen, friendly, '', '', '', '', '', ''],
            [friendly, friendly, '', '', '', '', '', ''],
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
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, '', '', '', ''],
            ['', '', '', '', queen, '', '', ''],
            ['', '', '', friendly_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [4, 4])
          queen.possible_movements
          expect(queen.movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7], [5, 3],
                                                     [6, 2], [7, 1], [5, 5], [6, 6], [7, 7], [0, 4], [1, 4], [2, 4],
                                                     [3, 4], [5, 4], [6, 4], [7, 4])
        end
      end
      context "Multiple enemy pieces occupying it's possible moves" do
        subject(:queen) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, '', '', '', ''],
            ['', '', '', '', queen, '', '', ''],
            ['', '', '', enemy_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [4, 4])
          queen.possible_movements
          expect(queen.movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7], [5, 3],
                                                     [6, 2], [7, 1], [5, 5], [6, 6], [7, 7], [0, 4], [1, 4], [2, 4],
                                                     [3, 4], [5, 4], [6, 4], [7, 4])
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:queen) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }
        let(:friendly_3) { instance_double(Piece, color: 'black') }
        let(:friendly_4) { instance_double(Piece, color: 'black') }
        let(:friendly_5) { instance_double(Piece, color: 'black') }
        let(:friendly_6) { instance_double(Piece, color: 'black') }
        let(:friendly_7) { instance_double(Piece, color: 'black') }
        let(:friendly_8) { instance_double(Piece, color: 'black') }
        let(:friendly_9) { instance_double(Piece, color: 'black') }
        let(:friendly_10) { instance_double(Piece, color: 'black') }
        let(:friendly_11) { instance_double(Piece, color: 'black') }
        let(:friendly_12) { instance_double(Piece, color: 'black') }
        let(:friendly_13) { instance_double(Piece, color: 'black') }
        let(:friendly_14) { instance_double(Piece, color: 'black') }

        let(:array) do
          [
            [friendly_5, '', friendly_1, queen, friendly_2, friendly_14, friendly_13, friendly_12],
            [friendly_7, friendly_6, friendly_4, friendly_3, friendly_8, friendly_9, friendly_10, friendly_11],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [3, 0])
          queen.possible_movements
          expect(queen.movements.empty?).to be true
        end
      end
    end
    describe '#possible_captures' do
      context 'Board is empty except for Queen' do
        subject(:queen) { described_class.new }
        let(:array) do
          [
            [queen, '', '', '', '', '', '', ''],
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
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures.empty?).to be true
        end
      end
      context 'A enemy piece is in range' do
        subject(:queen) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [queen, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible capture" do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures).to contain_exactly([0, 3])
        end
      end
      context 'A enemy and friendly piece is in range' do
        subject(:queen) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [queen, friendly, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible capture" do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures).to contain_exactly([0, 7])
        end
      end
      context 'Two enemy pieces in range' do
        subject(:queen) { described_class.new(color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [queen, '', '', enemy_1, '', '', '', ''],
            [enemy_2, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures).to contain_exactly([3, 0], [0, 1])
        end
      end
      context 'A friendly blocks the enemy' do
        subject(:queen) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [queen, friendly, '', enemy_1, '', '', '', ''],
            [enemy_2, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          queen.instance_variable_set(:@board, board)
          queen.instance_variable_set(:@coordinate, [0, 0])
          queen.possible_captures
          expect(queen.captures).to contain_exactly([0, 1])
        end
      end
    end
  end
end
