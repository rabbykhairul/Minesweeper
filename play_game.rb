require_relative "./game.rb"


puts "\t\tLOADING GAME..."
sleep(2)

game = Game.new
game.start_game
game.display_appropriate_message