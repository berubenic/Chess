# frozen_string_literal: true

# TileHelper specs
module Chess
  describe TileHelper do
    subject(:tile_helper) { described_class }

    describe '#find_tile' do
      it 'returns a nested array value' do
        array = [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
        selection = [0, 1]
        result = 2
        expect(tile_helper.find_tile(selection, array)).to eq(result)
      end
    end

    describe '#not_occupied?' do
      context 'when tile is empty' do
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns true' do
          coordinate = [0, 0]
          expect(tile_helper.not_occupied?(coordinate, array)).to be true
        end
      end

      context 'when tile is occupied' do
        let(:piece) { instance_double(Piece) }
        let(:array) do
          [
            [piece, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns false' do
          coordinate = [0, 0]
          expect(tile_helper.not_occupied?(coordinate, array)).to be false
        end
      end
    end

    describe '#enemy_occupied?' do
      context 'when tile is an enemy piece' do
        let(:enemy) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns true' do
          coordinate = [0, 0]
          color = 'black'
          expect(tile_helper.enemy_occupied?(coordinate, array, color)).to be true
        end
      end

      context 'when tile is a friendly piece' do
        let(:friendly) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns false' do
          coordinate = [0, 0]
          color = 'black'
          expect(tile_helper.enemy_occupied?(coordinate, array, color)).to be false
        end
      end

      context 'when tile is empty' do
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns false' do
          coordinate = [0, 0]
          color = 'black'
          expect(tile_helper.enemy_occupied?(coordinate, array, color)).to be false
        end
      end
    end

    describe '#friendly_occupied?' do
      context 'when tile is a friendly piece' do
        let(:friendly) { instance_double(Piece, color: 'black') }
        let(:array) do
          [
            [friendly, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns true' do
          coordinate = [0, 0]
          color = 'black'
          expect(tile_helper.friendly_occupied?(coordinate, array, color)).to be true
        end
      end

      context 'when tile is an enemy piece' do
        let(:enemy) { instance_double(Piece, color: 'white') }
        let(:array) do
          [
            [enemy, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns false' do
          coordinate = [0, 0]
          color = 'black'
          expect(tile_helper.friendly_occupied?(coordinate, array, color)).to be false
        end
      end

      context 'when tile is empty' do
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
        end

        it 'returns false' do
          coordinate = [0, 0]
          color = 'black'
          expect(tile_helper.friendly_occupied?(coordinate, array, color)).to be false
        end
      end
    end

    describe '#tile_belongs_to_player?' do
      context 'when tile is empty' do
        it 'returns false' do
          tile = ''
          color = 'white'
          expect(tile_helper.tile_belongs_to_player?(color, tile)).to be false
        end
      end

      context 'when tile is a piece of the wrong color' do
        let(:piece) { instance_double(Piece, color: 'black') }

        it 'returns false' do
          tile = piece
          color = 'white'
          expect(tile_helper.tile_belongs_to_player?(color, tile)).to be false
        end
      end

      context 'when tile is a piece of the right color' do
        let(:piece) { instance_double(Piece, color: 'white') }

        it 'returns true' do
          tile = piece
          color = 'white'
          expect(tile_helper.tile_belongs_to_player?(color, tile)).to be true
        end
      end
    end

    describe '#find_king' do
      let(:player) { double('Player', color: 'white') }
      let(:king) { instance_double(King, color: 'white') }
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [king, '', '', '', '', '', '', '']
        ]
      end

      it 'returns king' do
        allow(king).to receive(:is_a?).with(String).and_return(false)
        allow(king).to receive(:is_a?).with(King).and_return(true)
        allow(king).to receive(:belongs_to_player?).with('white').and_return(true)
        expect(tile_helper.find_king(player, board)).to eq(king)
      end
    end

    describe '#find_piece_in_row' do
      let(:piece) { instance_double(BlackPawn) }
      let(:color) { 'black' }
      let(:piece_class) { Pawn }

      context 'when the piece is in the row' do
        it 'returns the piece' do
          row = ['', piece, '', '', '', '', '', '']
          allow(piece).to receive(:is_a?).with(String).and_return false
          allow(piece).to receive(:is_a?).with(piece_class).and_return true
          allow(piece).to receive(:belongs_to_player?).with(color).and_return true
          expect(tile_helper.find_piece_in_row(row, color, piece_class)).to eq(piece)
        end
      end

      context 'when the piece is not in the row' do
        it 'returns nil' do
          row = ['', '', '', '', '', '', '', '']
          expect(tile_helper.find_piece_in_row(row, color, piece_class)).to be nil
        end
      end
    end

    describe '#find_rook_for_castling' do
      let(:player) { double('Player') }
      let(:array) { [] }

      context 'when selection is short castle' do
        let(:selection) { 'short castle' }

        it 'sends find_rook_for_short_castling to self' do
          expect(tile_helper).to receive(:find_rook_for_short_castling).with(player, array)
          tile_helper.find_rook_for_castling(player, selection, array)
        end
      end

      context 'when selection is long castle' do
        let(:selection) { 'long castle' }

        it 'sends find_rook_for_long_castling' do
          expect(tile_helper).to receive(:find_rook_for_long_castling).with(player, array)
          tile_helper.find_rook_for_castling(player, selection, array)
        end
      end
    end

    describe '#find_rook_for_short_castling' do
      let(:player) { double('Player', color: 'white') }
      let(:rook) { instance_double(Rook, color: 'white', current_coordinate: [7, 7]) }
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', rook]
        ]
      end

      it 'returns rook' do
        allow(rook).to receive(:is_a?).with(String).and_return(false)
        allow(rook).to receive(:is_a?).with(Rook).and_return(true)
        allow(rook).to receive(:belongs_to_player?).with('white').and_return(true)
        allow(rook).to receive(:correct_x_coordinate_for_short_castling?).and_return true
        expect(tile_helper.find_rook_for_short_castling(player, board)).to eq(rook)
      end
    end

    describe '#find_rook_in_row_for_short_castling' do
      let(:piece_class) { Rook }
      let(:color) { 'black' }

      context 'when rook for short castling is in the row' do
        let(:rook) { instance_double(BlackRook) }
        let(:row) { ['', '', '', '', '', '', '', rook] }

        before do
          allow(rook).to receive(:is_a?).with(String).and_return false
          allow(rook).to receive(:is_a?).with(piece_class).and_return true
          allow(rook).to receive(:belongs_to_player?).with(color).and_return true
          allow(rook).to receive(:correct_x_coordinate_for_short_castling?).and_return true
        end

        it 'returns the rook' do
          expect(tile_helper.find_rook_in_row_for_short_castling(row, color, piece_class)).to eq(rook)
        end
      end

      context 'when rook for short castling is not in the row' do
        let(:row) { ['', '', '', '', '', '', '', ''] }

        it 'returns nil' do
          expect(tile_helper.find_rook_in_row_for_short_castling(row, color, piece_class)).to be nil
        end
      end
    end

    describe '#find_rook_for_long_castling' do
      let(:player) { double('Player', color: 'white') }
      let(:rook) { instance_double(Rook, color: 'white', current_coordinate: [0, 7]) }
      let(:board) do
        [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [rook, '', '', '', '', '', '', '']
        ]
      end

      it 'returns rook' do
        allow(rook).to receive(:is_a?).with(String).and_return(false)
        allow(rook).to receive(:is_a?).with(Rook).and_return(true)
        allow(rook).to receive(:belongs_to_player?).with('white').and_return(true)
        allow(rook).to receive(:correct_x_coordinate_for_long_castling?).and_return true
        expect(tile_helper.find_rook_for_long_castling(player, board)).to eq(rook)
      end
    end

    describe '#find_rook_in_row_for_long_castling' do
      let(:piece_class) { Rook }
      let(:color) { 'black' }

      context 'when rook for short castling is in the row' do
        let(:rook) { instance_double(BlackRook) }
        let(:row) { [rook, '', '', '', '', '', '', ''] }

        before do
          allow(rook).to receive(:is_a?).with(String).and_return false
          allow(rook).to receive(:is_a?).with(piece_class).and_return true
          allow(rook).to receive(:belongs_to_player?).with(color).and_return true
          allow(rook).to receive(:correct_x_coordinate_for_long_castling?).and_return true
        end

        it 'returns the rook' do
          expect(tile_helper.find_rook_in_row_for_long_castling(row, color, piece_class)).to eq(rook)
        end
      end

      context 'when rook for short castling is not in the row' do
        let(:row) { ['', '', '', '', '', '', '', ''] }

        it 'returns nil' do
          expect(tile_helper.find_rook_in_row_for_long_castling(row, color, piece_class)).to be nil
        end
      end
    end

    describe '#tile_between_king_and_rook_are_not_empty?' do
      context 'when tiles are empty' do
        let(:king) { instance_double(WhiteKing) }
        let(:rook) { instance_double(WhiteRook) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', king, '', '', rook]
          ]
        end

        before do
          allow(rook).to receive(:empty_coordinates_needed_for_castling).and_return([[6, 7], [5, 7]])
        end

        it 'returns false' do
          expect(tile_helper.tile_between_king_and_rook_are_not_empty?(rook, array)).to be false
        end
      end

      context 'when tiles are not empty' do
        let(:king) { instance_double(WhiteKing) }
        let(:rook) { instance_double(WhiteRook) }
        let(:knight) { instance_double(WhiteKnight) }
        let(:array) do
          [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', king, '', knight, rook]
          ]
        end

        before do
          allow(rook).to receive(:empty_coordinates_needed_for_castling).and_return([[6, 7], [5, 7]])
        end

        it 'returns true' do
          expect(tile_helper.tile_between_king_and_rook_are_not_empty?(rook, array)).to be true
        end
      end
    end
  end
end
