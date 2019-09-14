class Tile
    attr_reader :bomb
    attr_accessor :visibility, :flagged, :val

    def initialize(bomb_indicator)
        @bomb = bomb_indicator
        @visibility = false
        @flagged = false
        @val = bomb_indicator ? 'B' : '_'
    end

    
end