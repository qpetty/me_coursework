# ME 347 Lab #8
# Flow through a convering-divering nozzle
# 
# Compressible flow model for calculating Mach number and throat pressure ratio as a function of mass flowrate


# Mass flowrates from the Experiment
m_dot = [0.00363, 0.00548, 0.00689, 0.00808, 0.00895, \
        0.00942, 0.01030, 0.01069, 0.01112, 0.01132, \
        0.01155, 0.01177, 0.01183, 0.01192, 0.01196, \
        0.01201, 0.01199, 0.01201, 0.01201, 0.01203, \
        0.01202, 0.01202, 0.01202, 0.01201, 0.01201]

# define the throat pressure ratio as a function of mach number
def pressureRatio(machNum)
   k = 1.4
   inside = 1.0 + ((k - 1.0) / 2.0) * machNum**2.0
   return inside**(k / (k - 1.0))
end

# defines the mach number as a function of mass flowrate and the throat pressure ratio
def machNumber(m_dot, ratio)
   k = 1.4
   area = 7.854 * 10**-5
   density = 1.204
   pressure = 100367.0
   top = m_dot / area
   bottom = Math.sqrt(k * density * pressure * ratio**((k+1.0)/k))
   return top / bottom
end

# iterate over each of the experimental mass flowrates
for i in m_dot

   # Initial Guess
   mach = 0.3

   # Last mach number to get us into the loop
   lastmach = 1.0

   # Iterate until this error percentage is reached
   errorPercentage = 0.05

   while (mach - lastmach).abs / lastmach * 100 > errorPercentage do
      lastmach = mach
      ratio = (1.0 / pressureRatio(mach))
      mach = machNumber(i,ratio)
      #puts "difference: #{(mach - lastmach).abs}"
      #puts "lastmach: #{lastmach}"
      #puts "percent error: #{(mach - lastmach).abs / lastmach * 100}"
   end

   puts "Mass Flowrate: #{i} kg/s  Pressure Ratio: #{ratio}  Mach Number #{mach}"
end
