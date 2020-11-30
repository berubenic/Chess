# frozen_string_literal: true

module Chess
  describe Referee do
    describe '#current_player_in_check?' do
      subject(:referee) { described_class.new }
      let(:player) { double('Player', color: 'white') }
      let(:white_king) { double('King') }

      it 'returns true' do
        allow(referee).to receive(:check?).and_return(true)
        expect(referee.current_player_in_check?(player)).to be true
      end

      it 'returns false' do
        allow(referee).to receive(:check?).and_return(false)
        expect(referee.current_player_in_check?(player)).to be false
      end
    end
    describe '#check?' do
      context 'white king can be captured by rook' do
        let(:king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
        let(:array) do
          [
            [rook, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [king, '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        subject(:referee) { described_class.new(board: board) }

        before do
          allow(rook).to receive(:possible_captures)
          allow(rook).to receive(:captures).and_return([[0, 7]])
        end

        it 'returns true' do
          expect(referee.check?(king)).to be true
        end
      end
      context 'white king can not be captured by rook' do
        let(:king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
        let(:array) do
          [
            ['', rook, '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [king, '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        subject(:referee) { described_class.new(board: board) }

        before do
          allow(rook).to receive(:possible_captures)
          allow(rook).to receive(:captures).and_return([])
        end

        it 'sends #not_checkmate to white king' do
          expect(referee.check?(king)).to be false
        end
      end
    end
    describe '#current_player_stalemate?' do
      subject(:referee) { described_class.new }
      let(:player) { double('Player', color: 'white') }
      let(:white_king) { double('King') }

      it 'returns true' do
        allow(referee).to receive(:stalemate?).and_return(true)
        expect(referee.current_player_stalemate?(player)).to be true
      end

      it 'returns false' do
        allow(referee).to receive(:stalemate?).and_return(false)
        expect(referee.current_player_stalemate?(player)).to be false
      end
    end
    describe '#find_kings' do
      context 'white king' do
        subject(:referee) { described_class.new }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:black_king) { instance_double(King, color: 'black', coordinate: [0, 0]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [white_king, '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(white_king).to receive(:is_a?).with(King).and_return(true)
          allow(black_king).to receive(:is_a?).with(King).and_return(true)
        end

        it 'assigns @white_king the white king' do
          referee.instance_variable_set(:@board, board)
          referee.find_kings
          expect(referee.white_king).to eq white_king
        end
      end
      context 'black king' do
        subject(:referee) { described_class.new }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:black_king) { instance_double(King, color: 'black', coordinate: [0, 0]) }
        let(:array) do
          [
            [black_king, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [white_king, '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(white_king).to receive(:is_a?).with(King).and_return(true)
          allow(black_king).to receive(:is_a?).with(King).and_return(true)
        end

        it 'assigns @black_king the black king' do
          referee.instance_variable_set(:@board, board)
          referee.find_kings
          expect(referee.black_king).to eq black_king
        end
      end
    end

    describe '#castling' do
      context 'white king is in check' do
        subject(:referee) { described_class.new }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [7, 4]) }
        let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [7, 7]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 7]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [black_rook, '', '', '', white_king, '', '', white_rook]
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(white_king).to receive(:check).and_return(true)
        end

        it 'does not send #short_castling and #long_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(white_king).to receive(:disallow_short_castling)
          expect(white_rook).to receive(:disallow_short_castling)
          expect(white_king).to receive(:disallow_long_castling)
          expect(white_rook).to receive(:disallow_long_castling)
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
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', white_king, '', '', white_rook]
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(white_king).to receive(:check).and_return(false)
          allow(white_king).to receive(:moved).and_return(false)
          allow(white_rook).to receive(:moved).and_return(false)
          allow(black_pawn).to receive(:class).and_return(Pawn)
          allow(black_knight).to receive(:movements).and_return([[6, 7], [5, 6], [5, 4], [6, 3]])
        end

        it 'sends #short_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(white_king).to receive(:allow_short_castling)
          expect(white_rook).to receive(:allow_short_castling)
          expect(white_rook).to receive(:disallow_long_castling)
          expect(white_king).to receive(:disallow_long_castling)
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
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', white_king, white_bishop, '', white_rook]
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(white_king).to receive(:check).and_return(false)
          allow(white_king).to receive(:moved).and_return(false)
          allow(white_rook).to receive(:moved).and_return(false)
          allow(black_pawn).to receive(:class).and_return(Pawn)
          allow(black_knight).to receive(:movements).and_return([[6, 7], [5, 6], [5, 4], [6, 3]])
        end

        it 'does not send #short_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(white_king).to receive(:disallow_short_castling)
          expect(white_rook).to receive(:disallow_short_castling)
          expect(white_king).to receive(:disallow_long_castling)
          expect(white_rook).to receive(:disallow_long_castling)
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
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', black_pawn],
            ['', '', '', '', white_king, '', '', white_rook]
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(white_king).to receive(:check).and_return(false)
          allow(white_king).to receive(:moved).and_return(false)
          allow(white_rook).to receive(:moved).and_return(false)
          allow(black_pawn).to receive(:class).and_return(Pawn)
          allow(black_knight).to receive(:movements).and_return([[6, 7], [5, 6], [5, 4], [6, 3]])
        end

        it 'does not send #short_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(white_king).to receive(:disallow_short_castling)
          expect(white_rook).to receive(:disallow_short_castling)
          expect(white_king).to receive(:disallow_long_castling)
          expect(white_rook).to receive(:disallow_long_castling)
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
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', black_knight],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', white_king, '', '', white_rook]
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(white_king).to receive(:check).and_return(false)
          allow(white_king).to receive(:moved).and_return(false)
          allow(white_rook).to receive(:moved).and_return(false)
          allow(black_pawn).to receive(:class).and_return(Pawn)
          allow(black_knight).to receive(:movements).and_return([[6, 7], [5, 6], [5, 4], [6, 3]])
        end

        it 'does not send #short_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(white_king).to receive(:disallow_short_castling)
          expect(white_rook).to receive(:disallow_short_castling)
          expect(white_king).to receive(:disallow_long_castling)
          expect(white_rook).to receive(:disallow_long_castling)
          referee.castling(white_king, white_rook)
        end
      end

      context 'short castling for black king and rook' do
        subject(:referee) { described_class.new }
        let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 4]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [7, 0]) }
        let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [7, 5]) }
        let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [7, 1]) }
        let(:array) do
          [
            ['', '', '', '', black_king, '', '', black_rook],
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

        before do
          allow(black_king).to receive(:check).and_return(false)
          allow(black_king).to receive(:moved).and_return(false)
          allow(black_rook).to receive(:moved).and_return(false)
          allow(white_pawn).to receive(:class).and_return(Pawn)
        end

        it 'sends #short_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(black_king).to receive(:allow_short_castling)
          expect(black_rook).to receive(:allow_short_castling)
          expect(black_king).to receive(:disallow_long_castling)
          expect(black_rook).to receive(:disallow_long_castling)
          referee.castling(black_king, black_rook)
        end
      end
      context 'short castling for black king and rook' do
        subject(:referee) { described_class.new }
        let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 4]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [7, 0]) }
        let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [7, 5]) }
        let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [7, 1]) }
        let(:array) do
          [
            ['', '', '', '', black_king, black_bishop, '', black_rook],
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

        before do
          allow(black_king).to receive(:check).and_return(false)
          allow(black_king).to receive(:moved).and_return(false)
          allow(black_rook).to receive(:moved).and_return(false)
          allow(white_pawn).to receive(:class).and_return(Pawn)
        end

        it 'does not send #short_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(black_king).to receive(:disallow_short_castling)
          expect(black_rook).to receive(:disallow_short_castling)
          expect(black_king).to receive(:disallow_long_castling)
          expect(black_rook).to receive(:disallow_long_castling)
          referee.castling(black_king, black_rook)
        end
      end
      context 'short castling for black king and rook' do
        subject(:referee) { described_class.new }
        let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 4]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [7, 0]) }
        let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [7, 5]) }
        let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [7, 1]) }
        let(:array) do
          [
            ['', '', '', '', black_king, '', '', black_rook],
            ['', '', '', '', '', '', '', white_pawn],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }

        before do
          allow(black_king).to receive(:check).and_return(false)
          allow(black_king).to receive(:moved).and_return(false)
          allow(black_rook).to receive(:moved).and_return(false)
          allow(white_pawn).to receive(:class).and_return(Pawn)
        end
        it 'does not send #short_castling to king and rook' do
          referee.instance_variable_set(:@board, board)
          expect(black_king).to receive(:disallow_short_castling)
          expect(black_rook).to receive(:disallow_short_castling)
          expect(black_king).to receive(:disallow_long_castling)
          expect(black_rook).to receive(:disallow_long_castling)
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
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [white_rook, '', '', '', white_king, '', '', '']
        ]
      end
      let(:board) { instance_double(Board, board: array) }

      before do
        allow(white_king).to receive(:check).and_return(false)
        allow(white_king).to receive(:moved).and_return(false)
        allow(white_rook).to receive(:moved).and_return(false)
        allow(black_pawn).to receive(:class).and_return(Pawn)
      end

      it 'sends #long_castling to king and rook' do
        referee.instance_variable_set(:@board, board)
        expect(white_king).to receive(:allow_long_castling)
        expect(white_rook).to receive(:allow_long_castling)
        expect(white_rook).to receive(:disallow_short_castling)
        expect(white_king).to receive(:disallow_short_castling)
        referee.castling(white_king, white_rook)
      end
    end
    context 'long_castling for white king and rook' do
      subject(:referee) { described_class.new }
      let(:white_king) { instance_double(King, color: 'white', coordinate: [4, 7]) }
      let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [0, 7]) }
      let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [7, 2]) }
      let(:black_pawn) { instance_double(Pawn, color: 'black', coordinate: [1, 6]) }
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [white_rook, '', white_bishop, '', white_king, '', '', '']
        ]
      end
      let(:board) { instance_double(Board, board: array) }

      before do
        allow(white_king).to receive(:check).and_return(false)
        allow(white_king).to receive(:moved).and_return(false)
        allow(white_rook).to receive(:moved).and_return(false)
        allow(black_pawn).to receive(:class).and_return(Pawn)
      end

      it 'does not send #long_castling to king and rook' do
        referee.instance_variable_set(:@board, board)
        expect(white_king).to receive(:disallow_long_castling)
        expect(white_rook).to receive(:disallow_long_castling)
        expect(white_king).to receive(:disallow_short_castling)
        expect(white_rook).to receive(:disallow_short_castling)
        referee.castling(white_king, white_rook)
      end
    end
    context 'long_castling for white king and rook' do
      subject(:referee) { described_class.new }
      let(:white_king) { instance_double(King, color: 'white', coordinate: [4, 7]) }
      let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [0, 7]) }
      let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [7, 2]) }
      let(:black_pawn) { instance_double(Pawn, color: 'black', coordinate: [1, 6]) }
      let(:array) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', black_pawn, '', '', '', '', '', ''],
          [white_rook, '', '', '', white_king, '', '', '']
        ]
      end
      let(:board) { instance_double(Board, board: array) }

      before do
        allow(white_king).to receive(:check).and_return(false)
        allow(white_king).to receive(:moved).and_return(false)
        allow(white_rook).to receive(:moved).and_return(false)
        allow(black_pawn).to receive(:class).and_return(Pawn)
      end

      it 'does not send #long_castling to king and rook' do
        referee.instance_variable_set(:@board, board)
        expect(white_king).to receive(:disallow_long_castling)
        expect(white_rook).to receive(:disallow_long_castling)
        expect(white_king).to receive(:disallow_short_castling)
        expect(white_rook).to receive(:disallow_short_castling)
        referee.castling(white_king, white_rook)
      end
    end
    context 'long_castling for black king and rook' do
      subject(:referee) { described_class.new }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [4, 0]) }
      let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
      let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [0, 2]) }
      let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [1, 1]) }
      let(:array) do
        [
          [black_rook, '', '', '', black_king, '', '', ''],
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

      before do
        allow(black_king).to receive(:check).and_return(false)
        allow(black_king).to receive(:moved).and_return(false)
        allow(black_rook).to receive(:moved).and_return(false)
        allow(white_pawn).to receive(:class).and_return(Pawn)
      end

      it 'sends #long_castling to king and rook' do
        referee.instance_variable_set(:@board, board)
        expect(black_king).to receive(:allow_long_castling)
        expect(black_rook).to receive(:allow_long_castling)
        expect(black_king).to receive(:disallow_short_castling)
        expect(black_rook).to receive(:disallow_short_castling)
        referee.castling(black_king, black_rook)
      end
    end
    context 'long_castling for black king and rook' do
      subject(:referee) { described_class.new }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [4, 0]) }
      let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
      let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [0, 2]) }
      let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [1, 1]) }
      let(:array) do
        [
          [black_rook, '', black_bishop, '', black_king, '', '', ''],
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

      before do
        allow(black_king).to receive(:check).and_return(false)
        allow(black_king).to receive(:moved).and_return(false)
        allow(black_rook).to receive(:moved).and_return(false)
        allow(white_pawn).to receive(:class).and_return(Pawn)
      end

      it 'does not send #long_castling to king and rook' do
        referee.instance_variable_set(:@board, board)
        expect(black_king).to receive(:disallow_long_castling)
        expect(black_rook).to receive(:disallow_long_castling)
        expect(black_king).to receive(:disallow_short_castling)
        expect(black_rook).to receive(:disallow_short_castling)
        referee.castling(black_king, black_rook)
      end
    end
    context 'long_castling for black king and rook' do
      subject(:referee) { described_class.new }
      let(:black_king) { instance_double(King, color: 'black', coordinate: [4, 0]) }
      let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
      let(:black_bishop) { instance_double(Bishop, color: 'black', coordinate: [0, 2]) }
      let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [1, 1]) }
      let(:array) do
        [
          [black_rook, '', '', '', black_king, '', '', ''],
          ['', white_pawn, '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      let(:board) { instance_double(Board, board: array) }

      before do
        allow(black_king).to receive(:check).and_return(false)
        allow(black_king).to receive(:moved).and_return(false)
        allow(black_rook).to receive(:moved).and_return(false)
        allow(white_pawn).to receive(:class).and_return(Pawn)
      end
      it 'does not send #long_castling to king and rook' do
        referee.instance_variable_set(:@board, board)
        expect(black_king).to receive(:disallow_long_castling)
        expect(black_rook).to receive(:disallow_long_castling)
        expect(black_king).to receive(:disallow_short_castling)
        expect(black_rook).to receive(:disallow_short_castling)
        referee.castling(black_king, black_rook)
      end
    end
    describe '#valid_selection?' do
      subject(:referee) { described_class.new }
      let(:pawn) { instance_double(Pawn, color: 'white', coordinate: [0, 6]) }
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
      let(:white_player) { double('white_player', color: 'white') }
      let(:black_player) { double('black_player', color: 'black') }

      it 'returns true' do
        referee.instance_variable_set(:@board, board)
        selection = [0, 6]
        expect(referee.valid_selection?(selection, white_player)).to be true
      end

      it 'returns false' do
        referee.instance_variable_set(:@board, board)
        selection = [0, 6]
        expect(referee.valid_selection?(selection, black_player)).to be false
      end

      it 'returns false' do
        referee.instance_variable_set(:@board, board)
        selection = [1, 6]
        expect(referee.valid_selection?(selection, white_player)).to be false
      end
    end
  end
end
