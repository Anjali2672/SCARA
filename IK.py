import numpy
from numpy import *
import math

# Link lengths
a1 = 0.165  # length of link a1 in m
a2 = 0.118  # length of link a2 in m
d1 = 0.166

# End Effector Position
px = float(input("Enter px: "))  # offset of link d3 in m
if -0.1278 <= px <= 0.3310:
    print("Robot is inside the workspace")
else:
    print("Robot is outside the workspace")
    quit()

py = float(input("Enter py: "))  # offset of link d3 in m
if -0.259101506479873 <= py <= 0.329:
    print("Robot is inside the workspace")
else:
    print("Robot is outside the workspace")
    quit()

pz = float(input("Enter pz: "))  # offset of link d3 in m
if 0 <= pz <= 0.166:
    print("Robot is inside the workspace")
else:
    print("Robot is outside the workspace")
    quit()

# Angle theta 2
c2 = (px ** 2 + py ** 2 - a1 ** 2 - a2 ** 2) / (2 * a2 * a1)
s2 = math.sqrt(1 - c2 ** 2)
s2 = numpy.asarray([[s2], [-s2]])

th2 = arccos(c2)
th2 = [th2, -th2]

# Angle theta 1
c1 = ((a1 + a2 * c2) * px + a2 * s2 * py) / ((a2 * s2) ** 2 + (a1 + a2 * c2) ** 2)
s1 = ((a2 * s2 * px) - (a1 + a2 * c2) * py) / ((a2 * s2) ** 2 + (a1 + a2 * c2) ** 2)
th1 = -arctan2(s1, c1)
th1 = [th1, -th1]

# d3
d3 = d1 - pz

print(th1, rad2deg(th1))
print(th2, rad2deg(th2))
print(d3)
