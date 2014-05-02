q = 0.534  #flowrate in ft^3 / s

loop do
   head = 0.76

   area = Math::PI / 4 * (0.264 / 12) ** 2
   v_bar = q / 7.48 / 60 / area

   reynolds = 1.94 * v_bar * 0.264 / 12 / (2.07 * 10 ** -5)

   puts "Reynolds number #{reynolds}"

   puts "Input Friction Factor"
   friction = gets

   num = 2 * 32.174 * head.to_f
   dem = 1.025 + friction.to_f * 113.6
   new_v_bar = (num / dem) ** (1.0/2.0)

   flowrate = new_v_bar * area

   q = flowrate * 60 * 7.48
   puts "Flowrate #{(flowrate * 60 * 7.48).round(6)} gpm"
   
end
