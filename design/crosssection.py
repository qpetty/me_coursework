# crosssection.py

# Recieves r and width values and inegrates to find moment of curved beam
# bending

import math, sys

# Asks user for input if file is run by itself
def main():
   rArr = []
   bArr = []

   print "On each line input the distance from the center of \
         curvature and then the height of the y segment"

   for line in sys.stdin:
      data = line.split()
      try:
         # Unit converstion mm to m
         mmToM = 1000
         rVal = float(data[0]) / mmToM
         bVal = float(data[1]) / mmToM
         bArr.append(bVal)
         rArr.append(rVal)

         print "r =", rVal, "meters  b =", bVal, "meters"
      except ValueError:
         pass
   print
   # Send to numerical Integration
   calcCrossSection(0.0263,rArr, bArr)


# Units of rArr and bArr must be meters
def calcCrossSection(distanceToCrossSection, rArr, bArr):
   #Constant force creating the moment on curved cross section
   force = 3296
   totalArea = 0
   sumOfAreaTimesR = 0
   sumOfAreaOverR = 0
   secondMomentOfArea = 0

   # Run this for each radius and width given
   for ndx in range(0, len(rArr) - 1):
      # Calculates the area for a single dA
      singleArea = (rArr[ndx + 1] - rArr[ndx]) * \
                   ((bArr[ndx + 1] + bArr[ndx]) / 2)
      distanceFromCurvatureCenter = (rArr[ndx + 1] + rArr[ndx]) / 2

      totalArea += singleArea

      # Integral of r*dA
      sumOfAreaTimesR += singleArea * distanceFromCurvatureCenter
      # Integral of dA/r
      sumOfAreaOverR += singleArea / distanceFromCurvatureCenter

   # Integral of (r*dA) / A
   centAxis = sumOfAreaTimesR / totalArea
   # Integral of A / (dA / r)
   neutralAxis = totalArea / sumOfAreaOverR

   print "rn: Neutral Axis:", neutralAxis, "meters", "\n"
   print "rc: Centrodial Axis:", centAxis, "meters", "\n"

   # Constant is distance to beginning of cross section
   # distanceToCrossSection = 0.0263 originaly
   moment = (distanceToCrossSection + (centAxis - rArr[0])) * force
   print "Moment through Centrodial Axis:", moment, "N m", "\n"

   # Constant to change Pa to MPa
   mega = 1000000
   axialStress = force * math.cos(12.85 * math.pi / 180) \
                 / totalArea / mega
   print "Axial Stress:", axialStress, "\n"

   insideStress = moment * (neutralAxis - rArr[0]) \
                  / (totalArea * (centAxis - neutralAxis) * rArr[0]) \
                  / mega
   insideStress += axialStress
   print "Inside Stress:", insideStress, "MPa", "\n"

   outsideStress = moment * (rArr[len(rArr) - 1] - neutralAxis) \
                   / (totalArea * (centAxis - neutralAxis) \
                   * rArr[len(rArr) - 1]) / mega
   outsideStress -= axialStress
   print "Outside Stress:", outsideStress, "MPa", "\n"

if __name__ == "__main__":
   main()
