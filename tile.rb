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

    def self.get_adjacent_tiles(tile, grid)
        tile_positon = Tile.get_tile_position(tile, grid)
        tile_row, tile_col = tile_positon

        deltas = [
            [0,1], 
            [0,-1], 
            [1,0], 
            [-1,0], 
            [1,1], 
            [-1,1],
            [1, -1],
            [-1,-1]
        ]

        adjacent_tiles = []

        deltas.each do |delta|
            shift_row, shift_col = delta
            adjacent_row, adjacent_col = tile_row + shift_row, tile_col + shift_col
            if Tile.within_range?(adjacent_row, adjacent_col)
                adjacent_tiles << grid[adjacent_row][adjacent_col]
            end
        end

        adjacent_tiles
    end

    def self.has_any_adjacent_bomb?(tile, grid)
        adjacent_tiles = Tile.get_adjacent_tiles(tile, grid)
        adjacent_tiles.any? { |adjacent_tile| adjacent_tile.is_a_bomb? }
    end

    def self.count_adjacent_bombs(tile, grid)
        adjacent_tiles = Tile.get_adjacent_tiles(tile, grid)
        adjacent_tiles.count { |adjacent_tile| adjacent_tile.is_a_bomb? }
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

    def to_s_cheat
        val
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

    def reveal(grid)
        mark_as_visible
        if Tile.has_any_adjacent_bomb?(self, grid)
            count_fringe_and_set_value
        end
    end

    def count_fringe_and_set_value(grid)
        fringe_count = Tile.count_adjacent_bombs(self, grid)
        self.val = fringe_count.to_s
    end

    def reveal_all_adjacent_neighbors(grid)
        neighbor_tiles = Tile.get_adjacent_tiles(self, grid)
        neighbor_tiles.each { |neighbor_tile| neighbor_tile.reveal }
    end
end