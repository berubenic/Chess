# frozen_string_literal: true

# Pawn

module Chess
  describe Pawn do
    describe '#possible_movements' do
      context 'white pawn is at starting square' do
        subject(:pawn) { described_class.new(color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 6]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.include?([0, 5])).to be true
          expect(pawn.movements.include?([0, 4])).to be true
        end
      end

      context 'black pawn is at starting square' do
        subject(:pawn) { described_class.new(color: 'black') }

        it 'assigns @movements an array of possible moves when at [0, 1]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements.include?([0, 2])).to be true
          expect(pawn.movements.include?([0, 3])).to be true
        end
      end

      context 'white pawn has moved from starting square' do
        subject(:pawn) { described_class.new(color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 4])
          pawn.instance_variable_set(:@moved, true)
          pawn.possible_movements
          expect(pawn.movements.include?([0, 3])).to be true
          expect(pawn.movements.include?([0, 2])).to be false
        end
      end

      context 'black pawn has moved from starting square' do
        subject(:pawn) { described_class.new(color: 'black') }

        it 'assigns @movements an array of possible moves when at [0, 4]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 4])
          pawn.instance_variable_set(:@moved, true)
          pawn.possible_movements
          expect(pawn.movements.include?([0, 5])).to be true
          expect(pawn.movements.include?([0, 6])).to be false
        end
      end

      context "white pawn has a friendly piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 6]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.include?([0, 5])).to be true
          expect(pawn.movements.include?([0, 4])).to be false
        end

        it 'assigns @movements an empty array]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.empty?).to be true
        end
      end

      context "black pawn has a friendly piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:friendly) { instance_double(Piece, color: 'black') }

        it 'assigns @movements an array of possible moves when at [0, 1]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements.include?([0, 2])).to be true
          expect(pawn.movements.include?([0, 3])).to be false
        end

        it 'assigns @movements an empty array' do
          board = [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements.empty?).to be true
        end
      end

      context "white pawn has a enemy piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }

        it 'assigns @movements an array of possible moves when at [0, 6]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.include?([0, 5])).to be true
          expect(pawn.movements.include?([0, 4])).to be false
        end

        it 'assigns @movements an empty array]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.empty?).to be true
        end
      end

      context "black pawn has a enemy piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Piece, color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 1]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements.include?([0, 2])).to be true
          expect(pawn.movements.include?([0, 3])).to be false
        end

        it 'assigns @movements an empty array' do
          board = [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements.empty?).to be true
        end
      end
    end
    describe '#possible_captures' do
      context 'Board is empty except for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }

        it 'assigns @captures an empty array' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_captures
          expect(pawn.captures.empty?).to be true
        end
      end

      context 'Board is empty except for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }

        it 'assigns @captures an empty array' do
          board = [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_captures
          expect(pawn.captures.empty?).to be true
        end
      end

      context 'A enemy piece is in range of the white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { described_class.new(color: 'black') }

        it "assigns @captures an array with it's possible captures" do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', enemy, '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_captures
          expect(pawn.captures).to eq([[1, 5]])
        end

        it "assigns @captures an array with it's possible captures" do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 6])
          pawn.possible_captures
          expect(pawn.captures).to eq([[0, 5]])
        end
      end

      context 'A enemy piece is in range of the black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { described_class.new(color: 'white') }

        it "assigns @captures an array with it's possible captures" do
          board = [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_captures
          expect(pawn.captures).to eq([[1, 2]])
        end

        it "assigns @captures an array with it's possible captures" do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 1])
          pawn.possible_captures
          expect(pawn.captures).to eq([[0, 2]])
        end
      end

      context 'A enemy piece and a friendly piece is in range of the white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:friendly) { described_class.new(color: 'white') }
        let(:enemy) { described_class.new(color: 'black') }

        it "assigns @captures an array with it's possible captures" do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', enemy, '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 6])
          pawn.possible_captures
          expect(pawn.captures).to eq([[2, 5]])
        end
      end

      context 'A enemy piece and a friendly piece is in range of the black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:friendly) { described_class.new(color: 'black') }
        let(:enemy) { described_class.new(color: 'white') }

        it "assigns @captures an array with it's possible captures" do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            [friendly, '', enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 1])
          pawn.possible_captures
          expect(pawn.captures).to eq([[2, 2]])
        end
      end

      context 'white en_passant' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { described_class.new(color: 'black') }

        it 'assigns @captures a en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 3])
        end
      end
    end
  end
end
