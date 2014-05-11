# Minimum Second Moment of Interia needed for a constant cross-section bar suspending the differential and motor in the Cal Poly Electric Porsche
#
# Quinton Petty

#Maximum displacement allowed of the suspending bar
max_disp = 0.003 #in

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


d = height + gap

a = (length / 2.0) - (d * Math.tan(theta * (Math::PI / 180.0)))
#puts " a #{a}"

moment = torque / d * Math.sin(theta * (Math::PI / 180.0))
#puts " moment #{moment}"
down_force = weight / 2.0
#puts " down_force #{down_force}"

moment_interia = (moment / (6.0 * modulus_elast * max_disp)) * (x**3 / length - x * length / 4.0)
#puts " moment_interia #{moment_interia}"

gravity_inertia = (down_force * a / (24.0 * modulus_elast * max_disp)) * (4.0 * a**2 - 3.0 * length**2)
#puts " gravity_interia #{gravity_inertia}"

max_inertia = moment_interia + gravity_inertia

puts "Minimum inertia of the suspening bar: #{max_inertia.abs.round(4)} inches^4 to displace #{max_disp} inches"

d_circle = (max_inertia * 4.0 / Math::PI)**(1.0 / 4.0) * 2
w_square = (max_inertia * 12.0)**(1.0 / 4.0)

puts "Same as a circle of diameter #{d_circle.abs.round(2)} inches"
puts "Same as a square of width #{w_square.abs.round(2)} inches"
