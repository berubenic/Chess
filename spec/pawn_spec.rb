# frozen_string_literal: true

# Pawn

module Chess
  describe Pawn do
    describe '#possible_movements' do
      context 'white pawn is at starting square' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 6]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 5], [0, 4])
        end
      end

      context 'black pawn is at starting square' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 1]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 2], [0, 3])
        end
      end

      context 'white pawn has moved from starting square' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 4]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 4])
          pawn.instance_variable_set(:@moved, true)
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 3])
        end
      end

      context 'black pawn has moved from starting square' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 4]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 4])
          pawn.instance_variable_set(:@moved, true)
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 5])
        end
      end

      context "white pawn has a friendly piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 6]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 5])
        end
      end
      context "white pawn has a friendly piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an empty array]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.empty?).to be true
        end
      end

      context "black pawn has a friendly piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:friendly) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 1]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 2])
        end
      end
      context "black pawn has a friendly piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:friendly) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        it 'assigns @movements an empty array' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements.empty?).to be true
        end
      end

      context "white pawn has a enemy piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 6]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 5])
        end
      end
      context "white pawn has a enemy piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an empty array]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.empty?).to be true
        end
      end

      context "black pawn has a enemy piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an array of possible moves when at [0, 1]' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_movements
          expect(pawn.movements).to contain_exactly([0, 2])
        end
      end
      context "black pawn has a enemy piece occupying it's possible move" do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @movements an empty array' do
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
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it 'assigns @captures an empty array' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_captures
          expect(pawn.captures.empty?).to be true
        end
      end

      context 'Board is empty except for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
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
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_captures
          expect(pawn.captures.empty?).to be true
        end
      end

      context 'A enemy piece is in range of the white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', enemy, '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_captures
          expect(pawn.captures).to contain_exactly([1, 5])
        end
      end
      context 'A enemy piece is in range of the white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 6])
          pawn.possible_captures
          expect(pawn.captures).to contain_exactly([0, 5])
        end
      end

      context 'A enemy piece is in range of the black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 1])
          pawn.possible_captures
          expect(pawn.captures).to contain_exactly([1, 2])
        end
      end
      context 'A enemy piece is in range of the black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 1])
          pawn.possible_captures
          expect(pawn.captures).to contain_exactly([0, 2])
        end
      end

      context 'A enemy piece is in range of the black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 3])
          pawn.possible_captures
          expect(pawn.captures).to contain_exactly([2, 4])
        end
      end

      context 'A enemy piece and a friendly piece is in range of the white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:friendly) { instance_double(Pawn, color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [friendly, '', enemy, '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 6])
          pawn.possible_captures
          expect(pawn.captures).to contain_exactly([2, 5])
        end
      end

      context 'A enemy piece and a friendly piece is in range of the black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:friendly) { instance_double(Pawn, color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', pawn, '', '', '', '', '', ''],
            [friendly, '', enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        it "assigns @captures an array with it's possible captures" do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 1])
          pawn.possible_captures
          expect(pawn.captures).to contain_exactly([2, 2])
        end
      end

      context 'left en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([0, 2])
        end
      end
      context 'left en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', enemy, pawn, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [2, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([1, 2])
        end
      end
      context 'left en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', enemy, pawn],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [7, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([6, 2])
        end
      end

      context 'right en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([2, 2])
        end
      end
      context 'right en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([1, 2])
        end
      end

      context 'left and right en_passant for white pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left and right en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([0, 2], [2, 2])
        end
      end

      context 'enemy is not a pawn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Queen, color: 'black') }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Queen)
        end

        it 'does not assign @en_passant_captures when the enemy has not moved in previous turn' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures.empty?).to be true
        end
      end

      context 'enemy pawn has not moved two squares in previous turn' do
        subject(:pawn) { described_class.new(color: 'white') }
        let(:enemy) { instance_double(Pawn, color: 'black', two_squared: false) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 3])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures.empty?).to be true
        end
      end
      context 'left en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 4])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([0, 5])
        end
      end
      context 'left en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', enemy, pawn, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [2, 4])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([1, 5])
        end
      end
      context 'left en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', enemy, pawn],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [7, 4])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([6, 5])
        end
      end
      context 'right en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 4])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([2, 5])
        end
      end

      context 'right en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, enemy, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 4])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([1, 5])
        end
      end
      context 'left and right en_passant for black pawn' do
        subject(:pawn) { described_class.new(color: 'black') }
        let(:enemy) { instance_double(Pawn, color: 'white', two_squared: true) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy, pawn, enemy, '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(enemy).to receive(:class).and_return(Pawn)
        end

        it 'assigns @en_passant_captures a left en_passant move when enemy has moved two squares' do
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [1, 4])
          pawn.possible_en_passant
          expect(pawn.en_passant_captures).to contain_exactly([0, 5], [2, 5])
        end
      end
    end
  end
end
