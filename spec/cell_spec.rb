# frozen_string_literal: true

require_relative 'spec_helper'

# Cell spec
module Chess
  describe Cell do
    describe '#create_pawn' do
      subject(:cell) { described_class.new(0, 0) }

      it 'assigns @content a instance of Pawn' do
        color = 'some_color'
        cell.create_pawn(color)
        expect(cell.content).to be_a(Pawn)
      end

      it "assigns Pawn's @current_position to be the same as the Cell @coordinate it's being created in" do
        color = 'some_color'
        cell.create_pawn(color)
        expect(cell.content.current_position).to eq(cell.coordinate)
      end

      it 'assigns Pawn @color a color' do
        color = 'white'
        cell.create_pawn(color)
        expect(cell.content.color).to eq(color)
      end
    end
  end
end
