class SkeletonRoom
	def initialize(player)
		@player = player
    @fresh_game = true
    @first_room_key = false
    @keep_going = true
  end

  def play
    while @keep_going
      describe
      get_action
    end
  end

  def describe
    puts "You are standing in a room of what appears to be a castle,"
    puts "though you can't be sure.  There aren't exactly any windows"
    puts "to see outside, and only one door.  The walls are made of"
    puts "heavy stone blocks, and there is a skeleton still shackled"
    puts "to the wall... so that's probably not a good sign.\n\n"
    @fresh_game = false
  end

  def get_action
    choice = Game.get_input

    if choice.include?("search") && !@first_room_key
      @first_room_key = true
      puts "You found a key!  (What a terrible place to hide it...)\n\n"
    elsif choice.include?("look")
      puts "Sure, I can describe the room again for you... pay close attention.\n\n"
    elsif choice.include?("search") && @first_room_key
      puts "There doesn't appear to be anything more of interest.\n\n"
    elsif choice.include?("eat")
      puts "There is nothing to eat here, dude\n\n"
    elsif choice.include?("door") && !@first_room_key
      puts "The door is LOCKED!\n\n"
    elsif choice.include?("door") && @first_room_key
      puts "The tumblers fall into place and the door swings open!"
      puts "You step into the next room...\n\n"
      @keep_going = false
    elsif choice.include?("die")
      Game.you_died("WTF, dude?")
    else
      puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
    end
  end
end
