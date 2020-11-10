# frozen_string_literal: true

require_relative 'spec_helper'

# Player spec
module Chess
  describe Player do
    describe '#input_name' do
      subject(:player) { described_class.new }

      it 'assigns player.name the input provided by the player' do
        allow(player).to receive(:player_input).and_return('John')
        player.input_name
        expect(player.name).to eq('John')
      end
    end

    describe '#assign_color' do
      subject(:player) { described_class.new }

      it 'assigns player.color the color provided' do
        color = 'some_color'
        player.assign_color(color)
        expect(player.color).to eq(color)
      end
    end

    describe '#switch_turn' do
      context 'player.turn is true' do
        subject(:player) { described_class.new(turn: false) }

        it 'assigns player.turn to true' do
          player.switch_turn
          expect(player.turn).to be true
        end
      end

      context 'player.turn is false' do
        subject(:player) { described_class.new(turn: true) }

        it 'assigns player.turn to false' do
          player.switch_turn
          expect(player.turn).to be false
        end
      end
    end
  end
end
