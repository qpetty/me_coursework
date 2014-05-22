# Max displacement of constant cross-section bar suspending the differential and motor in the Cal Poly Electric Porsche
#
# Quinton Petty

#Lenght of the entire bar
length = 39.0 #inches

#weight of the entire hanging system
weight = 200.0 #lbs

#height from the center of the motor shaft to the top of the battery tray
height = 8.5 #inches
#gap between the top of the battery tray and the center of the bar
gap = 1.5 / 2.0 #inches

#position of the maximum displacement
x = Math.sqrt(length**2.0 / 12.0)

#angle of one of the supports connected to the bar and the differential
theta = 35.0 #degrees

#torque supplied by the motor
torque = 200.0 #lb ft

#Modulus of Elasticity of the bar
#Steel
modulus_elast = 29.0 * 10**6 #psi

#Aluminum
#modulus_elast = 10.0 * 10**6 #psi


#Second area moment of inertia of the bar
#inertia = 0.422 #in^4

#For Square Tube
outside_size = 1.5 # inches
wall_thickness = 0.065 # inches
inside_size = outside_size - (2.0 * wall_thickness)
inertia = (outside_size**4 - inside_size**4) / 12.0

#For Round Tube
#outside_diameter = 1.5 # inches
#wall_thickness = 0.2 # inches
#inside_diameter = outside_diameter - 2.0 * wall_thickness
#inertia = Math::PI * (outside_diameter**4 - inside_diameter**4) / 64.0


d = height + gap

a = (length / 2.0) - (d * Math.tan(theta * (Math::PI / 180.0)))
down_force = weight / 2.0

f_a_y = torque * (Math.cos(theta * (Math::PI / 180.0)) / d) * Math.sin(theta * (Math::PI / 180.0)) * 12
moment = 2 * (f_a_y + down_force) * (d * Math.tan(theta * (Math::PI / 180.0)))

moment_disp = (moment / (6.0 * modulus_elast * inertia)) * (x**3 / length - x * length / 4.0)

gravity_disp = (down_force * x / (6.0 * modulus_elast * inertia)) * (x**2 + 3.0 * a**2 - 3.0 * length * a)

max_disp = moment_disp + gravity_disp

gravity_disp_max = (down_force * a / (24.0 * modulus_elast * inertia)) * (4.0 * a**2 - 3.0 * length**2)

reason = "Bending Moment from motor and weight"
if gravity_disp_max.abs > max_disp.abs
   max_disp = gravity_disp_max
   reason = "Only gravity and weight of System"
end

puts "Maximum displacement of the suspening bar: #{max_disp.round(4)} inches"
puts "Reason: #{reason}"

vertical_force = moment / length * 2.0

puts "Max vertical force: #{vertical_force} lbs"

axial_force = 2.0 * torque / d * Math.cos(theta * (Math::PI / 180.0))**2 * 12

puts "Max axial force: #{axial_force} lbs"
