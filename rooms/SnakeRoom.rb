require 'io/console'

class SnakeUtils

  def self.get_key
    STDIN.getch
  end

  def self.clear_screen
    puts "\e[H\e[2J"
  end

end

class Actor
  attr_accessor :coords
  attr_accessor :image

  def initialize(coords, image = ".")
    @coords = coords if coords.is_a? Array
    @coords ||= [0,0]
    @image = image
  end

  def location_str
    "#{coords[0]}, #{coords[1]}"
  end

end

class Tail
  attr_accessor :length
  attr_accessor :bodyCoords
  attr_accessor :bodyImages

  def initialize(coords)
    @length = 0
    @bodyCoords = []
    @bodyImages = []
    grow!(coords)
  end

  def grow!(coords)
    @bodyCoords.push(coords)
    @length += 1
    if @length < 16
      @bodyImages.push(@length.to_s(16)[0])
    else
      @bodyImages.push('?')
    end
  end

  def step!(nextCoord)
    topCoord = nextCoord
    @bodyCoords.push(nextCoord)
    @bodyCoords.shift
  end

end

class Food < Actor
  def initialize(coords, image = '*')
    super
  end

  def reset(x_max, y_max)
    self.coords = [Random.rand(x_max), Random.rand(y_max)]
  end
end

class Snake < Actor
  attr_accessor :tail

  def initialize(coords)
    super
    @tail = Tail.new(coords)
  end

  def grow!(new_coords)
    @tail.grow!(new_coords)
    self.coords = new_coords
  end

  def up!
    self.coords[0] -= 1
    @tail.step!([coords[0], coords[1]])
  end

  def down!
    self.coords[0] += 1
    @tail.step!([coords[0], coords[1]])
  end

  def left!
    self.coords[1] -= 1
    @tail.step!([coords[0], coords[1]])
  end

  def right!
    self.coords[1] += 1
    @tail.step!([coords[0], coords[1]])
  end

  def print_body_members(rows)
    rows = rows.to_f
    for row in 0...rows do
      for col in 0...(@tail.length / rows).ceil do
        pos = (col * rows + row)
        print trail_string("#{@tail.bodyImages[pos]}: #{@tail.bodyCoords[pos]}", 12) if @tail.length > pos
      end
      puts '' if row != rows - 1
    end
  end

  def trail_string(str, size)
    if(size - str.length > 0)
      str + ' ' * (size - str.length)
    else
      str
    end
  end
end

class SnakeRoom
  X_MAX = 20
  Y_MAX = 10
  def initialize
    @food = Food.new([3, 6])
    @snake = Snake.new([5, 5])
    @grid = Array.new
    Y_MAX.times do
      @grid.push(Array.new(X_MAX, '-'))
    end
  end

  def play
    @keepGoing = true
    @debug_info_on = true
    update_grid
    SnakeUtils.clear_screen
    print_grid
    while @keepGoing do
      update_game
      update_grid
      SnakeUtils.clear_screen
      print_grid
    end
  end

  def update_game

    key = SnakeUtils.get_key.downcase
    case key
    when 'q'
      @keepGoing = false
    when 'a'
      if @snake.coords[0] != 0
        temp_coords = [@snake.coords[0] - 1, @snake.coords[1]]
        if food_collision?(temp_coords)
          @food.reset(X_MAX, Y_MAX)
          @snake.grow!(temp_coords)
        else
          @snake.up!
        end
      end
    when 'd'
      if @snake.coords[0] < X_MAX - 1
        temp_coords = [@snake.coords[0] + 1, @snake.coords[1]]
        if food_collision?(temp_coords)
          @food.reset(X_MAX, Y_MAX)
          @snake.grow!(temp_coords)
        else
          @snake.down!
        end
      end
    when 'w'
      if @snake.coords[1] != 0
        temp_coords = [@snake.coords[0], @snake.coords[1] - 1]
        if food_collision?(temp_coords)
          @food.reset(X_MAX, Y_MAX)
          @snake.grow!(temp_coords)
        else
          @snake.left!
        end
      end
    when 's'
      if @snake.coords[1] < Y_MAX - 1
        temp_coords = [@snake.coords[0], @snake.coords[1] + 1]
        if food_collision?(temp_coords)
          @food.reset(X_MAX, Y_MAX)
          @snake.grow!(temp_coords)
        else
          @snake.right!
        end
      end
    when 'x'
      @debug_info_on = !@debug_info_on
    else

    end
  end

  def food_collision?(new_coords)
    if new_coords == @food.coords
      true
    else
      false
    end
  end

  def print_grid
    print_header
    @grid.each do |row|
      row.each { |val| print val}
      puts ''
    end
    print_footer
    print_debug if @debug_info_on

  end

  def print_header
    ((X_MAX - 12) / 2.0).floor.times {print '='}
    print ' Snake Game '
    ((X_MAX - 12) / 2.0).ceil.times {print '='}
    puts ''
  end

  def print_footer
    puts "Score: #{@snake.tail.length}"
    puts ''
    puts 'Controls: '
    puts 'Move: WASD'
    puts 'Quit: Q'
    puts "Toggle Debug Info: X"
    puts ''
  end

  def print_debug
    puts "Debug: "
    @snake.print_body_members(5)
  end

  def clear_grid
    @grid.each do |row|
      row.map! { |val|  val = '-'}
      puts ''
    end
  end

  def update_grid
    clear_grid

    for i in 0...@snake.tail.length do
      bodyCoord = @snake.tail.bodyCoords[i]
      bodyImage = @snake.tail.bodyImages[i]
      @grid[bodyCoord[1]][bodyCoord[0]] = bodyImage
    end

    @grid[@food.coords[1]][@food.coords[0]] = @food.image
  end

end
