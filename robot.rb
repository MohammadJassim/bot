class Robot < Surface

  # constants
  NORTH = "N"
  SOUTH = "S"
  EAST = "E"
  WEST = "W"

  # attributes
  attr_accessor :x
  attr_accessor :y
  attr_accessor :f


  def initialize(x=0, y=0, f="N")
    self.x = x
    self.y = y
    self.f = f || default_direction
  end

  def move(x=0, y=0, f="N")
    v = Validator.new(["MOVE", x, y, f])
    unless v.errors
      move_x(x)
      move_y(y)
    end
  end

  def move_x(x)
    return if x == 0
    if x > 0 
      self.f = EAST
      (1..x).each do |s|
        self.x += 1 if self.x < 5 && right_move?(x) && !edge_move_x?(self.x + 1) 
        #turn_direction(self.f) # This can be used to turn around the robot if x > 4 instead of it stopping at the edge
      end
    else
      self.f = WEST
      (x...0).each do |s|
        self.x -= 1 if self.x > 0 && left_move?(x) && !edge_move_x?(self.x - 1)
        #turn_direction(self.f) # This can be used to turn around the robot if x > -4 instead of it stopping at the edge
      end
    end
    # return to default direction
    default_direction 
  end

  def move_y(y)
    return if y == 0 
    if y > 0
      self.f = NORTH
      (1..y).each do |s|
        self.y += 1 if self.y < 5 && up_move?(y) && !edge_move_y?(self.y + 1) 
        #turn_direction(self.f) # This can be used to turn around the robot if y > 4 instead of it stopping at the edge
      end
    else
      self.f = SOUTH
      (y...0).each do |s|
        self.y -= 1 if self.y > 0 && down_move?(y) && !edge_move_y?(self.y - 1)
        #turn_direction(self.f) # This can be used to turn around the robot if y > -4 instead of it stopping at the edge
      end
    end
    default_direction
  end

  def right_move?(x)
    x >= 0 && self.f != WEST
  end

  def left_move?(x)
    x < 0 || self.x - 1 == 4 || self.f == WEST || x < 0 && self.f != EAST 
  end

  def up_move?(y)
    y >= 0 && self.f != SOUTH # (self.f == "N" || self.f == "E" || self.f == "W")
  end

  def down_move?(y)
    y < 0 || self.f == SOUTH # || self.f != NORTH # (self.f == "S" || self.f == "E" || self.f == "W")
  end

  def edge_move_x?(x)
    (x == 5 && self.f != WEST) || (x == -1 && self.f != WEST)  #|| self.f == "E" || self.f == "W"  #|| self.x == -1 || self.y == 5 || self.y == -1
  end

  def edge_move_y?(y)
    (y == 5 && self.f == NORTH) || (y == -1 && self.f != SOUTH)
  end

  def turn_direction(f)
    self.f = possible_redirection(f)
  end

  def possible_redirection(f)
    return if self.y != 0 || self.y != 4 || self.x != 0 || self.x != 4
    self.f = NORTH if (self.y == 0 && f == SOUTH) || self.y >=0
    self.f = SOUTH if (self.y == 4 && f == NORTH) || self.y < 0
    self.f = EAST if (self.x == 0 && f == WEST) || self.x > 0
    self.f = WEST if (self.x == 4 && f == EAST) || self.x < 0
  end

  def default_direction
    self.f = NORTH
  end

  def current_location
    [self.x, self.y, self.f]
  end

  def valid_moves
    ["0", "1", "2", "3", "4", "N", "S", "E", "W"]
  end

end
