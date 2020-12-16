# frozen_string_literal: true

# Referee specs
module Chess
  describe Referee do
    subject(:referee) { described_class }

    describe '#check?' do
      context 'when king can be attacked' do
        let(:king) { instance_double(WhiteKing, current_coordinate: [4, 4]) }
        let(:enemy_rook) { instance_double(BlackRook, current_coordinate: [0, 4]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy_rook, '', '', '', king, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        before do
          allow(referee).to receive(:enemy_piece_in_row_can_attack_coordinate?).and_return(true)
        end

        it 'returns true' do
          expect(referee.check?(array, king)).to be true
        end
      end

      context 'when king can not be attacked' do
        let(:king) { instance_double(WhiteKing, current_coordinate: [4, 4]) }
        let(:enemy_rook) { instance_double(BlackRook, current_coordinate: [0, 5]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', king, '', '', ''],
            [enemy_rook, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        before do
          allow(referee).to receive(:enemy_piece_in_row_can_attack_coordinate?).and_return(false)
        end

        it 'returns false' do
          expect(referee.check?(array, king)).to be false
        end
      end
    end

    describe '#enemy_piece_in_row_can_attack_coordinate?' do
      context 'when a piece can attack the coordinate' do
        let(:king) { instance_double(WhiteKing, current_coordinate: [4, 4]) }
        let(:enemy_rook) { instance_double(BlackRook, current_coordinate: [0, 4]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [enemy_rook, '', '', '', king, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        before do
          allow(king).to receive(:possible_captures).and_return([])
          allow(enemy_rook).to receive(:possible_captures).and_return([[4, 4]])
        end

        it 'returns true' do
          row = array[4]
          coordinate = [4, 4]
          expect(referee.enemy_piece_in_row_can_attack_coordinate?(row, coordinate)).to be true
        end
      end

      context 'when a piece can not attack the coordinate' do
        let(:king) { instance_double(WhiteKing, current_coordinate: [4, 4]) }
        let(:enemy_rook) { instance_double(BlackRook, current_coordinate: [0, 5]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', king, '', '', ''],
            [enemy_rook, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        before do
          allow(king).to receive(:possible_captures).and_return([])
          allow(enemy_rook).to receive(:possible_captures).and_return([])
        end

        it 'returns false' do
          row = array[5]
          coordinate = [4, 4]
          expect(referee.enemy_piece_in_row_can_attack_coordinate?(row, coordinate)).to be false
        end
      end
    end

    describe '#king_or_rook_have_moved?' do
      let(:king) { instance_double(King) }
      let(:rook) { instance_double(Rook) }

      context 'when both king and rook have moved' do
        before do
          allow(king).to receive(:moved_from_initial_coordinate?).and_return true
          allow(rook).to receive(:moved_from_initial_coordinate?).and_return true
        end

        it 'returns true' do
          expect(referee.king_or_rook_have_moved?(king, rook)).to be true
        end
      end

      context 'when both king and rook have not moved' do
        before do
          allow(king).to receive(:moved_from_initial_coordinate?).and_return false
          allow(rook).to receive(:moved_from_initial_coordinate?).and_return false
        end

        it 'returns false' do
          expect(referee.king_or_rook_have_moved?(king, rook)).to be false
        end
      end

      context 'when either king or rook has moved' do
        before do
          allow(king).to receive(:moved_from_initial_coordinate?).and_return true
          allow(rook).to receive(:moved_from_initial_coordinate?).and_return false
        end

        it 'returns true' do
          expect(referee.king_or_rook_have_moved?(king, rook)).to be true
        end
      end
    end

    describe '#enemy_piece_in_row_can_discover_coordinate?' do
      context 'when a piece can discover the coordinate' do
        let(:enemy_king) { instance_double(WhiteKing, current_coordinate: [4, 4]) }
        let(:rook) { instance_double(BlackRook, current_coordinate: [0, 4]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', rook, '', '', '', ''],
            ['', '', '', '', enemy_king, '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        before do
          allow(enemy_king).to receive(:possible_discoveries).and_return([[4, 3], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5], [3, 4]])
          allow(rook).to receive(:color).and_return('black')
          allow(enemy_king).to receive(:color).and_return('white')
        end

        it 'returns true' do
          row = array[4]
          coordinate = [4, 3]
          color = 'black'
          expect(referee.enemy_piece_in_row_can_discover_coordinate?(row, coordinate, color)).to be true
        end
      end

      context 'when a piece can not discover the coordinate' do
        let(:enemy_king) { instance_double(WhiteKing, current_coordinate: [4, 4]) }
        let(:rook) { instance_double(BlackRook, current_coordinate: [0, 5]) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', enemy_king, '', '', ''],
            [rook, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        before do
          allow(enemy_king).to receive(:possible_discoveries).and_return([[4, 3], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5], [3, 4]])
          allow(rook).to receive(:color).and_return('black')
          allow(enemy_king).to receive(:color).and_return('white')
        end

        it 'returns false' do
          row = array[4]
          coordinate = [0, 4]
          color = 'black'
          expect(referee.enemy_piece_in_row_can_discover_coordinate?(row, coordinate, color)).to be false
        end
      end
    end

    describe '#castling_tile_can_be_attacked?' do
      let(:king) { instance_double(WhiteKing, color: 'white') }
      let(:rook) { instance_double(WhiteRook) }
      let(:enemy_pawn) { instance_double(BlackPawn) }

      before do
        allow(king).to receive(:castling_coordinate).with(rook)
        allow(king).to receive(:color).and_return('white')
      end

      context 'when #enemy_piece_in_row_can_discover_coordinate? returns true' do
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', enemy_pawn],
            ['', '', '', '', king, '', '', rook]
          ]
        end

        it 'returns true' do
          allow(referee).to receive(:enemy_piece_in_row_can_discover_coordinate?).and_return(false, false, false, false, false, false, true)
          expect(referee.castling_tile_can_be_attacked?(king, rook, array)).to be true
        end
      end

      context 'when #enemy_piece_in_row_can_discover_coordinate? only returns false' do
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', enemy_pawn],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', king, '', '', rook]
          ]
        end

        it 'returns false' do
          allow(referee).to receive(:enemy_piece_in_row_can_discover_coordinate?).and_return(false, false, false, false, false, false, false, false)
          expect(referee.castling_tile_can_be_attacked?(king, rook, array)).to be false
        end
      end
    end
  end
end
