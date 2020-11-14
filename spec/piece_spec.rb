# frozen_string_literal: true

require_relative 'spec_helper'

# Piece spec
module Chess
  describe Piece do
    describe '#update_position' do
      subject(:piece) { described_class.new(color: 'white', current_position: [0, 0]) }

      it 'assigns @current_position a coordinate' do
        coordinate = [1, 2]
        piece.update_position(coordinate)
        expect(piece.current_position).to eq(coordinate)
      end
    end
  end

  describe Pawn do
    describe '#possible_movement' do
      context 'white pawn is at A7' do
        subject(:pawn) { described_class.new(color: 'white', current_position: [0, 6]) }

        it "returns it's possible moves; [[0, 5], [0, 4]]" do
          expect(pawn.possible_movement).to eq([[0, 5], [0, 4]])
        end
      end
      context 'black pawn is at D2' do
        subject(:pawn) { described_class.new(color: 'black', current_position: [3, 1]) }

        it "returns it's possible moves; [[3, 2], [3, 3]]" do
          expect(pawn.possible_movement).to eq([[3, 2], [3, 3]])
        end
      end
    end
  end
end
