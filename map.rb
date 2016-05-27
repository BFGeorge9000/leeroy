class Map
  def initialize
		@player = Player.new
    @rooms = [ SkeletonRoom, SilverfishRoom, TreasureRoom, WispRoom, OgreRoom, ChapelRoom ]
  end

  def play
		@rooms = @rooms.shuffle
    @rooms.each do |room|
			room.new(@player).play
      Game.clear_screen
    end
    ChickenRoom.new.play 
  end
end
