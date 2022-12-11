
require_relative 'validator.rb'
require_relative 'surface.rb'
require_relative 'robot.rb'

# Prompt user input
run = true
placed = false
r = Robot

def validate_command(command)
  command.is_a?(Array) && command.length < 2 ? false : true
  command[0].strip.upcase == "PLACE"  
end

def process_command(command)
  # draw the surface (this is in class validator.rb)
  s = Surface.new
  s.draw_surface

  # Validate the input
  v = Validator.new(command)

  unless v.errors 
    placed = command[0].strip.upcase == "PLACE" unless placed

    if placed
      r = Robot.new unless r
      puts r.inspect
    end

    puts "Robot must be placed first" unless r

    if r && placed
      r.x = command[1] if command[1]
      r.y = command[2] if command[2]
      r.f = command[3] if command[3]
    end

    move = command[0].strip.upcase == "MOVE"
    if move && r
      x = command[1] ? command[1] : "0"
      y = command[2] ? command[2] : "1" 
      f = command[3] ? command[3] : "N"
      r.move(x, y, f)
      puts r.inspect
    end

  else
    puts v.errors.join(", ")
  end

  # Call the print again after the robot move command to display the robot on the board
  # the draw_surface function needs to change as mentioned in the surface.rb class to 
  # correctly display the robot on the surface
 
  s.draw_surface

end

while run do
  # Prompt the user for input
  puts "Please enter a PLACE command followed by location coordinates X and  Y" unless placed
  puts "Please enter a MOVE command followed by location coordinates X and  Y" if placed
  puts "Press Q or q to quit"

  c = gets
  if c.chomp.upcase == "Q"
    run = false  
    puts "Exiting" 
    exit(0)
  end
  command = c.split(',')
  process_command(command) 
end
