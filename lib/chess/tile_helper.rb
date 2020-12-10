# frozen_string_literal: true

module Chess
  # Utility functions for Board
  module BoardHelper
    module_function

    def find_tile(selection, array)
      array[selection[1]][selection[0]]
    end

    def tile_belongs_to_player?(color, tile)
      tile != '' || tile.color == color
    end
  end
end
