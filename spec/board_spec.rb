# frozen_string_literal: true

# board specs
module Chess
  describe Board do
    describe '#setup_white_pieces' do
      subject(:board) { described_class.new }
      it 'adds white pieces to board' do
        board.setup_white_pieces
        expect(board.array[6].all? { |element| element.is_a?(WhitePawn) }).to be true
        expect(board.array[7][0]).to be_a(WhiteRook)
        expect(board.array[7][1]).to be_a(WhiteKnight)
        expect(board.array[7][2]).to be_a(WhiteBishop)
        expect(board.array[7][3]).to be_a(WhiteQueen)
        expect(board.array[7][4]).to be_a(WhiteKing)
        expect(board.array[7][5]).to be_a(WhiteBishop)
        expect(board.array[7][6]).to be_a(WhiteKnight)
        expect(board.array[7][7]).to be_a(WhiteRook)
      end
    end
    describe '#setup_black_pieces' do
      subject(:board) { described_class.new }
      it 'adds black pieces to board' do
        board.setup_black_pieces
        expect(board.array[1].all? { |element| element.is_a?(BlackPawn) }).to be true
        expect(board.array[0][0]).to be_a(BlackRook)
        expect(board.array[0][1]).to be_a(BlackKnight)
        expect(board.array[0][2]).to be_a(BlackBishop)
        expect(board.array[0][3]).to be_a(BlackQueen)
        expect(board.array[0][4]).to be_a(BlackKing)
        expect(board.array[0][5]).to be_a(BlackBishop)
        expect(board.array[0][6]).to be_a(BlackKnight)
        expect(board.array[0][7]).to be_a(BlackRook)
      end
    end
  end
end
