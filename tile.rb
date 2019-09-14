class Tile
    attr_reader :bomb
    attr_accessor :visibility, :flagged, :val

    def initialize(bomb_indicator)
        @bomb = bomb_indicator
        @visibility = false
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
end