# frozen_string_literal: true

# Game spec
module Chess
  describe Game do
    subject(:game) { described_class.new }

    let(:display) { Display }
    let(:translator) { Translator }

    describe '#intro' do
      before do
        allow(display).to receive(:title_message)
        allow(display).to receive(:welcome_message)
      end

      context 'when #ask_game_mode returns 1' do
        before do
          allow(display).to receive(:ask_game_mode).and_return(1)
        end

        it 'sends #setup_game to self' do
          expect(game).to receive(:setup_game)
          game.intro
        end
      end

      context 'when #ask_game_mode returns 2' do
        before do
          allow(display).to receive(:ask_game_mode).and_return(2)
        end

        it 'sends #load_game to self' do
          expect(game).to receive(:load_game)
          game.intro
        end
      end
    end

    describe '#setup_game' do
      let(:board) { instance_double(Board) }

      subject(:game) { described_class.new(board: board) }

      before do
        allow(game).to receive(:setup_players)
        allow(display).to receive(:display_board)
        allow(game).to receive(:game_loop)
        allow(board).to receive(:array)
      end

      it 'sends #setup_board to Board' do
        expect(board).to receive(:setup_board)
        game.setup_game
      end
    end

    describe '#player_selection' do
      context 'when input is valid' do
        let(:selection) { 'A2' }

        before do
          allow(display).to receive(:ask_to_select_piece).and_return(selection)
          allow(translator).to receive(:valid_input?).with(selection).and_return(true)
        end

        it 'returns #translate_selection' do
          expect(game).to receive(:translate_selection).with(selection)
          game.player_selection
        end
      end

      context 'when input is invalid' do
        let(:selection) { 'some_input' }

        before do
          allow(display).to receive(:ask_to_select_piece).and_return(selection)
          allow(translator).to receive(:valid_input?).with(selection).and_return(false, false, true)
          allow(game).to receive(:translate_selection).with(selection).once
        end

        it 'loops until input is valid' do
          expect(display).to receive(:invalid_input_message).twice
          game.player_selection
        end
      end
    end

    describe '#translate_selection' do
      context "when selection is 's'" do
        it 'returns #save_game' do
          selection = 's'
          expect(game).to receive(:save_game)
          game.translate_selection(selection)
        end
      end

      context 'when selection is long castle' do
        it 'returns #add_moves_and_captures if valid' do
          selection = 'long castle'
          allow(game).to receive(:valid_selection?).and_return(true)
          expect(game).to receive(:add_moves_and_captures)
          game.translate_selection(selection)
        end
      end

      context 'when selection is short castle' do
        it 'returns #add_moves_and_captures if valid' do
          selection = 'short castle'
          allow(game).to receive(:valid_selection?).and_return(true)
          expect(game).to receive(:add_moves_and_captures)
          game.translate_selection(selection)
        end
      end

      context 'when selection is a coordinate' do
        it 'returns #add_moves_nad_captures if valid' do
          selection = 'a1'
          allow(translator).to receive(:translate)
          allow(game).to receive(:valid_selection?).and_return(true)
          expect(game).to receive(:add_moves_and_captures)
          game.translate_selection(selection)
        end
      end

      context 'when selection is invalid' do
        it 'returns #invalid_selection' do
          selection = 'some_invalid_coordinate'
          allow(translator).to receive(:translate)
          allow(game).to receive(:valid_selection?).and_return(false)
          expect(game).to receive(:invalid_selection)
          game.translate_selection(selection)
        end
      end
    end

    describe '#valid_selection?' do
      let(:tile_helper) { TileHelper }

      context 'when selection is a valid coordinate' do
        it 'returns true' do
          selection = 'some_valid_coordinate'
          color = 'white'
          allow(tile_helper).to receive(:find_tile)
          allow(tile_helper).to receive(:tile_belongs_to_player?).and_return(true)
          expect(game.valid_selection?(selection, color)).to be true
        end
      end

      context 'when selection is a unvalid coordinate' do
        it 'returns false' do
          selection = 'some_unvalid_coordinate'
          color = 'white'
          allow(tile_helper).to receive(:find_tile)
          allow(tile_helper).to receive(:tile_belongs_to_player?).and_return(false)
          expect(game.valid_selection?(selection, color)).to be false
        end
      end

      context 'when selection is a valid castling' do
        it 'returns true' do
          selection = 'short castle'
          color = 'white'
          allow(game).to receive(:valid_castling?).and_return(true)
          expect(game.valid_selection?(selection, color)).to be true
        end
      end

      context 'when selection is a unvalid castling' do
        it 'returns true' do
          selection = 'short castle'
          color = 'white'
          allow(game).to receive(:valid_castling?).and_return(false)
          expect(game.valid_selection?(selection, color)).to be false
        end
      end
    end
  end
end
