# frozen_string_literal: true

# Pawn

module Chess
  xdescribe Pawn do
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
        let(:enemy) { instance_double(Pawn, color: 'black') }

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
        let(:enemy) { instance_double(Pawn, color: 'white') }

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
        let(:friendly) { instance_double(Pawn, color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black') }

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
        let(:friendly) { instance_double(Pawn, color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white') }

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

      context 'left en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
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
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[0, 2]])
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', enemy, pawn, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [2, 3])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[1, 2]])
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', enemy, pawn],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [7, 3])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[6, 2]])
        end
      end

      context 'right en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 3])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[2, 2]])
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 3])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[1, 2]])
        end
      end

      context 'left and right en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 3])
          pawn.possible_captures
          expect(pawn.en_passant_captures.include?([0, 2])).to be true
          expect(pawn.en_passant_captures.include?([2, 2])).to be true
        end
      end

      context 'enemy is not a pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Queen, color: 'black') }

        before do
          allow(enemy).to receive(:class).and_return(Queen)
        end

        it 'does not assign @en_passant_captures when the enemy has not moved in previous turn' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 3])
          pawn.possible_captures
          expect(pawn.en_passant_captures.empty?).to be true
        end
      end

      context 'enemy pawn has not moved two squares in previous turn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: false) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 3])
          pawn.possible_captures
          expect(pawn.en_passant_captures.empty?).to be true
        end
      end
      context 'left en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 4])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[0, 5]])
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', enemy, pawn, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [2, 4])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[1, 5]])
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', enemy, pawn],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [7, 4])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[6, 5]])
        end
      end
      context 'right en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 4])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[2, 5]])
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 4])
          pawn.possible_captures
          expect(pawn.en_passant_captures).to eq([[1, 5]])
        end
      end
      context 'left and right en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 4])
          pawn.possible_captures
          expect(pawn.en_passant_captures.include?([0, 5])).to be true
          expect(pawn.en_passant_captures.include?([2, 5])).to be true
        end
      end
    end
  end
end
