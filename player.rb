class Player
    def initialize
        @move_wish
        @move_position
    end

    def get_move_wish
        display_prompt_and_get_command
        @move_wish
    end

    def display_prompt_and_get_command
        puts "Use `r` to reveal a tile"
        puts "Use `f` to flag a tile"
        puts "Use `u` to unflag a flagged tile"
        puts
        print "Enter tile position (e.g: r2,3): "
        receive_user_input_and_process_it
    end

    def receive_user_input_and_process_it
        input_command = gets.chomp
        @move_wish = input_command[0].downcase
        @move_position = extract_position_value(input_command[1..-1])
    end

    def extract_position_value(position_string)
        position_arr = position_string.split(",")
        position_arr.map(&:to_i)
    end
end