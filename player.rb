class Player
    def initialize
        @move_wish
        @move_position
    end

    def get_move_wish
        display_prompt_and_get_command
        extract_move_wish_from_command
    end

    def display_prompt_and_get_command
        puts "Use `r` to reveal a tile"
        puts "Use `f` to flag a tile"
        puts "Use `u` to unflag a flagged tile"
        puts
        print "Enter tile position (e.g: r2,3): "
        receive_user_input_and_process_it
    end
end