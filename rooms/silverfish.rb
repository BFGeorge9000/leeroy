class SilverfishRoom
  ROCK_STATES = {
    "diamond"     => "There is a gleaming patch of crystal ahead",
    "gold"        => "There is shiny, metallic rock ahead",
    "iron"        => "There is some red-stained grey rock ahead",
    "cobblestone" => "There is plain, gray rock ahead.",
  }
  SILVERFISH_CHANCE = 0.5

	def initialize(player)
		@player = player
    @score = 0
  end

  def play
    describe
    mine
  end

  def describe
    Game.clear_screen
    puts "You are standing in a damp room, somewhere underground."
    puts "The room appears to be hewn from the subterranian rock."
    puts "Around you, water flows in small streams down the walls,"
    puts "and the sound of dripping is almost deafening. Adjacent"
    puts "to the doorway in which you stand, there is a pickaxe.\n"
  end

  def mine
    while true
      state = weighted_sample(ROCK_STATES.keys)

      puts
      puts ROCK_STATES[state]
      print "Mine? "

      if not yes?
        puts "You are done mining."
        puts
        puts "Your score is: #{@score}"
        return
      elsif silverfish?(state)
        Game.you_died "A silverfish attacks you, and you die."
        puts "Your score was: #{@score}"
        return
      else
        puts "You have mined some #{state}"
        @score += ROCK_STATES.keys.index(state)
      end
    end
  end

  def weighted_sample arr
    n = arr.length
    total = (2 ** n) - 1

    r = rand()
    (1..n).each do |i|
      return arr[i - 1] if r < ((2 ** i) - 1).to_f / total
    end
  end

  def silverfish? state
    state == "cobblestone" and rand > SILVERFISH_CHANCE
  end

  def yes?
    return ["y", "yes", "yeah", "sure"].include? gets.chomp.downcase
  end
end
