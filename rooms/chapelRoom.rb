class ChapelRoom
   
	def initialize(player)
		@player = player
    @reward = false
    @keep_going = true
	end
    
    def play
        while @keep_going
          describe
          get_action
        end
    end
    
    def describe
        puts "You stand in a small dark room with dimly lit candles illimunating"
        puts "just the basic features of the room. Upon closer inspection, you"
        puts "realize this room is a small chapel. In the dark corner of the room"
        puts "you notice as shadow figure as the sound of wimpering.  In the other"
        puts "corner, you notice a door lying half open.\n\n"
    end
    
    def get_action
        choice = Game.get_input

        if choice.include?("search") && !@reward
					puts "The only thing of interest is the shadowy figure. \n\n"
					puts 'Would you like to "approach" or "ignore" the figure?'
					puts "\n"
          search_action
        elsif choice.include?("search") && @reward
            puts "There is nothing else of interest to search. \n\n"
        elsif choice.include?("look")
            puts "Sure, I can describe the room again for you... pay close attention.\n\n"
        elsif choice.include?("eat")
            puts "There is nothing to eat here, dude\n\n"
        elsif choice.include?("door")
            @keep_going = false
        elsif choice.include?("die")
            Game.you_died("WTF, dude?")
        else
            puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
        end
    end
    
    def search_action
        choice = Game.get_input
        
        if choice.include?("approach")
					puts "You approach the shadowy figure and notice that it's actually a feeble old man."
					puts 'Would you like to "talk", "attack", or "ignore" him?'
					puts "\n"
					approach_action
				elsif choice.include?("ignore")
            puts "You ignore the shadowy figure.\n\n"
        else
            puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
        end
    end
	
	def approach_action
		choice = Game.get_input
		
		if choice.include?("talk")
      puts 'The old man congratulates you "Congratulations on making it this far, take'
      puts 'this as a reward".  The old man hands you the legendary Devout Shoulders of'
      puts "the gods.\n\n"
      @reward = true;
		elsif choice.include?("attack")
			puts "You prepare attack the old man.  Upond noticing this, the old man begins"
			puts "conjuring a green fireball in his hands.  This looks like it may be more"
			puts "difficult than you expected. \n\n"
			@player.fight("the feeble old man", 5, 1)
			puts "The slaughter the feeble old man.  Are you proud of what you've done? \n\n"
		elsif choice.include?("ignore")        
			puts "You ignore the shadowy figure.\n\n"
    else
			puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
		end
	end
	
end