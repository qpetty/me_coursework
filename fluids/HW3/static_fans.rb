# Fluids 2 HW #3

sizes = [0.5, 1, 1.5]

density = 1.2 # kg/m^3
volume_flowrate = 3 # m/s

mass_flowrate = density * volume_flowrate

for i in sizes
   area_p = Math::PI / 4 * i**2

   brake_power = 2 * mass_flowrate**3 / (density**2 * area_p**2) / 746
   u_2 = volume_flowrate / area_p
   u_4 = u_2 * 2

   puts "Diameter of #{i} m"
   puts "\tBrake power required #{brake_power.round(3)} hp"
   puts "\tRotor plane air speed #{u_2.round(2)} m/s"
   puts "\tSlipstream air speed #{u_4.round(2)} m/s"
end
