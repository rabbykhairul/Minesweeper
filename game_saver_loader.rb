require "yaml"

class Game_saver_and_loader
    def save_game(game_instance)
        File.open("./minesweeper_memory.yml", "w") { |file| file.write(game_instance.to_yaml) }
    end
end