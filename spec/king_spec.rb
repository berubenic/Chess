# frozen_string_literal: true

# Knight spec
module Chess
  describe King do
    describe '#possible_movements' do
      context 'Board is empty except for Knight' do
        subject(:king) { described_class.new }

        it 'assigns @movements an array of possible moves when at [0, 0]' do
          board = [
            [king, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          king.instance_variable_set(:@board, board)
          king.instance_variable_set(:@coordinate, [0, 0])
          king.possible_movements
          expect(king.movements.include?([1, 0])).to be true
          expect(king.movements.include?([1, 1])).to be true
          expect(king.movements.include?([0, 1])).to be true
        end
      end
    end
  end
end
