class Tile
    attr_reader :bomb
    attr_accessor :visible

    def initialize(bomb_indicator)
        @bomb = bomb_indicator
        @visible = false
        @flagged = false
    end
end