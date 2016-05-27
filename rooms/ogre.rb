class OgreRoom
  def initialize
    @mound = false
    @keep_going = true
  end

  def play
    while @keep_going do
      describe
      get_action
    end
  end

  def describe
    puts "You find yourself in a mossy covered room with"
    puts "an overwhelming stench causing you to gag."
    puts "You can't see any doors based on your first observation, "
    puts "but you see a dark mound against one of the walls."
  end

  def get_action
    choice = Game.get_input
    
    if choice.include?("search") && !$sword
      puts "You find a mighty sword and you now grip it in your hand!\n\n"
      $sword = true    
    elsif choice.include?("search") && $sword && !@mound
      puts "You see what appears to be a faint outline of a door behind the large mound.\n\n"
    elsif choice.include?("search") && $sword && @mound
      puts "You don't find any items of interest..."
    elsif choice.include?("look") && !@mound
      puts "You see that the mound is moving...almost as if it's breathing!\n\n"
      @mound = true
    elsif choice.include?("look") && @mound
      puts "You see the faint outline of a door behind the large creature.\n"
      puts "If only I could get closer...\n\n"
    elsif choice.include?("sneak") && !@mound
      puts "You accidentally hit a rock that echoes throughout the room.\n"
      puts "Something begins to stir...\n\n"
    elsif choice.include?("sneak") && @mound
      puts "You quietly move closer to the breathing creature to get a better look.\n"
      puts "You realize that the horrible stench is actually a sleeping ogre\n\n"
    elsif choice.include?("attack") && !$sword && !@mound
      puts "The mound awakes and to your amazement it is a terrifying ogre!\n"
      puts "It swings its meaty first your way, clobbering you in the head.\n"
      Game.you_died("WTF, dude?")
    elsif choice.include?("attack") && $sword && !@mound
      puts "The mound awakes and to your realization it is a terrifying ogre, but you're prepared.\n"
      puts "You swing your mighty sword its way, and it lets out a terrible cry\n"
      puts "The nasty beast has been slain! Your path to a now visible door is clear."
    elsif choice.include?("attack") && $sword && @mound
      puts "You quietly approach the sleeping ogre, \n" 
      puts "and drive your sword straight through its heart.\n"
      puts "The nasty beast has been slain! Your path to a now visible door is clear.\n\n"
      @ogre = true
    elsif choice.include?("door") && !@ogre
      puts "Something is blocking your way!\n\n"
    elsif choice.include?("door") && @ogre
      puts ""
      puts "You step into the next room...\n\n"
      @keep_going = false
    elsif choice.include?("die")
      Game.you_died("WTF, dude?")
    else
      puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
    end
  end
end
