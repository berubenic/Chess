# frozen_string_literal: true

module Chess
  describe Referee do
    describe '#checkmate' do
      context 'white king can be captured by rook' do
        subject(:referee) { described_class.new }
        let(:king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }

        before do
          allow(king).to receive(:checkmate)
          allow(rook).to receive(:captures).and_return([[0, 7]])
        end

        it 'sends #checkmate to white king' do
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
          expect(king).to receive(:checkmate)
          referee.checkmate(king)
        end
      end
      context 'white king can not be captured by rook' do
        subject(:referee) { described_class.new }
        let(:king) { instance_double(King, color: 'white', coordinate: [0, 7]) }
        let(:rook) { instance_double(Rook, color: 'black', coordinate: [0, 0]) }

        before do
          allow(king).to receive(:not_checkmate)
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
          expect(king).to receive(:not_checkmate)
          referee.checkmate(king)
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
  end
end
