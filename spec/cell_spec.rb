# frozen_string_literal: true

require_relative 'spec_helper'

# Cell spec
module Chess
  describe Cell do
    describe '#create_pawn' do
      subject(:cell) { described_class.new(x_coordinate: 0, y_coordinate: 0) }

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

    describe '#create_rook' do
      subject(:cell) { described_class.new(x_coordinate: 1, y_coordinate: 1) }

      it 'assigns @content a instance of Rook' do
        color = 'some_color'
        cell.create_rook(color)
        expect(cell.content).to be_a(Rook)
      end

      it "assigns Rook's current_position to be the same as the Cell @coordinate it's being created in" do
        color = 'some_color'
        cell.create_rook(color)
        expect(cell.content.current_position).to eq(cell.coordinate)
      end

      it 'assigns Rook @color a color' do
        color = 'white'
        cell.create_rook(color)
        expect(cell.content.color).to eq(color)
      end
    end

    describe '#create_knight' do
      subject(:cell) { described_class.new(x_coordinate: 2, y_coordinate: 2) }

      it 'assigns @content a instance of Knight' do
        color = 'some_color'
        cell.create_knight(color)
        expect(cell.content).to be_a(Knight)
      end

      it "assigns Knight's current_position to be the same as the Cell @coordinate it's being created in" do
        color = 'some_color'
        cell.create_knight(color)
        expect(cell.content.current_position).to eq(cell.coordinate)
      end

      it 'assigns Knight @color a color' do
        color = 'white'
        cell.create_knight(color)
        expect(cell.content.color).to eq(color)
      end
    end

    describe '#create_bishop' do
      subject(:cell) { described_class.new(x_coordinate: 3, y_coordinate: 3) }

      it 'assigns @content a instance of Bishop' do
        color = 'some_color'
        cell.create_bishop(color)
        expect(cell.content).to be_a(Bishop)
      end

      it "assigns Bishop's current_position to be the same as the Cell @coordinate it's being created in" do
        color = 'some_color'
        cell.create_bishop(color)
        expect(cell.content.current_position).to eq(cell.coordinate)
      end

      it 'assigns Bishop @color a color' do
        color = 'white'
        cell.create_bishop(color)
        expect(cell.content.color).to eq(color)
      end
    end

    describe '#create_queen' do
      subject(:cell) { described_class.new(x_coordinate: 3, y_coordinate: 3) }

      it 'assigns @content a instance of Queen' do
        color = 'some_color'
        cell.create_queen(color)
        expect(cell.content).to be_a(Queen)
      end

      it "assigns Queen's current_position to be the same as the Cell @coordinate it's being created in" do
        color = 'some_color'
        cell.create_queen(color)
        expect(cell.content.current_position).to eq(cell.coordinate)
      end

      it 'assigns Queen @color a color' do
        color = 'white'
        cell.create_queen(color)
        expect(cell.content.color).to eq(color)
      end
    end

    describe '#create_king' do
      subject(:cell) { described_class.new(x_coordinate: 3, y_coordinate: 3) }

      it 'assigns @content a instance of King' do
        color = 'some_color'
        cell.create_king(color)
        expect(cell.content).to be_a(King)
      end

      it "assigns King's current_position to be the same as the Cell @coordinate it's being created in" do
        color = 'some_color'
        cell.create_king(color)
        expect(cell.content.current_position).to eq(cell.coordinate)
      end

      it 'assigns King @color a color' do
        color = 'white'
        cell.create_king(color)
        expect(cell.content.color).to eq(color)
      end
    end

    describe '#update_content' do
      subject(:cell) { described_class.new(x_coordinate: 0, y_coordinate: 0) }
      let(:piece) { instance_double(Piece) }

      before do
        allow(piece).to receive(:update_position)
      end

      it 'assigns @content and sends #update_position to content' do
        content = piece
        cell.update_content(content)
        expect(cell.content).to eq(content)
      end
    end

    describe '#toggle_highlight' do
      context 'cell.highlight is false' do
        subject(:cell) { described_class.new(x_coordinate: 0, y_coordinate: 0) }

        it 'assigns @highlight to be true' do
          cell.toggle_highlight
          expect(cell.highlight).to be true
        end
      end

      context 'cell.highlight is true' do
        subject(:cell) { described_class.new(x_coordinate: 0, y_coordinate: 0, highlight: true) }

        it 'assigns @highlight to be false' do
          cell.toggle_highlight
          expect(cell.highlight).to be false
        end
      end
    end
  end
end
