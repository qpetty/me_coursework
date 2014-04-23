# circle.py

# Creates r and width values for each section of the given circle
import sys, math, crosssection

def getNextFloat():
   try:
      return float(sys.stdin.readline())
   except ValueError:
      print "Invaild Input: Not a vaild float"
      sys.exit();

# Gets all Input
print "Input Inner Radius of Curvature (mm): "
radCurvature = getNextFloat()
print radCurvature

print "Input Radius in plane of radius of curvature (mm): "
radCrossSection = getNextFloat()
print radCrossSection

print "Input Radius Width for Cross Section (mm): "
radWidth = getNextFloat()
print radWidth

print "Input Distance To Cross Section: "
distanceToCrossSection = getNextFloat()
print distanceToCrossSection

print "Input Number of Theta Steps: "
numSteps = getNextFloat()
print numSteps

theta = 0
radius = []
width = []

# Calculates radius and width at each theta step
for i in range(0, int(numSteps) * 2 + 1):
   radius.append((radCurvature + radCrossSection - radCrossSection \
                 * math.cos(theta)) / 1000)
   width.append((2 * radWidth * math.sin(theta)) / 1000)
   theta += math.pi / 2 / numSteps

# Send to Numerical Integration
crosssection.calcCrossSection(distanceToCrossSection,radius, width)
