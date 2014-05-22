# Dynamic Load on the hanging suspension bars holding the differential modeled as a cantilevered beam
#
# Quinton Petty

system_mass = 200.0 # pound force
length = 1.80 #inches beam length

#Custom inertia
#inertia = 0.422 # in^4 beam cross section moment of area

#For Square Tube
outside_size = 1.0 # inches
wall_thickness = 0.065 # inches
inside_size = outside_size - (2.0 * wall_thickness)
inertia = (outside_size**4 - inside_size**4) / 12.0
puts inertia

#For Round Tube
#outside_diameter = 1.5 # inches
#wall_thickness = 0.2 # inches
#inside_diameter = outside_diameter - 2.0 * wall_thickness
#inertia = Math::PI * (outside_diameter**4 - inside_diameter**4) / 64.0

#Steel
elastic_modulus = 29.0 * 10**6 #psi

#Aluminum
#elastic_modulus = 10.0 * 10**6 #psi

#Velocit based deceleration
#starting_velocity = 35.0 # miles per hour
#stopping_velocity = 0.0 # miles per hour
#
#deceleration_time = 0.5 # seconds
#
#deceleration = (starting_velocity - stopping_velocity) * (1.0 / 3600.0) * 5280.0 * (1.0 / deceleration_time)

#10 Gs
deceleration = 322.0

dynamic_force = 2.0 * system_mass * (1.0 / 32.2) * deceleration
puts "Dynamic Force: #{dynamic_force.round(2)} lbs"

max_disp = dynamic_force * length**3 / (3.0 * elastic_modulus * inertia)
puts "Maximum displacement: #{max_disp.round(7)} inches"

max_torsion = dynamic_force * length
puts "Maximim torsion force felt at weld joints: #{max_torsion.round(1)} lbs in"

weld_length = 2.5 # inches
weld_size = 3.0 / 16.0 # inches
horizontal_bar_size = 1.5 # inches

# pages 488 in shigley's: Weld #6
bending_inertia = horizontal_bar_size**2 / 6.0 * (3.0 * weld_length + horizontal_bar_size) * weld_size * 0.707
puts bending_inertia

max_bending_stress = max_torsion * (horizontal_bar_size / 2.0) / bending_inertia

puts "Stress per inch: #{(max_bending_stress / (weld_length * 4.0) / 10**3).round(2)} psi / in"
