# frozen_string_literal: true

module Chess
  describe Knight do
    describe '#possible_movements' do
      context 'Knight is at [0, 0]' do
        context 'Board is empty except for Knight' do
          subject(:knight) { described_class.new(x_coordinate: 0, y_coordinate: 0, color: 'white') }
          before do
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
          end

          it 'assign @movements an array with [1, 2] and [2, 1]' do
            knight.possible_movements
            expect(knight.movements.include?([1, 2])).to be true
            expect(knight.movements.include?([2, 1])).to be true
          end
        end
      end
    end
  end
end
