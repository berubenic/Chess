# frozen_string_literal: true

# Bishop

module Chess
  describe Bishop do
    describe '#possible_movements' do
      context 'Board is empty except for bishop' do
        subject(:bishop) { described_class.new }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [bishop, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          bishop.instance_variable_set(:@board, board)
          bishop.instance_variable_set(:@coordinate, [0, 0])
          bishop.possible_movements
          expect(bishop.movements.include?([0, 1])).to be true
          expect(bishop.movements.include?([0, 2])).to be true
          expect(bishop.movements.include?([0, 3])).to be true
          expect(bishop.movements.include?([0, 4])).to be true
          expect(bishop.movements.include?([0, 5])).to be true
          expect(bishop.movements.include?([0, 6])).to be true
          expect(bishop.movements.include?([0, 7])).to be true
          expect(bishop.movements.include?([1, 0])).to be true
          expect(bishop.movements.include?([2, 0])).to be true
          expect(bishop.movements.include?([3, 0])).to be true
          expect(bishop.movements.include?([4, 0])).to be true
          expect(bishop.movements.include?([5, 0])).to be true
          expect(bishop.movements.include?([6, 0])).to be true
          expect(bishop.movements.include?([7, 0])).to be true
        end
      end
    end
  end
end
