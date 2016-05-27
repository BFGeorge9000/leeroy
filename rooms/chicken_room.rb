class ChickenRoom
  def play
    puts "You enter a room full of freshly prepared chicken!"
    puts "You don't know how it got here - no one does! IT'S MAGIC CHICKEN!"
    puts "But who are you to second-guess free chicken? It smells DELICIOUS."
    end_game
  end

  def end_game
    sleep 3
    Game.clear_screen
    puts "Congratulations!  Leeroy found the magic chicken in the, um... castle."
    puts "So he gets to eat some chicken, I guess.  HOORAY!"
    puts "YOU WIN THE GAME.\n\n"
      
    puts "Aquired items:"
      if (!$sword && !$devout_shoulders)
          puts "nothing\n\n"
      end
      if ($sword)
          puts "sword\n\n"
      end
      if ($devout_shoulders)
          puts "devout shoulders\n\n"
      end
  end
end
