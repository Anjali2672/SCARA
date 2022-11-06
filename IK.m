% Simulation of SCARA(RRPR) Robot

syms q1 q2 a1 a2 d3

% q1 q2 q4 joint angles
% d3 link offsets
% a1 a2  link lengths

% Inputs:-

prompt = 'Enter value of q1: ';
q1 = input(prompt)*pi/180;
if ((-99.67*pi/180 <= q1) && (q1 <= 99.67*pi/180))
    disp('robot is inside the workspace')
else 
    disp('robot is outside the workspace!*****')
    return
end
prompt = 'Enter value of q2: ';
q2 = input(prompt)*pi/180;
if ((-112.32*pi/180 <= q2) && (q2 <= 112.32*pi/180))
    disp('robot is inside the workspace')
else 
    disp('robot is outside the workspace!*****')
    return
end
prompt = 'Enter value of d3: ';
d3 = input(prompt);
if ((0 <= d3) && (d3 <= 0.116))
    disp('robot is inside the workspace')
else 
    disp('robot is outside the workspace!*****')
    return
end

% Link lengths are in meter
a1 = 0.165;  
a2 = 0.118;
d1 = 0.166;

% Input matrix using Transformation matrix
A1 = [cos(q1) -sin(q1) 0 a1*cos(q1); sin(q1) cos(q1) 0 a1*sin(q1); 0 0 1  d1; 0 0 0 1];
A2 = [cos(q2) sin(q2) 0 a2*cos(q2); sin(q2) -cos(q2) 0 a2*sin(q2); 0 0 -1 0; 0 0 0 1];
A3 = [1 0 0 0; 0 1 0 0; 0 0 1 d3; 0 0 0 1];

%Robotic Toolbox :- Peter corke
% create a numerical or symbolic DH parameter 
%L   = Link([Th  d    a      alpha offset])
L(1) = Link([0,  d1,  a1,     0,      0]);          % Revolute joint
L(2) = Link([0,  0,   a2,     pi,     0]);          % Revolute joint
L(3) = Link([0,  d3,   0,     0,      1]);          % Prismatic joint
SCARA = SerialLink(L,'name','SCARA');              % seriallink(L) to create the link

% Desired Manipulator matrix by Transformation 
A12 = (A1*A2); 
A13 = (A1)*(A2)*(A3);

P = A13(1:3,4);
disp('End effector position:')
disp(P)

% Inverse kinematics
Q =  SCARA.ikine(A13,'mask',[1 1 1 0 0 0]); 
figure(1)
SCARA.plot(Q,'workspace',[-1 1 -1 1 -1 1])
disp('Joint angles are:')
disp(Q)



