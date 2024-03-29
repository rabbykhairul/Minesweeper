require_relative "./game.rb"


puts "================================="
puts "    Welcome to Minesweeper!!!    "
puts "================================="
puts
puts "Enter your choice: "
puts "\t1.New game"
puts "\t2.Resume"

choice = gets.chomp.to_i

puts "\t\tLOADING GAME..."
sleep(1)

if choice == 1
    game = Game.new
else
    begin
        game = Game.resume_saved_game
    rescue => error
        puts
        puts "Sorry!"
        puts "No previously saved game -:("
        puts
        return nil
    end
end

game.start_game
game.display_appropriate_message