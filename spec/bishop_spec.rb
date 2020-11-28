# frozen_string_literal: true

# Bishop

module Chess
  describe Bishop do
    describe '#possible_movements' do
      context 'bishop is at [0, 0]' do
        subject(:bishop) { described_class.new }
        let(:array) do
          [
            [bishop, '', '', '', '', '', '', ''],
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
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_movements
          expect(bishop.movements).to contain_exactly([1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7])
        end
      end
      context 'bishop is at [0, 0]' do
        subject(:bishop) { described_class.new }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', bishop, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [3, 3])
          bishop.possible_movements
          expect(bishop.movements).to contain_exactly([0, 0], [1, 1], [2, 2], [4, 4], [5, 5], [6, 6], [7, 7], [0, 6], [1, 5], [2, 4], [4, 2], [5, 1], [6, 0])
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            [bishop, '', '', '', '', '', '', ''],
            ['', friendly, '', '', '', '', '', ''],
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
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, '', '', '', ''],
            ['', '', '', '', bishop, '', '', ''],
            ['', '', '', friendly_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [4, 4])
          bishop.possible_movements
          expect(bishop.movements).to contain_exactly([5, 3], [6, 2], [7, 1], [5, 5], [6, 6], [7, 7])
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:bishop) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, '', '', '', ''],
            ['', '', '', '', bishop, '', '', ''],
            ['', '', '', enemy_2, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [4, 4])
          bishop.possible_movements
          expect(bishop.movements).to contain_exactly([5, 3], [6, 2], [7, 1], [5, 5], [6, 6], [7, 7])
        end
      end
    end
    describe '#possible_captures' do
      context 'Board is empty except for Rook' do
        subject(:bishop) { described_class.new }
        let(:array) do
          [
            [bishop, '', '', '', '', '', '', ''],
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
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_captures
          expect(bishop.captures.empty?).to be true
        end
      end
      context 'A enemy piece is in range' do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [bishop, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible capture" do
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_captures
          expect(bishop.captures).to contain_exactly([2, 2])
        end
      end
      context 'A enemy and friendly piece is in range' do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [friendly, '', '', '', '', '', '', ''],
            ['', bishop, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible capture" do
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [1, 1])
          bishop.possible_captures
          expect(bishop.captures).to contain_exactly([3, 3])
        end
      end
      context 'Four enemy pieces in range' do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }
        let(:enemy_3) { instance_double(Piece, color: 'black') }
        let(:enemy_4) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [enemy_1, '', enemy_4, '', '', '', '', ''],
            ['', bishop, '', '', '', '', '', ''],
            [enemy_3, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', enemy_2]
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [1, 1])
          bishop.possible_captures
          expect(bishop.captures).to contain_exactly([0, 0], [7, 7], [2, 0], [0, 2])
        end
      end
      context 'Four enemy pieces in range, friendly blocks one of them' do
        subject(:bishop) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }
        let(:enemy_3) { instance_double(Piece, color: 'black') }
        let(:enemy_4) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [enemy_1, '', enemy_4, '', '', '', '', ''],
            ['', bishop, '', '', '', '', '', ''],
            [enemy_3, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', friendly, ''],
            ['', '', '', '', '', '', '', enemy_2]
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [1, 1])
          bishop.possible_captures
          expect(bishop.captures).to contain_exactly([0, 0], [2, 0], [0, 2])
        end
      end
    end
  end
end
