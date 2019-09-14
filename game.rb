require_relative "./board.rb"

class Game
    attr_reader :board
    attr_accessor :move_position, :move_wish

    def initialize
        @board = Board.new
        @move_position = a_random_bomb_free_tile_position
        @move_wish
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

    def start_game
        play_turn until game_over?
    end

    def play_turn
        display_board
        move_wish = player.get_wish
        move_position = player.get_move_position
        execute_move_wish
    end

    def display_board
        system("clear")
        board.render
    end

    def display_game_over_message
        system("clear")
        board.render
        if won?
            puts "Great job! You cleared all mines"
        else
            puts "Boom! You stepped on a land mine"
        end
    end

    def execute_move_wish
        if wish_to_reveal_a_tile?
            reveal_tile_at_move_position
        elsif wish_to_flag_a_tile?
            flag_tile_at_move_position
        elsif wish_to_unflag_a_tile?
            unflag_tile_at_move_position
        end
    end

    def reveal_tile_at_move_position
        board.reveal_tile(move_position)
    end

    def flag_tile_at_move_position
        board.flag_tile(move_position)
    end

    def unflag_tile_at_move_position
        board.unflag_tile(move_position)
    end
    
    def wish_to_reveal_a_tile?
        move_wish == 'r'
    end

    def wish_to_flag_a_tile?
        move_wish == 'f'
    end

    def wish_to_unflag_a_tile?
        move_wish == 'u'
    end
end