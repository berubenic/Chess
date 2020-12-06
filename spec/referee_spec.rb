# frozen_string_literal: true

module Chess
  describe Referee do
    describe '#current_player_checked?' do
      subject(:referee) { described_class.new }
      let(:player) { double('Player', color: 'white') }
      let(:white_king) { double('King') }

      it 'returns true' do
        allow(referee).to receive(:check?).and_return(true)
        expect(referee.current_player_checked?(player)).to be true
      end

      it 'returns false' do
        allow(referee).to receive(:check?).and_return(false)
        expect(referee.current_player_checked?(player)).to be false
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
    describe '#current_player_stalemated?' do
      subject(:referee) { described_class.new }
      let(:player) { double('Player', color: 'white') }
      let(:white_king) { double('King') }

      it 'returns true' do
        allow(referee).to receive(:stalemate?).and_return(true)
        expect(referee.current_player_stalemated?(player)).to be true
      end

      it 'returns false' do
        allow(referee).to receive(:stalemate?).and_return(false)
        expect(referee.current_player_stalemated?(player)).to be false
      end
    end
    describe '#stalemate?' do
      context 'black king is stalemated' do
        let(:black_king) { instance_double(King, color: 'black', coordinate: [0, 0]) }
        let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [0, 1]) }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [0, 2]) }
        let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [5, 4]) }
        let(:array) do
          [
            [black_king, '', '', '', '', '', '', ''],
            [white_pawn, '', '', '', '', '', '', ''],
            [white_king, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', white_bishop, '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        let(:referee) { described_class.new(board: board) }

        it 'returns true' do
          allow(black_king).to receive(:possible_movements)
          allow(black_king).to receive(:movements).and_return([[1, 0], [1, 1]])
          allow(black_king).to receive(:possible_captures)
          allow(black_king).to receive(:captures).and_return([[0, 1]])
          allow(white_pawn).to receive(:possible_movements)
          allow(white_pawn).to receive(:movements).and_return([])
          allow(white_pawn).to receive(:possible_captures)
          allow(white_pawn).to receive(:captures).and_return([])
          allow(white_king).to receive(:possible_movements)
          allow(white_king).to receive(:movements).and_return([[1, 1], [1, 2], [1, 3], [0, 3]])
          allow(white_king).to receive(:possible_captures)
          allow(white_king).to receive(:captures).and_return([])
          allow(white_bishop).to receive(:possible_movements)
          allow(white_bishop).to receive(:movements).and_return([[7, 6], [6, 5], [4, 3], [3, 2], [2, 1], [1, 0],
                                                                 [7, 2], [6, 3], [4, 5], [3, 6], [2, 7]])
          allow(white_bishop).to receive(:possible_captures)
          allow(white_bishop).to receive(:captures).and_return([])
          expect(referee.stalemate?(black_king)).to be true
        end
      end
      context 'white king is stalemated' do
        let(:black_king) { instance_double(King, color: 'black', coordinate: [0, 0]) }
        let(:black_queen) { instance_double(Queen, color: 'black', coordinate: [0, 3]) }
        let(:black_rook_1) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
        let(:black_knight_1) { instance_double(Knight, color: 'black', coordinate: [0, 1]) }
        let(:black_knight_2) { instance_double(Knight, color: 'black', coordinate: [0, 6]) }
        let(:black_rook_2) { instance_double(Rook, color: 'black', coordinate: [0, 7]) }
        let(:black_pawn_1) { instance_double(Pawn, color: 'black', coordinate: [1, 0]) }
        let(:black_pawn_2) { instance_double(Pawn, color: 'black', coordinate: [1, 1]) }
        let(:black_pawn_3) { instance_double(Pawn, color: 'black', coordinate: [6, 1]) }
        let(:black_pawn_4) { instance_double(Pawn, color: 'black', coordinate: [7, 1]) }
        let(:black_pawn_5) { instance_double(Pawn, color: 'black', coordinate: [3, 2]) }
        let(:black_pawn_6) { instance_double(Pawn, color: 'black', coordinate: [2, 3]) }
        let(:black_pawn_7) { instance_double(Pawn, color: 'black', coordinate: [5, 4]) }
        let(:black_pawn_8) { instance_double(Pawn, color: 'black', coordinate: [4, 5]) }
        let(:black_bishop_1) { instance_double(Bishop, color: 'black', coordinate: [7, 4]) }
        let(:black_bishop_2) { instance_double(Bishop, color: 'black', coordinate: [1, 5]) }

        let(:white_king) { instance_double(King, color: 'white', coordinate: [4, 7]) }
        let(:white_queen) { instance_double(Queen, color: 'white', coordinate: [7, 6]) }
        let(:white_rook_1) { instance_double(Rook, color: 'white', coordinate: [7, 7]) }
        let(:white_knight_1) { instance_double(Knight, color: 'white', coordinate: [6, 7]) }
        let(:white_knight_2) { instance_double(Knight, color: 'white', coordinate: [3, 6]) }
        let(:white_rook_2) { instance_double(Rook, color: 'white', coordinate: [6, 5]) }
        let(:white_pawn_1) { instance_double(Pawn, color: 'white', coordinate: [1, 6]) }
        let(:white_pawn_2) { instance_double(Pawn, color: 'white', coordinate: [4, 6]) }
        let(:white_pawn_3) { instance_double(Pawn, color: 'white', coordinate: [6, 6]) }
        let(:white_pawn_4) { instance_double(Pawn, color: 'white', coordinate: [5, 5]) }
        let(:white_pawn_5) { instance_double(Pawn, color: 'white', coordinate: [7, 5]) }
        let(:white_pawn_6) { instance_double(Pawn, color: 'white', coordinate: [0, 4]) }
        let(:white_pawn_7) { instance_double(Pawn, color: 'white', coordinate: [2, 4]) }
        let(:white_pawn_8) { instance_double(Pawn, color: 'white', coordinate: [3, 3]) }
        let(:white_bishop_1) { instance_double(Bishop, color: 'white', coordinate: [2, 7]) }
        let(:white_bishop_2) { instance_double(Bishop, color: 'white', coordinate: [5, 7]) }
        let(:array) do
          [
            [black_rook_1, black_knight_1, '', '', black_king, '', black_knight_2, black_rook_2],
            [black_pawn_1, black_pawn_2, '', '', '', '', black_pawn_3, black_pawn_4],
            ['', '', '', black_pawn_5, '', '', '', ''],
            [black_queen, '', black_pawn_6, white_pawn_8, '', '', '', ''],
            [white_pawn_6, '', white_pawn_7, '', '', black_pawn_7, '', black_bishop_1],
            ['', black_bishop_2, '', '', black_pawn_8, white_pawn_4, white_rook_2, white_pawn_5],
            ['', white_pawn_1, '', white_knight_1, white_pawn_2, '', white_pawn_3, white_queen],
            ['', '', white_bishop_1, '', white_king, white_bishop_2, white_knight_2, white_rook_1]
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        let(:referee) { described_class.new(board: board) }

        xit 'returns true' do
          expect(referee.stalemate?(white_king)).to be true
        end
      end
      context 'black king is not stalemated' do
        let(:black_king) { instance_double(King, color: 'black', coordinate: [7, 0]) }
        let(:white_pawn) { instance_double(Pawn, color: 'white', coordinate: [0, 1]) }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [0, 2]) }
        let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [5, 4]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', black_king],
            [white_pawn, '', '', '', '', '', '', ''],
            [white_king, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', white_bishop, '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        let(:referee) { described_class.new(board: board) }

        it 'returns false' do
          allow(black_king).to receive(:possible_movements)
          allow(black_king).to receive(:movements).and_return([[6, 0], [6, 1], [7, 1]])
          allow(white_pawn).to receive(:possible_movements)
          allow(white_pawn).to receive(:movements).and_return([])
          allow(white_pawn).to receive(:possible_captures)
          allow(white_pawn).to receive(:captures).and_return([])
          allow(white_king).to receive(:possible_movements)
          allow(white_king).to receive(:movements).and_return([[1, 1], [1, 2], [1, 3], [0, 3]])
          allow(white_king).to receive(:possible_captures)
          allow(white_king).to receive(:captures).and_return([])
          allow(white_bishop).to receive(:possible_movements)
          allow(white_bishop).to receive(:movements).and_return([[7, 6], [6, 5], [4, 3], [3, 2], [2, 1], [1, 0],
                                                                 [7, 2], [6, 3], [4, 5], [3, 6], [2, 7]])
          allow(white_bishop).to receive(:possible_captures)
          allow(white_bishop).to receive(:captures).and_return([])
          expect(referee.stalemate?(black_king)).to be false
        end
      end
    end
    describe '#enemy_player_mated?' do
      subject(:referee) { described_class.new }
      let(:player) { double('Player', color: 'white') }
      let(:white_king) { double('King') }

      it 'returns true' do
        allow(referee).to receive(:mate?).and_return(true)
        expect(referee.enemy_player_mated?(player)).to be true
      end

      it 'returns false' do
        allow(referee).to receive(:mate?).and_return(false)
        expect(referee.enemy_player_mated?(player)).to be false
      end
    end
    describe '#mate?' do
      context 'black is mated' do
        let(:black_king) { instance_double(King, color: 'black', coordinate: [4, 0]) }
        let(:black_rook_1) { instance_double(Rook, color: 'black', coordinate: [3, 0]) }
        let(:black_rook_2) { instance_double(Rook, color: 'black', coordinate: [5, 0]) }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [6, 7]) }
        let(:white_queen) { instance_double(Queen, color: 'white', coordinate: [4, 2]) }
        let(:array) do
          [
            ['', '', '', black_rook_1, black_king, black_rook_2, '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', white_queen, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', white_king, '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        let(:referee) { described_class.new(board: board) }

        it 'returns true' do
          referee.instance_variable_set(:@checking_piece, white_queen)
          allow(black_king).to receive(:possible_movements)
          allow(black_king).to receive(:movements).and_return([[3, 1], [4, 1], [5, 1]])
          allow(black_king).to receive(:possible_captures)
          allow(black_king).to receive(:captures).and_return([])
          allow(black_rook_1).to receive(:possible_movements)
          allow(black_rook_1).to receive(:movements).and_return([[0, 0], [1, 0], [2, 0], [3, 1], [3, 2], [3, 3], [3, 4],
                                                                 [3, 5], [3, 6], [3, 7]])
          allow(black_rook_1).to receive(:possible_captures)
          allow(black_rook_1).to receive(:captures).and_return([])
          allow(black_rook_2).to receive(:possible_movements)
          allow(black_rook_2).to receive(:movements).and_return([[6, 0], [7, 0], [5, 1], [5, 2], [5, 3], [5, 4],
                                                                 [5, 5], [5, 6], [5, 7]])
          allow(black_rook_2).to receive(:possible_captures)
          allow(black_rook_2).to receive(:captures).and_return([])
          allow(white_queen).to receive(:possible_movements)
          allow(white_queen).to receive(:movements).and_return([[0, 2], [1, 2], [2, 2], [3, 2], [5, 2], [6, 2], [7, 2],
                                                                [2, 0], [3, 1], [5, 3], [6, 4], [7, 5], [6, 0], [5, 1],
                                                                [3, 3], [2, 4], [1, 5], [0, 6], [4, 7], [4, 6], [4, 5],
                                                                [4, 4], [4, 3], [4, 1]])
          allow(white_queen).to receive(:possible_captures)
          allow(white_queen).to receive(:captures).and_return([4, 0])
          allow(white_king).to receive(:possible_movements)
          allow(white_king).to receive(:movements).and_return([[5, 7], [5, 6], [6, 6], [7, 6], [7, 7]])
          expect(referee.mate?(black_king)).to be true
        end
      end
      context 'black is mated' do
        let(:black_king) { instance_double(King, color: 'black', coordinate: [2, 4]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [7, 4]) }
        let(:white_king) { instance_double(King, color: 'white', coordinate: [3, 7]) }
        let(:white_queen) { instance_double(Queen, color: 'white', coordinate: [3, 2]) }
        let(:white_pawn_1) { instance_double(Pawn, color: 'white', coordinate: [0, 6]) }
        let(:white_pawn_2) { instance_double(Pawn, color: 'white', coordinate: [1, 5]) }
        let(:white_pawn_3) { instance_double(Pawn, color: 'white', coordinate: [2, 5]) }
        let(:white_pawn_4) { instance_double(Pawn, color: 'white', coordinate: [3, 6]) }
        let(:white_rook_1) { instance_double(Rook, color: 'white', coordinate: [0, 7]) }
        let(:white_rook_2) { instance_double(Rook, color: 'white', coordinate: [4, 3]) }
        let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [2, 7]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', white_queen, '', '', '', ''],
            ['', '', '', '', white_rook_2, '', '', ''],
            ['', '', black_king, '', '', '', '', black_rook],
            ['', white_pawn_2, white_pawn_3, '', '', '', '', ''],
            [white_pawn_1, '', '', white_pawn_4, '', '', '', ''],
            [white_rook_1, '', white_bishop, white_king, '', '', '', '']
          ]
        end
        let(:board) { instance_double(Board, board: array) }
        let(:referee) { described_class.new(board: board) }

        it 'returns true' do
          referee.instance_variable_set(:@checking_piece, white_queen)
          allow(black_king).to receive(:possible_movements)
          allow(black_king).to receive(:movements).and_return([[1, 4], [1, 3], [2, 3], [3, 3], [3, 4], [3, 5]])
          allow(black_king).to receive(:possible_captures)
          allow(black_king).to receive(:captures).and_return([[1, 5], [2, 5]])
          allow(black_rook).to receive(:possible_movements)
          allow(black_rook).to receive(:movements).and_return([[7, 0], [7, 1], [7, 2], [7, 3], [7, 5], [7, 6], [7, 7],
                                                               [6, 4], [5, 4], [4, 4], [3, 4]])
          allow(black_rook).to receive(:possible_captures)
          allow(black_rook).to receive(:captures).and_return([])
          allow(white_queen).to receive(:possible_movements)
          allow(white_queen).to receive(:movements).and_return([[3, 0], [3, 1], [3, 3], [3, 4], [3, 5], [0, 2], [1, 2],
                                                                [4, 2], [5, 2], [6, 2], [7, 2], [1, 0], [2, 1], [5, 0],
                                                                [4, 1], [2, 3], [1, 4], [0, 5]])
          allow(white_queen).to receive(:possible_captures)
          allow(white_queen).to receive(:captures).and_return([])
          allow(white_king).to receive(:possible_movements)
          allow(white_king).to receive(:movements).and_return([[2, 6], [4, 6], [4, 7]])
          allow(white_rook_1).to receive(:possible_movements)
          allow(white_rook_1).to receive(:movements).and_return([[1, 7]])
          allow(white_rook_1).to receive(:possible_captures)
          allow(white_rook_1).to receive(:captures).and_return([])
          allow(white_rook_2).to receive(:possible_movements)
          allow(white_rook_2).to receive(:movements).and_return([[4, 0], [4, 1], [4, 2], [4, 4], [4, 5], [4, 6], [4, 7],
                                                                 [0, 3], [1, 3], [2, 3], [3, 3], [5, 3], [6, 3], [7, 3]])
          allow(white_rook_2).to receive(:possible_captures)
          allow(white_rook_2).to receive(:captures).and_return([])
          allow(white_bishop).to receive(:movements)
          allow(white_bishop).to receive(:possible_movements).and_return([[1, 6], [0, 5]])
          allow(white_pawn_1).to receive(:movements)
          allow(white_pawn_1).to receive(:possible_movements).and_return([[0, 5], [0, 4]])
          allow(white_pawn_2).to receive(:movements)
          allow(white_pawn_2).to receive(:possible_movements).and_return([[1, 4]])
          allow(white_pawn_3).to receive(:movements)
          allow(white_pawn_3).to receive(:possible_movements).and_return([])
          allow(white_pawn_4).to receive(:movements)
          allow(white_pawn_4).to receive(:possible_movements).and_return([[3, 5], [3, 4]])
          expect(referee.mate?(black_king)).to be true
        end
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

    describe '#valid_castling?' do
      context 'black king and rook long castle' do
        let(:black_king) { instance_double(King, color: 'black', coordinate: [4, 0]) }
        let(:black_rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }
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
        subject(:referee) { described_class.new(board: board) }
        let(:player) { double('Player', name: 'Joe', color: 'black') }
        let(:selection) { 'long castle' }

        before do
          allow(black_rook).to receive(:moved).and_return false
          allow(black_king).to receive(:moved).and_return false
          allow(board).to receive(:find_king).with(player).and_return(black_king)
          allow(board).to receive(:find_rook).with(player, selection).and_return(black_rook)
          allow(board).to receive(:empty_tiles_between_king_and_rook?).and_return true
          allow(board).to receive(:tile_can_be_attacked?).and_return false
          allow(referee).to receive(:check?).with(black_king).and_return false
        end

        it 'returns true' do
          expect(referee.valid_castling?(selection, player)).to be true
        end
      end
      context 'long_castling for white king and rook' do
        let(:white_king) { instance_double(King, color: 'white', coordinate: [4, 7]) }
        let(:white_rook) { instance_double(Rook, color: 'white', coordinate: [0, 7]) }
        let(:white_bishop) { instance_double(Bishop, color: 'white', coordinate: [7, 2]) }
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
        subject(:referee) { described_class.new(board: board) }
        let(:player) { double('Player', name: 'Joe', color: 'white') }
        let(:selection) { 'long castle' }

        before do
          allow(white_rook).to receive(:moved).and_return false
          allow(white_king).to receive(:moved).and_return false
          allow(board).to receive(:find_king).with(player).and_return(white_king)
          allow(board).to receive(:find_rook).with(player, selection).and_return(white_rook)
          allow(board).to receive(:empty_tiles_between_king_and_rook?).and_return false
          allow(board).to receive(:tile_can_be_attacked?).and_return true
          allow(referee).to receive(:check?).with(white_king).and_return false
        end

        it 'returns false' do
          expect(referee.valid_castling?(selection, player)).to be false
        end
      end
    end
    describe '#king_castling_coordinate' do
      context 'white_king is short castling' do
        let(:referee) { described_class.new }
        let(:king) { instance_double(King, color: 'white', coordinate: [4, 7]) }

        it 'returns a coordinate' do
          selection = 'short castle'
          expect(referee.king_castling_coordinate(king, selection)).to eq([6, 7])
        end
      end
      context 'white_king is long castling' do
        let(:referee) { described_class.new }
        let(:king) { instance_double(King, color: 'white', coordinate: [4, 7]) }

        it 'returns a coordinate' do
          selection = 'long castle'
          expect(referee.king_castling_coordinate(king, selection)).to eq([2, 7])
        end
      end
    end
  end
end
