class Tile
    def self.within_range?(row, col)
        row.between?(0,8) && col.between?(0,8)
    end

    def self.get_tile_position(tile, grid)
        grid.each_with_index do |grid_row, row_index|
            grid_row.each_with_index do |current_grid_tile, col_index|
                return [ row_index, col_index ] if tile == current_grid_tile
            end
        end
    end

    attr_reader :bomb
    attr_accessor :visible, :flagged, :val

    def initialize(bomb_indicator)
        @bomb = bomb_indicator
        @visible = false
        @flagged = false
        @val = bomb_indicator ? 'B' : '_'
    end

    def to_s
        if opened_tile?
            val
        else
            '*'
        end
    end

    def opened_tile?
        visible && !flagged
    end

    def flag
        self.flagged = true
    end

    def unflag
        self.flagged = false
    end

    def is_a_bomb?
        self.bomb
    end

    def mark_as_visible
        self.visible = true
    end

    
end