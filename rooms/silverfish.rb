class SilverfishRoom
  MAP_LENGTH = 9
  MAP_WIDTH = 9

  def initialize
    @score = 0
    @pickaxe = false
    @map = MineMap.new(MAP_WIDTH, MAP_LENGTH)
  end

  def play
    describe

    while not @map.player_escaped?
      rock = @map.get_rock_ahead

      if @pickaxe
        @map.print_map

        if rock
          puts rock.description
        else
          puts "There is nothing in front of you"
        end
      end

      choice = Game.get_input

      if choice.include? "mine"
        if @pickaxe
          @score += @map.mine
          sleep 1
        else
          puts "With what, your hands!?\n\n"
        end
      elsif choice.include? "left"
        @map.turn_left
      elsif choice.include? "right"
        @map.turn_right
      elsif choice.include? "turn around"
        @map.turn_around
      elsif choice.include? "move"
        if rock
          puts "There's a rock there!"
        else
          @map.move_forward
        end
      elsif choice.include? "search"
        if @pickaxe
          puts "You do not find anything new\n\n"
        else
          puts "You have discovered a pickaxe!\n\n"
          sleep 1
          @pickaxe = true
        end
      elsif choice.include? "door"
        puts "The door is locked\n\n"
      else
        puts "Sorry, I have no idea what you're talking about. Maybe try rephrasing?\n\n"
      end

      Game.clear_screen if @pickaxe
    end
  end

  private #####################################################################

  def describe
    puts "You are standing in a damp room, somewhere underground."
    puts "Around you, water flows in small streams down the walls,"
    puts "and the sound of dripping is almost deafening. The room"
    puts "appears to be hewn from the subterranian rock. Suddenly,"
    puts "the door slams shut behind you.\n\n"
  end
end

class MineMap
  DIRECTIONS = {
    north: 0,
    east:  1,
    south: 2,
    west:  3
  }

  def initialize(width, length)
    @width = width
    @length = length
    @map = generate_map
    @coords = Array.new(2)
    @direction = DIRECTIONS[:north]
    move_player(width / 2, length - 1)
  end

  def move_player(x, y)
    @map[x][y] = nil
    @coords = [x, y]
  end

  def mine
    rock = get_rock_ahead

    if rock.nil?
      puts "There's nothing there to mine, dummy!"
      return 0
    end

    if rock.silverfish?
      puts "Your score was: #{@score}"
      Game.you_died "A silverfish attacks you, and you die."
    end

    puts "You have mined some #{rock.name}\n\n"
    remove_rock_ahead
    move_forward
    return rock.score
  end

  def remove_rock_ahead
    remove_rock get_coords_ahead
  end

  def get_rock_ahead
    rock_coords = get_coords_ahead
    @map[rock_coords[0]][rock_coords[1]] unless out_of_bounds? rock_coords
  end

  def move_forward
    new_coords = get_coords_ahead
    @coords = new_coords
  end

  def player_escaped?
    @coords[0] == 0 ||
      @coords[1] == 0 ||
      @coords[0] == @length - 1
  end

  def turn_left
    @direction -= 1
    @direction = 3 if @direction == -1
  end

  def turn_right
    @direction += 1
    @direction = 0 if @direction == 4
  end

  def turn_around
    @direction += 2
    @direction = @direction - 4 if @direction > 3
  end

  def face(direction)
    @direction = direction
  end

  def print_map
    (0...@length).each do |y|
      (0...@width).each do |x|
        print "+"

        if @map[x][y].nil? and !get_rock_ahead_in_direction [x, y], DIRECTIONS[:north]
          print "   "
        else
          print "---"
        end
      end

      puts "+"

      (0...@width).each do |x|
        if @map[x][y].nil? and !get_rock_ahead_in_direction [x, y], DIRECTIONS[:west]
          print " "
        else
          print "|"
        end
        print " "
        if @map[x][y] and [x, y] == get_coords_ahead
          print @map[x][y].abbr
        elsif [x, y] == @coords
          print player_symbol
        else
          print " "
        end
        print " "
      end

      puts "|"
    end

    puts Array.new(@width + 1) { "+" }.join("---")
  end

  private #####################################################################

  def out_of_bounds? coords
    @coords[0] < 0 ||
      @coords[1] < 0 ||
      @coords[0] >= @width ||
      @coords[1] >= @length
  end

  def remove_rock(coords)
    @map[coords[0]][coords[1]] = nil
  end

  def player_symbol
    case @direction
    when DIRECTIONS[:north]
      "^"
    when DIRECTIONS[:east]
      ">"
    when DIRECTIONS[:south]
      "v"
    when DIRECTIONS[:west]
      "<"
    end
  end

  def get_coords_ahead
    get_coords_ahead_in_direction @coords, @direction
  end

  def get_coords_ahead_in_direction coords, direction
    case direction
    when DIRECTIONS[:north]
      [coords[0], coords[1] - 1]
    when DIRECTIONS[:east]
      [coords[0] + 1, coords[1]]
    when DIRECTIONS[:south]
      [coords[0], coords[1] + 1]
    when DIRECTIONS[:west]
      [coords[0] - 1, coords[1]]
    end
  end

  def get_rock_ahead_in_direction coords, direction
    coords = get_coords_ahead_in_direction coords, direction
    return nil if out_of_bounds? coords
    @map[coords[0]][coords[1]]
  end

  def generate_map
    map = Array.new(@width) { Array.new(@length) } # X, Y
    (0...@width).each do |x|
      (0...@length).each do |y|
        map[x][y] = Rock.new
      end
    end
    return map
  end
end

class Rock
  ROCK_STATES = {
    "diamond" =>      "There is a gleaming patch of crystal ahead",
    "gold" =>         "There is shiny, metallic rock ahead",
    "iron" =>         "There is some red-stained grey rock ahead",
    "cobblestone" =>  "There is plain, gray rock ahead.",
  }
  SILVERFISH_CHANCE = 0.5

  attr_reader :name

  def initialize
    @name = weighted_sample ROCK_STATES.keys
  end

  def silverfish?
    @name == "cobblestone" and rand > SILVERFISH_CHANCE
  end

  def description
    ROCK_STATES[@name]
  end

  def score
    ROCK_STATES.keys.index(@name)
  end

  def abbr
    @name[0]
  end

  private #####################################################################

  def weighted_sample arr
    n = arr.length
    total = (2 ** n) - 1

    r = rand()
    (1..n).each do |i|
      return arr[i - 1] if r < ((2 ** i) - 1).to_f / total
    end
  end
end
