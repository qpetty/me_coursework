# trapazoid.py

# Creates r and width values for each section of the given trapazoid
import sys, math, crosssection

def getNextFloat():
   try:
      return float(sys.stdin.readline())
   except ValueError:
      print "Invaild Input: Not a vaild float"
      sys.exit();

# Ask user for Input
print "Input Inner Radius of Curvature (mm): "
radCurvature = getNextFloat()
print radCurvature

print "Input Height of Trapazoid (mm): "
height = getNextFloat()
print height

print "Input Inner Width of Trapazoid (mm): "
innerWidth = getNextFloat()
print innerWidth

print "Input Outer Width of Trapazoid (mm): "
outerWidth = getNextFloat()
print outerWidth

print "Input Distance To Cross Section: "
distanceToCrossSection = getNextFloat()
print distanceToCrossSection

print "Input Number of Integration Steps: "
numSteps = getNextFloat()
print numSteps

theta = 0
radius = []
width = []

radius.append(radCurvature / 1000)
width.append(innerWidth / 1000)

# Calculates the distance form curvature center and size at those points
for i in range(0, int(numSteps) + 1):
   radius.append((radius[i] * 1000 + height / numSteps) / 1000)
   width.append((width[i] * 1000 + (outerWidth - innerWidth) / numSteps) \
                / 1000)

# Send to numerical Integratoin
crosssection.calcCrossSection(distanceToCrossSection,radius, width)
