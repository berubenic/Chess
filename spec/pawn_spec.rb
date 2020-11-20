# frozen_string_literal: true

# Pawn

module Chess
  describe Pawn do
    describe '#possible_movements' do
      context 'Pawn is at starting square' do
        subject(:pawn) { described_class.new(color: 'white') }

        it 'assigns @movements an array of possible moves when at [0, 6]' do
          board = [
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            [pawn, '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', '']
          ]
          pawn.instance_variable_set(:@board, board)
          pawn.instance_variable_set(:@coordinate, [0, 6])
          pawn.possible_movements
          expect(pawn.movements.include?([0, 5])).to be true
          expect(pawn.movements.include?([0, 4])).to be true
        end
      end
    end
  end
end
