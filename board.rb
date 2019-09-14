require_relative "./tile.rb"

class Board
    def initialize
        @grid = populate_grid
        @opened_tiles_count = 0
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
end