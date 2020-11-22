# frozen_string_literal: true

module Chess
  describe Referee do
    describe '#check' do
      context 'white king can be captured by rook' do
        subject(:referee) { described_class.new }
        let(:king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }

        before do
          allow(king).to receive(:check)
          allow(rook).to receive(:captures).and_return([[0, 7]])
        end

        it 'sends #check to white king' do
          board = [
            [rook, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [king, '', '', '', '', '', '', '']
          ]
          referee.instance_variable_set(:@board, board)
          expect(king).to receive(:check)
          referee.check(king)
        end
      end
      context 'white king can not be captured by rook' do
        subject(:referee) { described_class.new }
        let(:king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }

        before do
          allow(king).to receive(:not_check)
          allow(rook).to receive(:captures).and_return([])
        end

        it 'sends #not_checkmate to white king' do
          board = [
            ['', rook, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [king, '', '', '', '', '', '', '']
          ]
          referee.instance_variable_set(:@board, board)
          expect(king).to receive(:not_check)
          referee.check(king)
        end
      end
    end
    describe '#find_kings' do
      subject(:referee) { described_class.new }
      let(:white_king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [0, 0]) }

      before do
        allow(white_king).to receive(:is_a?).with(King).and_return(true)
        allow(black_king).to receive(:is_a?).with(King).and_return(true)
      end

      it 'assigns @white_king the white king' do
        board = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [white_king, '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        referee.find_kings
        expect(referee.white_king).to eq white_king
      end

      it 'assigns @black_king the black king' do
        board = [
          [black_king, '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [white_king, '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        referee.find_kings
        expect(referee.black_king).to eq black_king
      end
    end
    describe '#mate' do
      subject(:referee) { described_class.new }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 0]) }
      let(:white_king) { instance_double(King, color: 'white', coordinate: [7, 2]) }
      let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [4, 0]) }

      before do
        allow(black_king).to receive(:mate)
        allow(black_king).to receive(:possible_movements)
        allow(black_king).to receive(:movements).and_return([[6, 0], [7, 1], [6, 1]])
        allow(white_rook).to receive(:movements).and_return([[0, 0], [1, 0], [2, 0], [3, 0], [5, 0], [6, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7]])
        allow(white_king).to receive(:movements).and_return([[7, 1], [6, 1], [6, 2], [6, 3], [7, 3]])
      end

      it 'sends #mate to black king' do
        board = [
          ['', '', '', '', white_rook, '', '', black_king],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', white_king],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        black_king.instance_variable_set(:@check, true)
        expect(black_king).to receive(:mate)
        referee.mate(black_king)
      end

      it 'does not send #mate to black king' do
        board = [
          ['', '', '', '', white_rook, '', '', black_king],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        black_king.instance_variable_set(:@check, true)
        expect(black_king).not_to receive(:mate)
        referee.mate(black_king)
      end
    end
    describe '#stalemate' do
      subject(:referee) { described_class.new }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 0]) }
      let(:white_king) { instance_double(King, color: 'white', coordinate: [7, 2]) }
      let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [4, 0]) }

      before do
        allow(black_king).to receive(:mate)
        allow(black_king).to receive(:possible_movements)
        allow(black_king).to receive(:movements).and_return([[6, 0], [7, 1], [6, 1]])
        allow(white_rook).to receive(:movements).and_return([[6, 0], [6, 1], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7], [0, 2], [0, 3], [0, 4], [0, 5]])
        allow(white_king).to receive(:movements).and_return([[7, 1], [6, 1], [6, 3], [7, 3]])
      end

      it 'sends #stalemate to black king' do
        board = [
          ['', '', '', '', '', '', '', black_king],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', white_rook, white_king],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(black_king).to receive(:stalemate)
        referee.stalemate(black_king)
      end

      it 'does not send #stalemate to black king' do
        board = [
          ['', '', '', '', '', '', '', black_king],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', white_rook, ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(black_king).not_to receive(:stalemate)
        referee.stalemate(black_king)
      end
    end

    describe '#castling' do
      subject(:referee) { described_class.new }
      let(:white_king) { instance_double(King, color: 'white', coordinate: [7, 4]) }
      let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [7, 7]) }
      let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [7, 5]) }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 4]) }
      let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
      let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [7, 5]) }

      before do
      end

      it 'sends #short_castling to king and rook' do
        board = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', white_king, '', '', white_rook]
        ]
        referee.instance_variable_set(:@board, board)
        expect(white_king).to receive(:short_castling)
        expect(white_rook).to receive(:short_castling)
        referee.castling(white_king, white_rook)
      end

      it 'does not send #short_castling to king and rook' do
        board = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', white_king, white_bishop, '', white_rook]
        ]
        referee.instance_variable_set(:@board, board)
        expect(white_king).not_to receive(:short_castling)
        expect(white_rook).not_to receive(:short_castling)
        referee.castling(white_king, white_rook)
      end
    end
  end
end
