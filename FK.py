import sympy
from numpy import *

# Link lengths
a1 = 0.165  # length of link a1 in m
a2 = 0.118  # length of link a2 in m
a3 = 0.001  # length of link a3 in m

# Link offsets
d1 = 0.166  # offset of link d1 in m
d2 = 0  # offset of link d2 in m
d3 = float(input("Enter d3: "))  # offset of link d3 in m
if 0 <= d3 <= 0.116:
    print("Robot is inside the workspace")
else:
    print("Robot is outside the workspace")
    quit()

# Alpha
theta_1 = 0  # theta 1 angle in degrees
theta_2 = pi  # theta 2 angle in degrees
theta_3 = 0  # theta 3 angle in degrees

# Joint angles
q1 = (float((input("Enter q1: "))) * pi) / 180
if -99.67 <= q1 <= 99.67:
    print("Robot is inside the workspace")
else:
    print("Robot is outside the workspace")
    quit()

q2 = ((float((input("Enter q2: ")))) * pi) / 180
if -112.32 <= q2 <= 112.32:
    print("Robot is inside the workspace")
else:
    print("Robot is outside the workspace")
    quit()

q3 = (0 * pi) / 180

# DH Parameter Table for Scara
dh = {theta_1: 0, a1: 0.166, d1: 0.1, q1: q1,
      theta_2: sympy.pi, a2: 0.165, d2: 0, q2: q2,
      theta_3: 0, a3: 0, d3: d3, q3: q3}

# Homogeneous Transformation Matrices
H0_1 = [[sympy.cos(q1), -sympy.sin(q1), 0, a1 * sympy.cos(q1)],
        [sympy.sin(q1), sympy.cos(q1), 0, a1 * sympy.sin(q1)],
        [0, 0, 1, d1],
        [0, 0, 0, 1]]

H1_2 = [[sympy.cos(q2), sympy.sin(q2), 0, a2 * sympy.cos(q2)],
        [sympy.sin(q2), -sympy.cos(q2), 0, a2 * sympy.sin(q2)],
        [0, 0, -1, 0],
        [0, 0, 0, 1]]

H2_3 = [[1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, d3],
        [0, 0, 0, 1]]

print("H0_1 =")
print(matrix(H0_1))
print("H1_2 =")
print(matrix(H1_2))
print("H2_3 =")
print(matrix(H2_3))

H0_2 = dot(H0_1, H1_2)
H0_3 = dot(H0_2, H2_3)

print("H0_3 =")
print(matrix(H0_3))
