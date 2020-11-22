# frozen_string_literal: true

module Chess
  describe Referee do
    describe '#checkmate' do
      context 'white king can be captured' do
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
    end
  end
end
