class Wisp
	def initialize()
    @state = "Not implemented"
    @awareness = "asleep"
  end

  def getAwareness
    return @awareness
  end

  def setAwareness(awareness)
    @awareness = awareness
  end

  def state
    @state
  end

  def describe
    puts "Blue spirit that's " + @awareness + " and in a(n) " + @state + " state. "
  end
end

class WispRoom

	def initialize(player)
		  @player = player
      #2-7 wisps
      @wispCount = Random.rand(6) + 2
      @wisps = Array.new(0)
      @wispCount.times { @wisps.push(Wisp.new) }
      @inRoom = true
  end

  def play
    while(@inRoom) do
      describe
      get_action
    end
  end

  def describe
    puts "\nYou see a room with " + @wispCount.to_s + " wisps."
    @wisps.each { |wisp| wisp.describe }
  end

  def killWisp(wisp)
    @wisps.delete(wisp)
  end

  def allWispsSleeping
    for wisp in @wisps do
      if wisp.getAwareness == "awake"
        return false
      end
    end
    return true
  end

  def offendWisps
    wispsOffended = 0
    for wisp in @wisps do
      if Random.rand(2) == 0
        wisp.setAwareness("awake")
        wispsOffended += 1
      end
    end
    return wispsOffended
  end

  def dropWisps
    wispsDropped = 0
    for wisp in @wisps
      if(wisp.getAwareness == "awake")
        killWisp(wisp)
        wispsDropped += 1
      end
    end
    @wispCount -= wispsDropped
    return wispsDropped
  end

  def get_action
    input = Game.get_input
    if (input.include?("fight") || input.include?("disturb"))
      if @wispCount > 0
        puts "You dropped " + dropWisps.to_s + " wisps."
        puts "You offended " + offendWisps.to_s + " wisps."
      else
        puts "You're seeing things dude, there's nothing there."
      end
    elsif input.include?("leave")
      if @wispCount > 0 && !allWispsSleeping
        puts "You can't leave while you have wisps chasing you."
      else
        puts "You left the wisp room safely"
        @inRoom = false
      end
    else
      puts "Invalid actions."
      giveActionHints
    end
  end

  def giveActionHints
    puts "Available actions: fight, disturb, leave"
  end
end
