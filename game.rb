require_relative "./board.rb"

class Game
    attr_reader :board
    attr_accessor :move_position

    def initialize
        @board = Board.new
        @move_position = a_random_bomb_free_tile_position
    end

    def a_random_bomb_free_tile_position
        board.a_random_bomb_free_tile_position
    end

    def game_over?
        stepped_on_a_bomb? || opened_all_bomb_free_tiles?
    end

    def stepped_on_a_bomb?
        board.stepped_on_a_bomb?(move_position)
    end

    def opened_all_bomb_free_tiles?
        board.opened_all_bomb_free_tiles?
    end

    def won?
        return true if opened_all_bomb_free_tiles?
        false
    end
end