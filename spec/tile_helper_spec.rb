# frozen_string_literal: true

# TileHelper specs
module Chess
  describe TileHelper do
    subject(:tile_helper) { TileHelper }

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
  end
end
