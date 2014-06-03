# ME 347 Lab #8
# Flow through a convering-divering nozzle
# 
# Compressible flow model for calculating Mach number and throat pressure ratio as a function of mass flowrate
# 
# Available at:
# https://github.com/qpetty/me_coursework/blob/master/fluids/me347_lab8.rb


# Mass flowrates from the Experiment
m_dot = [0.00513, 0.00775, 0.00975, 0.01142, 0.01266, \
        0.01332, 0.01457, 0.01511, 0.01573, 0.01601, \
        0.01633, 0.01665, 0.01673, 0.01685, 0.01692, \
        0.01699, 0.01695, 0.01699, 0.01699, 0.01702, \
        0.01700, 0.01700, 0.01700, 0.01699, 0.01699]

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
   mach = 0.2

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
