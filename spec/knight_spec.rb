# frozen_string_literal: true

# rubocop:disable all

module Chess
  describe Knight do
    describe '#possible_movements' do
      context 'Knight is at [0, 0]' do
        context 'Board is empty except for Knight' do
          subject(:knight) { described_class.new }
          it 'assign @movements an array of possible moves when at [0, 0]' do
            board = [
              [knight, '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            knight.possible_movements
            expect(knight.movements.include?([1, 2])).to be true
            expect(knight.movements.include?([2, 1])).to be true
          end

          it 'assigns @movements an array of possible moves when at [3, 3]' do
            board = [
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', knight, '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [3, 3])
            knight.possible_movements
            expect(knight.movements.include?([2, 1])).to be true
            expect(knight.movements.include?([4, 1])).to be true
            expect(knight.movements.include?([5, 2])).to be true
            expect(knight.movements.include?([4, 5])).to be true
            expect(knight.movements.include?([5, 4])).to be true
            expect(knight.movements.include?([2, 5])).to be true
            expect(knight.movements.include?([1, 4])).to be true
            expect(knight.movements.include?([1, 2])).to be true
          end
        end
        context "A friendly piece occupies one of it's possible moves" do
          subject(:knight) { described_class.new(color: 'white') }
          let(:friendly) { described_class.new(color: 'white') }

          it 'assigns @movements an array of possible moves when at [0, 0]' do
            board = [
              [knight, '', '', '', '', '', '', ''],
              ['', '', friendly, '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ]
            knight.instance_variable_set(:@board, board)
            knight.instance_variable_set(:@coordinate, [0, 0])
            friendly.instance_variable_set(:@coordinate, [2, 1])
            knight.possible_movements
            expect(knight.movements.include?([1, 2])).to be true
            expect(knight.movements.include?([2, 1])).to be false
          end
        end
      end
    end
  end
end
