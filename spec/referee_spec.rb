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
        referee.instance_variable_set(:@black_king, black_king)
        black_king.instance_variable_set(:@check, true)
        expect(black_king).not_to receive(:mate)
        referee.mate(black_king)
      end
    end
  end
end
