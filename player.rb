class Player
    def initialize
        @move_wish
        @move_position
    end

    def get_move_wish
        display_prompt_and_get_command
        extract_move_wish_from_command
    end
end