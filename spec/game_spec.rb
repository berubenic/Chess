# frozen_string_literal: true

# Game spec
module Chess
  xdescribe Game do
    describe '#intro' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      context 'two_player_mode' do
        before do
          allow(game).to receive(:ask_game_mode).and_return(2)
          allow(game).to receive(:title_message)
          allow(game).to receive(:welcome_message)
        end
        it 'sends #two_player_mode to self' do
          expect(game).to receive(:two_player_mode)
          game.intro
        end
      end
    end
    describe '#two_player_mode' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        allow(game).to receive(:setup_two_player_game)
        allow(game).to receive(:player_selection_loop)
      end

      it 'sends setup_two_player_game to self' do
        expect(game).to receive(:setup_two_player_game)
        game.two_player_mode
      end

      it 'sends player_selection_loop to self' do
        expect(game).to receive(:player_selection_loop)
        game.two_player_mode
      end
    end
    describe '#setup_two_player_game' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        allow(game).to receive(:setup_two_players)
        allow(game).to receive(:setup_board)
        allow(game).to receive(:display_board)
        allow(game.board).to receive(:board)
      end

      it 'sends #setup_two_players to self' do
        expect(game).to receive(:setup_two_players)
        game.setup_two_player_game
      end

      it 'sends #setup_board to self' do
        expect(game).to receive(:setup_board)
        game.setup_two_player_game
      end
    end
    describe '#setup_two_players' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        allow(game).to receive(:create_player_one)
        allow(game).to receive(:create_player_two)
      end

      it 'sends #create_player_one to self' do
        expect(game).to receive(:create_player_one)
        game.setup_two_players
      end

      it 'sends #create_player_two to self' do
        expect(game).to receive(:create_player_two)
        game.setup_two_players
      end
    end
    describe '#create_player_one' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        name = 'some_name'
        allow(game).to receive(:ask_player_name).and_return(name)
        allow(game).to receive(:welcome_player_message)
      end

      it 'assigns @player_one' do
        game.create_player_one
        expect(game.player_one.name).to eq('some_name')
        expect(game.player_one.color).to eq('white')
      end
    end
    describe '#create_player_two' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        name = 'some_name'
        allow(game).to receive(:ask_player_name).and_return(name)
        allow(game).to receive(:welcome_player_message)
      end

      it 'assigns @player_two' do
        game.create_player_two
        expect(game.player_two.name).to eq('some_name')
        expect(game.player_two.color).to eq('black')
      end
    end
    describe '#setup_board' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        allow(game.board).to receive(:setup_board)
      end

      it 'sends #setup_board to Board' do
        expect(game.board).to receive(:setup_board)
        game.setup_board
      end
    end
    describe '#player_selection_loop' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        allow(game).to receive(:select_piece)
        allow(game).to receive(:translate_piece)
        game.instance_variable_set(:@selection, 'A7')
      end

      it 'returns when selection is valid' do
        allow(game.referee).to receive(:valid_selection?).and_return(true)
        game.player_selection_loop
      end

      it 'loops when selection is not valid' do
        allow(game.referee).to receive(:valid_selection?).and_return(false, false, true)
        allow(game).to receive(:invalid_selection_message)
        allow(game).to receive(:revert_selection)
        allow(game).to receive(:display_board)
        allow(game.board).to receive(:board)
        game.player_selection_loop
      end
    end
    describe '#select_piece' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      before do
        allow(game).to receive(:ask_to_select_piece).and_return('A7')
      end

      it 'assigns @selection a player input' do
        game.select_piece
        expect(game.selection).to eq('A7')
      end
    end
    describe '#translate_piece' do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board: board) }

      it "assigns @selection [0, 6] if @selection was 'A7'" do
        game.instance_variable_set(:@selection, 'A7')
        game.translate_piece
        expect(game.selection).to eq([0, 6])
      end

      it "assigns @selection false if @selection was 'AK'" do
        game.instance_variable_set(:@selection, 'AK')
        game.translate_piece
        expect(game.selection).to be false
      end
    end
  end
end
