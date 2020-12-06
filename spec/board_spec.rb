# frozen_string_literal: true

require_relative 'spec_helper'

# Board spec
module Chess
  describe Board do
    describe '#initialize' do
      subject(:board) { described_class.new }
      it 'assigns @board an array of arrays' do
        array = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        expect(board.board).to eq(array)
      end
    end
    describe '#pawn_moved_two_squares?' do
      xit 'returns true' do
        expect(board.pawn_moved_two_squares?(action, selection)).to be true
      end
    end

    describe '#tiles_between_two_pieces' do
      let(:king) { instance_double(King, color: 'white', coordinate: [0, 0]) }
      let(:rook) { instance_double(Rook, color: 'white', coordinate: [7, 0]) }
      let(:array) do
        [
          [king, '', '', '', '', '', '', rook],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
      end
      subject(:board) { described_class.new(board: array) }

      it 'returns an array of tiles' do
        coordinate_one = king.coordinate
        coordinate_two = rook.coordinate
        direction = [1, 0]
        expect(board.tiles_between_two_pieces(coordinate_one, coordinate_two, direction)).to eq(['', '', '', '', '', ''])
      end
    end
    describe '#empty_tiles_between_king_and_rook?' do
      let(:king) { instance_double(King, color: 'white', coordinate: [0, 0]) }
      let(:rook) { instance_double(Rook, color: 'white', coordinate: [7, 0]) }
      let(:pawn) { instance_double(Pawn, color: 'white', coordinate: [4, 0]) }

      it 'returns true' do
        array =  [
          [king, '', '', '', '', '', '', rook],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        board = described_class.new(board: array)
        expect(board.empty_tiles_between_king_and_rook?(king, rook)).to be true
      end

      it 'returns false' do
        array =  [
          [king, '', '', '', pawn, '', '', rook],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ]
        board = described_class.new(board: array)
        expect(board.empty_tiles_between_king_and_rook?(king, rook)).to be false
      end
    end
    describe '#tile_can_be_attacked?' do
      let(:king) { instance_double(King, color: 'white', coordinate: [4, 7]) }
      let(:rook) { instance_double(Rook, color: 'white', coordinate: [7, 7]) }
      let(:pawn) { instance_double(Pawn, color: 'black', coordinate: [7, 6]) }

      it 'returns true' do
        array = [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', pawn],
          ['', '', '', '', king, '', '', rook]
        ]
        board = described_class.new(board: array)
        allow(pawn).to receive(:class).and_return(Pawn)
        allow(pawn).to receive(:can_attack_tile?).and_return true
        coordinate = [6, 7]
        expect(board.tile_can_be_attacked?(coordinate, king.color)).to be true
      end
    end
  end
end
