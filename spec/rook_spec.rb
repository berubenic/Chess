# frozen_string_literal: true

# Knight spec

module Chess
  describe Rook do
    describe '#possible_movements' do
      context 'rook is at [0, 0]' do
        subject(:rook) { described_class.new }
        let(:array) do
          [
            [rook, '', '', '', '', '', '', ''],
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
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_movements
          expect(rook.movements).to contain_exactly([0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0],
                                                    [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0])
        end
      end
      context 'rook is at [3, 3]' do
        subject(:rook) { described_class.new }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', rook, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [3, 3])
          rook.possible_movements
          expect(rook.movements).to contain_exactly([3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7], [0, 3],
                                                    [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3])
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:rook) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            [rook, '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
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
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_movements
          expect(rook.movements).to contain_exactly([1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0])
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:rook) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, rook, '', '', ''],
            ['', '', '', '', friendly_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [4, 4])
          rook.possible_movements
          expect(rook.movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [5, 4], [6, 4], [7, 4])
        end
      end
      context "Enemy pieces don't matter" do
        subject(:rook) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, rook, '', '', ''],
            ['', '', '', '', enemy_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [4, 4])
          rook.possible_movements
          expect(rook.movements).to contain_exactly([4, 0], [4, 1], [4, 2], [4, 3], [5, 4], [6, 4], [7, 4])
        end
      end
    end
    describe '#possible_captures' do
      context 'Board is empty except for Rook' do
        subject(:rook) { described_class.new }
        let(:array) do
          [
            [rook, '', '', '', '', '', '', ''],
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
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_captures
          expect(rook.captures.empty?).to be true
        end
      end
      context 'A enemy piece is in range' do
        subject(:rook) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [rook, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible capture" do
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_captures
          expect(rook.captures).to contain_exactly([0, 2])
        end
      end
      context 'A enemy and friendly piece is in range' do
        subject(:rook) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [rook, '', '', friendly, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible capture" do
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_captures
          expect(rook.captures).to contain_exactly([0, 5])
        end
      end
      context 'Two enemy pieces in range' do
        subject(:rook) { described_class.new(color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [rook, enemy_1, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy_2, '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_captures
          expect(rook.captures).to contain_exactly([1, 0], [0, 7])
        end
      end
      context 'Two enemy pieces in range, a friendly blocks one' do
        subject(:rook) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:enemy_1) { instance_double(Piece, color: 'black') }
        let(:enemy_2) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [rook, enemy_1, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy_2, '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          rook.instance_variable_set(:@board, board)
          rook.instance_variable_set(:@coordinate, [0, 0])
          rook.possible_captures
          expect(rook.captures).to contain_exactly([1, 0])
        end
      end
    end
  end
end
