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

    describe '#select_piece' do
      let(:board) { instance_double(Board) }
      let(:player_one) { instance_double(Player) }
      let(:player_two) { instance_double(Player) }
      subject(:game) { described_class.new(board, player_one, player_two) }

      context 'player_one.turn is true and player_two.turn is false' do
        before do
          allow(player_one).to receive(:select_piece).and_return('some_move')
          allow(player_one).to receive(:turn).and_return(true)
          allow(player_two).to receive(:select_piece)
          allow(player_two).to receive(:turn).and_return(false)
        end

        it 'sends the #play_turn message to player_one' do
          expect(player_one).to receive(:select_piece)
          game.select_piece
        end

        it 'does not send the #play_turn message to player_two' do
          expect(player_two).not_to receive(:select_piece)
          game.select_piece
        end

        it 'assigns @move' do
          game.select_piece
          expect(game.move).not_to be nil
        end
      end

      context 'player_one.turn is false and player_two.turn is true' do
        before do
          allow(player_one).to receive(:select_piece)
          allow(player_one).to receive(:turn).and_return(false)
          allow(player_two).to receive(:select_piece).and_return('some_move')
          allow(player_two).to receive(:turn).and_return(true)
        end

        it 'does not send the #play_turn message to player_one' do
          expect(player_one).not_to receive(:select_piece)
          game.select_piece
        end

        it 'sends the #play_turn message to player_two' do
          expect(player_two).to receive(:select_piece)
          game.select_piece
        end

        it 'assigns @move' do
          game.select_piece
          expect(game.move).not_to be nil
        end
      end
    end
  end
end
