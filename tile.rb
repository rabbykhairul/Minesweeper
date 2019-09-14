class Tile
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

end