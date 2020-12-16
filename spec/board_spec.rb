# frozen_string_literal: true

# board specs
module Chess
  describe Board do
    subject(:board) { described_class.new }

    describe '#update_board' do
      let(:piece) { instance_double(Piece, current_coordinate: [1, 1]) }

      it 'changes the value of @array at given index' do
        action_coordinate = [0, 0]
        expect { board.update_board(action_coordinate, piece) }.to change { board.array[0][0] }.from('').to(piece)
      end
    end

    describe '#update_last_captured_piece' do
      context 'when the given coordinate is a String' do
        it 'assigns @last_captured_piece nil' do
          coordinate = [0, 0]
          expect { board.update_last_captured_piece(coordinate) }.not_to change(board, :last_captured_piece)
        end
      end

      context 'when the given coordinate is a Piece' do
        let(:piece) { instance_double(Piece, current_coordinate: [1, 1]) }

        it 'assigns @last_captured_piece the Piece' do
          coordinate = [0, 0]
          board.array[coordinate[1]][coordinate[0]] = piece
          expect { board.update_last_captured_piece(coordinate) }.to change(board, :last_captured_piece).from(nil).to(piece)
        end
      end
    end

    describe '#valid_action?' do
      context 'when @current_movements includes the given coordinate' do
        before do
          board.instance_variable_set(:@current_movements, [[0, 0]])
        end

        it 'returns true' do
          coordinate = [0, 0]
          expect(board.valid_action?(coordinate)).to be true
        end
      end

      context 'when @current_captures includes the given coordinate' do
        before do
          board.instance_variable_set(:@current_captures, [[0, 0]])
        end

        it 'returns true' do
          coordinate = [0, 0]
          expect(board.valid_action?(coordinate)).to be true
        end
      end

      context 'when neither @current_captures and @current_movements includes the given coordinate' do
        it 'returns false' do
          coordinate = [0, 0]
          expect(board.valid_action?(coordinate)).to be false
        end
      end
    end

    describe '#add_moves_and_captures' do
      let(:piece) { instance_double(BlackQueen) }
      let(:movements) { [[0, 0], [1, 1]] }
      let(:captures) { [[2, 2], [3, 3]] }

      context 'when the given piece can both move and capture' do
        before do
          allow(piece).to receive(:possible_movements).and_return(movements)
          allow(piece).to receive(:possible_captures).and_return(captures)
        end

        it 'assigns @current_movements an array of coordinates' do
          allow(board).to receive(:add_moves)
          allow(board).to receive(:add_captures)
          expect { board.add_moves_and_captures(piece) }.to change(board, :current_movements).from([]).to(movements)
        end

        it 'assigns @current_captures an array of coordinates' do
          allow(board).to receive(:add_moves)
          allow(board).to receive(:add_captures)
          expect { board.add_moves_and_captures(piece) }.to change(board, :current_captures).from([]).to(captures)
        end

        it 'sends #add_moves to self' do
          allow(board).to receive(:add_moves)
          allow(board).to receive(:add_captures)
          expect(board).to receive(:add_moves)
          board.add_moves_and_captures(piece)
        end

        it 'sends #add_captures to self' do
          allow(board).to receive(:add_moves)
          allow(board).to receive(:add_captures)
          expect(board).to receive(:add_captures)
          board.add_moves_and_captures(piece)
        end
      end

      context 'when the given piece has no captures' do
        before do
          allow(piece).to receive(:possible_movements).and_return(movements)
          allow(piece).to receive(:possible_captures).and_return([])
        end

        it 'does not change @current_captures' do
          expect { board.add_moves_and_captures(piece) }.not_to change(board, :current_captures)
        end

        it 'does not send #add_captures to self' do
          expect(board).not_to receive(:add_captures)
          board.add_moves_and_captures(piece)
        end
      end

      context 'when the given piece has no movements' do
        before do
          allow(piece).to receive(:possible_movements).and_return([])
          allow(piece).to receive(:possible_captures).and_return(captures)
        end

        it 'does not change @current_movements' do
          allow(board).to receive(:add_captures)
          expect { board.add_moves_and_captures(piece) }.not_to change(board, :current_movements)
        end

        it 'does not send #add_moves to self' do
          allow(board).to receive(:add_captures)
          expect(board).not_to receive(:add_moves)
          board.add_moves_and_captures(piece)
        end
      end
    end

    describe '#add_moves' do
      it 'sends #update_array to self with each element of @current_movements' do
        content = 'o'
        board.instance_variable_set(:@current_movements, [[1, 1]])
        expect(board).to receive(:update_array).with(board.current_movements[0], content)
        board.add_moves(content)
      end
    end

    describe '#update_array' do
      it 'updates @array at the given index with given content' do
        coordinate = [0, 0]
        content = 'o'
        expect { board.update_array(coordinate, content) }.to change { board.array[0][0] }.from('').to(content)
      end
    end

    describe '#add_captures' do
      it 'sends #update_capturable_piece to self with each element of @current_captures' do
        board.instance_variable_set(:@current_captures, [[1, 1]])
        expect(board).to receive(:update_capturable_piece).with(board.current_captures[0])
        board.add_captures
      end
    end

    describe '#update_capturable_piece' do
      let(:piece) { instance_double(Piece) }

      it 'sends #can_be_captures to a piece' do
        coordinate = [0, 0]
        board.array[0][0] = piece
        expect(piece).to receive(:can_be_captured)
        board.update_capturable_piece(coordinate)
      end
    end

    describe '#setup_white_pieces' do
      subject(:board) { described_class.new }

      before do
        board.setup_white_pieces
      end

      it 'updates all values of @array[6]' do
        expect(board.array[6].all? { |element| element.is_a?(WhitePawn) }).to be true
      end

      it 'updates value of @array[7][0]' do
        expect(board.array[7][0]).to be_a(WhiteRook)
      end

      it 'updates value of @array[7][1]' do
        expect(board.array[7][1]).to be_a(WhiteKnight)
      end

      it 'updates value of @array[7][2]' do
        expect(board.array[7][2]).to be_a(WhiteBishop)
      end

      it 'updates value of @array[7][3]' do
        expect(board.array[7][3]).to be_a(WhiteQueen)
      end

      it 'updates value of @array[7][4]' do
        expect(board.array[7][4]).to be_a(WhiteKing)
      end

      it 'updates value of @array[7][5]' do
        expect(board.array[7][5]).to be_a(WhiteBishop)
      end

      it 'updates value of @array[7][6]' do
        expect(board.array[7][6]).to be_a(WhiteKnight)
      end

      it 'updates value of @array[7][7]' do
        expect(board.array[7][7]).to be_a(WhiteRook)
      end
    end

    describe '#setup_black_pieces' do
      subject(:board) { described_class.new }

      before do
        board.setup_black_pieces
      end

      it 'updates all values of @array[1]' do
        expect(board.array[1].all? { |element| element.is_a?(BlackPawn) }).to be true
      end

      it 'updates value of @array[7][0]' do
        expect(board.array[0][0]).to be_a(BlackRook)
      end

      it 'updates value of @array[7][1]' do
        expect(board.array[0][1]).to be_a(BlackKnight)
      end

      it 'updates value of @array[7][2]' do
        expect(board.array[0][2]).to be_a(BlackBishop)
      end

      it 'updates value of @array[7][3]' do
        expect(board.array[0][3]).to be_a(BlackQueen)
      end

      it 'updates value of @array[7][4]' do
        expect(board.array[0][4]).to be_a(BlackKing)
      end

      it 'updates value of @array[7][5]' do
        expect(board.array[0][5]).to be_a(BlackBishop)
      end

      it 'updates value of @array[7][6]' do
        expect(board.array[0][6]).to be_a(BlackKnight)
      end

      it 'updates value of @array[7][7]' do
        expect(board.array[0][7]).to be_a(BlackRook)
      end
    end
  end
end
