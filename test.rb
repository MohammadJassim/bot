# Test file to run robot code

require_relative 'surface.rb'
require_relative 'validator.rb'
require_relative 'robot.rb'

# first draw the surface
s = Surface.new
s.draw_surface

# validate the input
v=Validator.new(["PLACE", "0", "0"])

# move the robot
r=Robot.new
r.move(3, 2)
puts(r.current_location)

r.move(-2,-1)
puts(r.current_location)



