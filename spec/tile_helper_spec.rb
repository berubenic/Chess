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
        expect(tile_helper.find_rook_for_long_castling(player, board)).to eq(rook)
      end
    end
  end
end
