require_relative "./tile.rb"

class Board
    # Gives ten random positions inside the board grid
    def self.generate_random_positions
        positions_arr = []

        while positions_arr.length < 10
            row, col = rand(0...9), rand(0...9)
            position = [ row, col ]
            positions_arr << position unless positions_arr.include?(position)
        end

        positions_arr
    end

    attr_accessor :grid, :opened_tiles, :unflagged_tiles

    def initialize
        @grid = populate_grid
        @opened_tiles = []
        @unflagged_tiles = []
    end

    def populate_grid
        grid = Array.new(9) { Array.new(9) }

        # assign empty tile instance without bomb on each grid squares
        (0...9).each do |row|
            (0...9).each do |col|
                grid[row][col] = Tile.new(false)
            end
        end

        place_bombs_on_the_grid!(grid)

        grid
    end

    def place_bombs_on_the_grid!(grid)
        bomb_positions = Board.generate_random_positions
        
        bomb_positions.each do |position|
            row, col = position
            grid[row][col] = Tile.new(true)
        end
    end

    def [](position)
        row, col = position
        tile = grid[row][col]
        tile.to_s
    end

    # Gives all the tile values of a single row in string format separated by space
    def build_line_from_row(row_num)
        tile_values = []
        (0...9).each do |col_num|
            position = [ row_num, col_num ]
            tile_values << self[position]
        end
        tile_values.join(" ")
    end

    # Gives all the tile values of each grid row in string format for print
    def get_grid_lines
        grid_lines = []
        (0...9).each { |row_num| grid_lines << build_line_from_row(row_num) }
        grid_lines
    end

    # Renders the current state of the board to the screen
    def render
        grid_lines = get_grid_lines

        puts "  0 1 2 3 4 5 6 7 8"
        grid_lines.each_with_index do |grid_line, idx|
            puts "#{idx} #{grid_line}"
        end
        puts
    end

    def stepped_on_a_bomb?(position)
        row, col = position
        tile = grid[row][col]
        is_a_bomb?(tile) && !flagged(tile) && !recently_unflagged?(tile)
    end

    def is_a_bomb?(tile)
        tile.is_a_bomb?
    end

    def flagged(tile)
        tile.flagged
    end

    def recently_unflagged?(tile)
        if unflagged_tiles.include?(tile)
            unflagged_tiles.delete(tile)
            return true
        else
            return false
        end
    end

    def update_opened_tiles_list
        (0...9).each do |row|
            (0...9).each do |col|
                tile = grid[row][col]
                if opened_and_bomb_free?(tile) && !opened_tiles.include?(tile)
                    opened_tiles << tile
                end
            end
        end
    end

    def opened_and_bomb_free?(tile)
        !is_a_bomb?(tile) && !flagged(tile) && tile.revealed
    end

    def reveal_tile(position)
        row, col = position
        tile = grid[row][col]
        tile.try_reveal(grid)
        update_opened_tiles_list
    end

    def flag_tile(position)
        row, col = position
        tile = grid[row][col]
        tile.flag
    end

    def unflag_tile(position)
        row, col = position
        tile = grid[row][col]
        tile.unflag
        self.unflagged_tiles << tile
    end

    def opened_all_bomb_free_tiles?
        opened_tiles.length == 71
    end

    def a_random_bomb_free_tile_position
        until false
            row, col = rand(0...9), rand(0...9)
            position = [ row, col ]
            return position unless cheat_value(position) == "B"
        end
    end

    def cheat_value(position)
        row, col = position
        tile = grid[row][col]
        tile.to_s_cheat
    end
end