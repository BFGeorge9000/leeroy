class TreasureRoom
   
	def initialize(player)
		@player = player
		@treasure_room_key = false
		@keep_going = true
	end
    
    def play
        while @keep_going
            describe
            get_action
        end
    end
    
    def describe
        puts "You are standing in a room full of treasures, gold coins cover"
        puts "the floor. The walls, pillars, and ceiling are all trimmed in"
        puts "gold and you noticed several items of interest through the room."
        puts "You notice what appears to be a large treasure chest with golden"
        puts "accents, a large wooden door, a large golden vase adorned with gems,"
        puts "and a small, torn-up, dingy-looking cupboard in the corner.\n\n"
    end
    
    def get_action
        choice = Game.get_input

        if choice.include?("search")
            @first_room_key = true
            puts "What item would you like to search?\n"
            puts '"chest", "vase", or "cupboard"?'
            puts "\n"
            search_action
        elsif choice.include?("look")
            puts "Sure, I can describe the room again for you... pay close attention.\n\n"
        elsif choice.include?("eat")
            puts "There is nothing to eat here, dude\n\n"
        elsif choice.include?("door") && !@treasure_room_key
            puts "The door is LOCKED!\n\n"
        elsif choice.include?("door") && @treasure_room_key
            puts "The tumblers fall into place and the door swings open!"
            puts "You step into the next room...\n\n"
            @keep_going = false
        elsif choice.include?("die")
            Game.you_died("WTF, dude?")
        else
            puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
        end
    end
    
    def search_action
        choice = Game.get_input
        
        if choice.include?("chest")
            puts "You approach the chest. You quiver with excitement as you open"
            puts "the latch and lift the lid of the chest.  As the the chest is"
            puts "opening you notice something strange.  Large teeth are revealed"
            puts "as arms and legs also emerge from this once inanimate object."
            puts "At this moment you realize the chest is actually a mimic, but"
            puts "it's too late.  The mimic grabs you and quickly devours you.\n\n"
            Game.you_died("Sorry bro =[")
        elsif choice.include?("vase")
            puts "You search the expensive searching vase hoping to find something good."
            puts "As you reach into the vase, you begin feeling a strange sensation."
            puts "Your feel an evil presence coming from the vase as you feel your arm"
            puts "quickly being pulled in.  The vase warps your body, pulling the rest"
            puts "of your body in before fully sealing you inside.\n\n"
            Game.you_died("Your soul waits patiently in the vase awaiting the day it may somehow\nbe released")
        elsif choice.include?("cupboard") && !@treasure_room_key
            puts "You search the dingy looking cupboard for anything of interest and"
            puts "find a small silver key."
            puts "I wonder what this is for.\n\n"
            @treasure_room_key = true
        elsif choice.include?("cupboard") && @treasure_room_key
            puts "You have already found a key in this cupboard.  There is nothing"
            puts "else of interest.\n\n"
        else
            puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
        end
    end
    
end
