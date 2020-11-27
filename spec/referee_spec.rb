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
      context 'white king is in check' do
        subject(:referee) { described_class.new }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [7, 4]) }
        let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [7, 7]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 7]) }

        before do
          allow(white_king).to receive(:check).and_return(true)
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
            [black_rook, '', '', '', white_king, '', '', white_rook]
          ]
          referee.instance_variable_set(:@board, board)
          expect(white_king).not_to receive(:short_castling)
          expect(white_rook).not_to receive(:short_castling)
          referee.castling(white_king, white_rook)
        end
      end
      context 'short castling for white king and rook' do
        subject(:referee) { described_class.new }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [7, 4]) }
        let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [7, 7]) }
        let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [7, 5]) }
        let(:black_pawn) { instance_double(Pawn, color: 'black', coordinate: [7, 6]) }
        let(:black_knight) { instance_double(Knight, color: 'black', coordinate: [7, 5]) }

        before do
          allow(white_king).to receive(:check).and_return(false)
          allow(white_king).to receive(:moved).and_return(false)
          allow(white_rook).to receive(:moved).and_return(false)
          allow(black_pawn).to receive(:class).and_return(Pawn)
          allow(black_knight).to receive(:movements).and_return([[6, 7], [5, 6], [5, 4], [6, 3]])
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

        it 'does not send #short_castling to king and rook' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', black_pawn],
            ['', '', '', '', white_king, '', '', white_rook]
          ]
          referee.instance_variable_set(:@board, board)
          expect(white_king).not_to receive(:short_castling)
          expect(white_rook).not_to receive(:short_castling)
          referee.castling(white_king, white_rook)
        end

        it 'does not send #short_castling to king and rook' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', black_knight],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', white_king, '', '', white_rook]
          ]
          referee.instance_variable_set(:@board, board)
          expect(white_king).not_to receive(:short_castling)
          expect(white_rook).not_to receive(:short_castling)
          referee.castling(white_king, white_rook)
        end
      end

      context 'short castling for black king and rook' do
        subject(:referee) { described_class.new }
        let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 4]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [7, 0]) }
        let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [7, 5]) }
        let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [7, 1]) }

        before do
          allow(black_king).to receive(:check).and_return(false)
          allow(black_king).to receive(:moved).and_return(false)
          allow(black_rook).to receive(:moved).and_return(false)
          allow(white_pawn).to receive(:class).and_return(Pawn)
        end

        it 'sends #short_castling to king and rook' do
          board = [
            ['', '', '', '', black_king, '', '', black_rook],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          referee.instance_variable_set(:@board, board)
          expect(black_king).to receive(:short_castling)
          expect(black_rook).to receive(:short_castling)
          referee.castling(black_king, black_rook)
        end

        it 'does not send #short_castling to king and rook' do
          board = [
            ['', '', '', '', black_king, black_bishop, '', black_rook],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          referee.instance_variable_set(:@board, board)
          expect(black_king).not_to receive(:short_castling)
          expect(black_rook).not_to receive(:short_castling)
          referee.castling(black_king, black_rook)
        end

        it 'does not send #short_castling to king and rook' do
          board = [
            ['', '', '', '', black_king, '', '', black_rook],
            ['', '', '', '', '', '', '', white_pawn],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          referee.instance_variable_set(:@board, board)
          expect(black_king).not_to receive(:short_castling)
          expect(black_rook).not_to receive(:short_castling)
          referee.castling(black_king, black_rook)
        end
      end
    end
    context 'long_castling for white king and rook' do
      subject(:referee) { described_class.new }
      let(:white_king) { instance_double(King, color: 'white', coordinate: [4, 7]) }
      let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [0, 7]) }
      let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [7, 2]) }
      let(:black_pawn) { instance_double(Pawn, color: 'black', coordinate: [1, 6]) }

      before do
        allow(white_king).to receive(:check).and_return(false)
        allow(white_king).to receive(:moved).and_return(false)
        allow(white_rook).to receive(:moved).and_return(false)
        allow(black_pawn).to receive(:class).and_return(Pawn)
      end

      it 'sends #long_castling to king and rook' do
        board = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [white_rook, '', '', '', white_king, '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(white_king).to receive(:long_castling)
        expect(white_rook).to receive(:long_castling)
        referee.castling(white_king, white_rook)
      end

      it 'does not send #long_castling to king and rook' do
        board = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [white_rook, '', white_bishop, '', white_king, '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(white_king).not_to receive(:long_castling)
        expect(white_rook).not_to receive(:long_castling)
        referee.castling(white_king, white_rook)
      end

      it 'does not send #long_castling to king and rook' do
        board = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', black_pawn, '', '', '', '', '', ''],
          [white_rook, '', '', '', white_king, '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(white_king).not_to receive(:long_castling)
        expect(white_rook).not_to receive(:long_castling)
        referee.castling(white_king, white_rook)
      end
    end
    context 'long_castling for black king and rook' do
      subject(:referee) { described_class.new }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [4, 0]) }
      let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
      let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [0, 2]) }
      let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [1, 1]) }

      before do
        allow(black_king).to receive(:check).and_return(false)
        allow(black_king).to receive(:moved).and_return(false)
        allow(black_rook).to receive(:moved).and_return(false)
        allow(white_pawn).to receive(:class).and_return(Pawn)
      end

      it 'sends #long_castling to king and rook' do
        board = [
          [black_rook, '', '', '', black_king, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(black_king).to receive(:long_castling)
        expect(black_rook).to receive(:long_castling)
        referee.castling(black_king, black_rook)
      end

      it 'does not send #long_castling to king and rook' do
        board = [
          [black_rook, '', black_bishop, '', black_king, '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(black_king).not_to receive(:long_castling)
        expect(black_rook).not_to receive(:long_castling)
        referee.castling(black_king, black_rook)
      end

      it 'does not send #long_castling to king and rook' do
        board = [
          [black_rook, '', '', '', black_king, '', '', ''],
          ['', white_pawn, '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        referee.instance_variable_set(:@board, board)
        expect(black_king).not_to receive(:long_castling)
        expect(black_rook).not_to receive(:long_castling)
        referee.castling(black_king, black_rook)
      end
    end
    describe '#valid_selection?' do
      subject(:referee) { described_class.new }
      let(:pawn) { instance_double(Pawn, color: 'white', coordinate: [0, 6]) }
      let(:board_array) do
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
      let(:board) { instance_double(Board, board: board_array) }

      before do
      end

      it 'returns true' do
        referee.instance_variable_set(:@board, board)
        selection = [0, 6]
        color = 'white'
        expect(referee.valid_selection?(selection, color)).to be true
      end

      it 'returns false' do
        referee.instance_variable_set(:@board, board)
        selection = [0, 6]
        color = 'black'
        expect(referee.valid_selection?(selection, color)).to be false
      end

      it 'returns false' do
        referee.instance_variable_set(:@board, board)
        selection = [1, 6]
        color = 'white'
        expect(referee.valid_selection?(selection, color)).to be false
      end
    end
  end
end
