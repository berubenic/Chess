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

    describe '#valid_select?' do
      let(:board) { instance_double(Board) }
      let(:player_one) { instance_double(Player) }
      let(:player_two) { instance_double(Player) }
      subject(:game) { described_class.new(board, player_one, player_two) }

      before do
        allow(board).to receive(:valid_select?)
        allow(player_one).to receive(:turn).and_return(true)
        allow(player_one).to receive(:color).and_return('white')
      end

      it 'sends #valid_select to board' do
        expect(board).to receive(:valid_select?)
        game.valid_select?
      end
    end

    describe '#convert_move' do
      subject(:game) { described_class.new }

      it 'converts a8 to [0, 7]' do
        game.instance_variable_set(:@move, 'a8')
        game.convert_move
        expect(game.move).to eq([0, 7])
      end

      it 'converts h1 to [7, 0]' do
        game.instance_variable_set(:@move, 'h1')
        game.convert_move
        expect(game.move).to eq([7, 0])
      end
    end

    describe '#highlight_move' do
      let(:board) { instance_double(Board) }
      let(:player_one) { instance_double(Player) }
      let(:player_two) { instance_double(Player) }
      subject(:game) { described_class.new(board, player_one, player_two) }

      before do
        allow(board).to receive(:highlight_move)
      end

      it 'sends #highlight_move to board' do
        expect(board).to receive(:highlight_move)
        game.highlight_move
      end
    end

    describe '#possible_moves' do
      let(:board) { instance_double(Board) }
      let(:player_one) { instance_double(Player) }
      let(:player_two) { instance_double(Player) }
      subject(:game) { described_class.new(board, player_one, player_two) }

      before do
        allow(board).to receive(:possible_moves)
      end

      it 'sends #possible_moves to board' do
        expect(board).to receive(:possible_moves)
        game.possible_moves
      end
    end
  end
end
