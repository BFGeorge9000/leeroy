class ChapelRoom
   
    def initialize()
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

        if choice.include?("search") && !$devout_shoulders
            @first_room_key = true
            puts "There is nothing of interest to search.  Would you like to"
            puts "approach the shadowy figure?\n\n"
            search_action
        elsif choice.include?("search") && $devout_shoulders
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
        
        if choice.include?("yes")
            puts 'Upon approaching the shadowy figure, you notice it is actually an old man.'
            puts 'The old man congratulates you "Congratulations on making it this far, take'
            puts 'this as a reward".  The old man hands you the legendary Devout Shoulders of'
            puts "the gods.\n\n"
            $devout_shoulders = true;
        elsif choice.include?("no")
            puts "You ignore the shadowy figure.\n\n"
        else
            puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
        end
    end
    
    
end
