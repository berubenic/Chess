# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/BlockLength

# Knight spec
module Chess
  describe King do
    describe '#possible_movements' do
      context 'king is at [0, 0]' do
        subject(:king) { described_class.new }
        let(:array) do
          [
            [king, '', '', '', '', '', '', ''],
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
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [0, 0])
          king.possible_movements
          expect(king.movements).to contain_exactly([1, 0], [1, 1], [0, 1])
        end
      end
      context 'king is at [3, 3]' do
        subject(:king) { described_class.new }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', king, '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [3, 3]' do
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [3, 3])
          king.possible_movements
          expect(king.movements).to contain_exactly([3, 2], [4, 2], [4, 3], [4, 4], [3, 4], [2, 4], [2, 3], [2, 2])
        end
      end
      context 'king is at [1, 1]' do
        subject(:king) { described_class.new }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', king, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [1, 1]' do
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [1, 1])
          king.possible_movements
          expect(king.movements).to contain_exactly([0, 0], [1, 0], [2, 0], [2, 1], [2, 2], [1, 2], [0, 2], [0, 1])
        end
      end
      context "A friendly piece occupies one of it's possible moves" do
        subject(:king) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            [king, '', '', '', '', '', '', ''],
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
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [0, 0])
          king.possible_movements
          expect(king.movements).to contain_exactly([1, 0], [1, 1])
        end
      end
      context "Multiple friendly pieces occupying it's possible moves" do
        subject(:king) { described_class.new(color: 'black') }
        let(:friendly_1) { instance_double(Piece, color: 'black') }
        let(:friendly_2) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', friendly_1, king, '', '', ''],
            ['', '', '', '', friendly_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [4, 4])
          king.possible_movements
          expect(king.movements).to contain_exactly([3, 3], [4, 3], [5, 3], [5, 4], [5, 5], [3, 5])
        end
      end
      context "Enemy pieces don't matter" do
        subject(:king) { described_class.new(color: 'black') }
        let(:enemy_1) { instance_double(Piece, color: 'white') }
        let(:enemy_2) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', enemy_1, king, '', '', ''],
            ['', '', '', '', enemy_2, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [4, 4]' do
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [4, 4])
          king.possible_movements
          expect(king.movements).to contain_exactly([3, 3], [4, 3], [5, 3], [5, 4], [5, 5], [3, 5])
        end
      end
      describe '#possible_captures' do
        context 'Board is empty except for King' do
          subject(:king) { described_class.new }
          let(:array) do
            [
              [king, '', '', '', '', '', '', ''],
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
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures.empty?).to be true
          end
        end
        context 'A enemy piece is in range' do
          subject(:king) { described_class.new(color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }
          let(:array) do
            [
              [king, '', '', '', '', '', '', ''],
              [enemy, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
          end
          let(:board) { instance_double(Board, board: array) }

          it "assigns @captures an array with it's possible capture" do
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures).to contain_exactly([0, 1])
          end
        end
        context 'A enemy and friendly piece is in range' do
          subject(:king) { described_class.new(color: 'white') }
          let(:friendly) { instance_double(Piece, color: 'white') }
          let(:enemy) { instance_double(Piece, color: 'black') }
          let(:array) do
            [
              [king, friendly, '', '', '', '', '', ''],
              [enemy, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
          end
          let(:board) { instance_double(Board, board: array) }

          it "assigns @captures an array with it's possible capture" do
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures).to contain_exactly([0, 1])
          end
        end
        context 'Two enemy pieces in range' do
          subject(:king) { described_class.new(color: 'white') }
          let(:enemy_1) { instance_double(Piece, color: 'black') }
          let(:enemy_2) { instance_double(Piece, color: 'black') }
          let(:array) do
            [
              [king, enemy_1, '', '', '', '', '', ''],
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
            king.instance_variable_set(:@board, board)
            king.instance_variable_set(:@coordinate, [0, 0])
            king.possible_captures
            expect(king.captures).to contain_exactly([1, 0], [0, 1])
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
# rubocop:enable Metrics/ModuleLength
