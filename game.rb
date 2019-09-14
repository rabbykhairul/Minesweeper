require_relative "./board.rb"

class Game
    attr_reader :board
    attr_accessor :move_position

    def initialize
        @board = Board.new
        @move_position
    end

    def game_over?
        stepped_on_a_bomb? || opened_all_bomb_free_tiles?
    end

    def stepped_on_a_bomb?
        board.stepped_on_a_bomb?(move_position)
    end

    def opened_all_bomb_free_tiles?
        board.openen_all_bomb_free_tiles?
    end
end