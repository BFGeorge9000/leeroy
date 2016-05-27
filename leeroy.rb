require_relative "map"
require_relative "player"

class Game

  def self.get_input
    print "--What do? >"
    return $stdin.gets.chomp
  end

  def self.clear_screen
    puts "\e[H\e[2J"
  end

  def self.you_died(message = "Your actions have led to Leeroy's death.\n\n")
    puts message
    puts "Leeroy died pursuing what he loved most.\n\nChicken.\n\nGameover, man.\n\n ;_;"
    exit
  end

  def initialize
    Dir.glob("rooms/*.rb").each do |file|
      require_relative file
    end

    Game.clear_screen
    puts "============================================================"
    puts "              THE ADVENTURES OF LEEROY JENKINS"
    puts "             Chapter I - The Search for Chicken"
    puts "============================================================"
    puts "You wake up from a deep sleep and realize you are very, very"
    puts "hungry.  You need to find some chicken to eat.\n\n"
    puts "THAT'S THE POINT OF THIS GAME: FIND SOME CHICKEN TO EAT.\n\n"
    Map.new.play
    true
  end
end
