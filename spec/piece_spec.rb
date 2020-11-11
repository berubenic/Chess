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
end
