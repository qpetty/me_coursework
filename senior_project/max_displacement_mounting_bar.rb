# Max displacement of constant cross-section bar suspending the differential and motor in the Cal Poly Electric Porsche
#
# Quinton Petty

#Lenght of the entire bar
length = 41.0 #inches

#weight of the entire hanging system
weight = 200.0 #lbs

#height from the center of the motor shaft to the top of the battery tray
height = 8.75 #inches
#gap between the top of the battery tray and the center of the bar
gap = 3.0 #inches

#position of the maximum displacement
x = Math.sqrt(length**2.0 / 12.0)

#angle of one of the supports connected to the bar and the differential
theta = 15.0 #degrees

#torque supplied by the motor
torque = 200.0 #lb ft

#Modulus of Elasticity of the bar
modulus_elast = 29.0 * 10**6 #psi


#Second area moment of inertia of the bar
#inertia = 0.422 #in^4

#For Square Tube
outside_size = 1.0
wall_thickness = 0.065
inside_size = outside_size - (2.0 * wall_thickness)
inertia = (outside_size**4 - inside_size**4) / 12.0

#For Round Tube
#outside_diameter = 1.5
#inside_diameter = 1.5
#inertia = Math::PI * (outside_diameter**4 - inside_diameter**4) / 64.0


d = height + gap

a = (length / 2.0) - (d * Math.tan(theta * (Math::PI / 180.0)))
moment = torque / d * Math.sin(theta * (Math::PI / 180.0))
down_force = weight / 2.0

moment_disp = (moment / (6.0 * modulus_elast * inertia)) * (x**3 / length - x * length / 4.0)

gravity_disp = (down_force * a / (24.0 * modulus_elast * inertia)) * (4.0 * a**2 - 3.0 * length**2)

max_disp = moment_disp + gravity_disp

puts "Maximum displacement of the suspening bar: #{max_disp.round(4)} inches"
