# frozen_string_literal: true

# board specs
module Chess
  describe Board do
    describe '#setup_white_pieces' do
      subject(:board) { described_class.new }

      before do
        board.setup_white_pieces
      end

      it 'updates all values of @array[6]' do
        expect(board.array[6].all? { |element| element.is_a?(WhitePawn) }).to be true
      end

      it 'updates value of @array[7][0]' do
        expect(board.array[7][0]).to be_a(WhiteRook)
      end

      it 'updates value of @array[7][1]' do
        expect(board.array[7][1]).to be_a(WhiteKnight)
      end

      it 'updates value of @array[7][2]' do
        expect(board.array[7][2]).to be_a(WhiteBishop)
      end

      it 'updates value of @array[7][3]' do
        expect(board.array[7][3]).to be_a(WhiteQueen)
      end

      it 'updates value of @array[7][4]' do
        expect(board.array[7][4]).to be_a(WhiteKing)
      end

      it 'updates value of @array[7][5]' do
        expect(board.array[7][5]).to be_a(WhiteBishop)
      end

      it 'updates value of @array[7][6]' do
        expect(board.array[7][6]).to be_a(WhiteKnight)
      end

      it 'updates value of @array[7][7]' do
        expect(board.array[7][7]).to be_a(WhiteRook)
      end
    end

    describe '#setup_black_pieces' do
      subject(:board) { described_class.new }

      before do
        board.setup_black_pieces
      end

      it 'updates all values of @array[1]' do
        expect(board.array[1].all? { |element| element.is_a?(BlackPawn) }).to be true
      end

      it 'updates value of @array[7][0]' do
        expect(board.array[0][0]).to be_a(BlackRook)
      end

      it 'updates value of @array[7][1]' do
        expect(board.array[0][1]).to be_a(BlackKnight)
      end

      it 'updates value of @array[7][2]' do
        expect(board.array[0][2]).to be_a(BlackBishop)
      end

      it 'updates value of @array[7][3]' do
        expect(board.array[0][3]).to be_a(BlackQueen)
      end

      it 'updates value of @array[7][4]' do
        expect(board.array[0][4]).to be_a(BlackKing)
      end

      it 'updates value of @array[7][5]' do
        expect(board.array[0][5]).to be_a(BlackBishop)
      end

      it 'updates value of @array[7][6]' do
        expect(board.array[0][6]).to be_a(BlackKnight)
      end

      it 'updates value of @array[7][7]' do
        expect(board.array[0][7]).to be_a(BlackRook)
      end
    end
  end
end
