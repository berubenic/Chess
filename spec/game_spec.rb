# frozen_string_literal: true

require_relative 'spec_helper'

# Game spec
module Chess
  describe Game do
    describe '#prepare_game' do
      let(:board) { instance_double(Board) }
      let(:player_one) { instance_double(Player) }
      let(:player_two) { instance_double(Player) }
      subject(:game) { described_class.new(board, player_one, player_two) }

      before do
        allow(board).to receive(:prepare_game)
        allow(player_one).to receive(:prepare_game)
        allow(player_two).to receive(:prepare_game)
      end

      it 'sends #prepare_game to board' do
        expect(board).to receive(:prepare_game)
        game.prepare_game
      end

      it 'sends #prepare_game to player_one' do
        expect(board).to receive(:prepare_game)
        game.prepare_game
      end

      it 'sends #prepare_game to player_two' do
        expect(board).to receive(:prepare_game)
        game.prepare_game
      end
    end
  end
end
