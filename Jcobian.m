% Link lengths are in meter
a1 = 0.165;  
a2 = 0.118;
d1 = 0.166;

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

q = [q1 q2 d3];

%Robotic Toolbox :- Peter corke
% create a numerical or symbolic DH parameter 
%L   = Link([Th  d    a      alpha offset])
L(1) = Link([0,  d1,  a1,     0,      0]);          % Revolute joint
L(2) = Link([0,  0,   a2,     pi,     0]);          % Revolute joint
L(3) = Link([0,  d3,   0,     0,      1]);          % Prismatic joint
SCARA = SerialLink(L,'name','SCARA');               % seriallink(L) to create the link

J = SCARA.jacobe(q);
disp(J)

disp('Linear velocity')
disp('Joint 1 ')
disp(J(1:3,1))
disp('Joint 2 ')
disp(J(1:3,2))
disp('Joint 3 ')
disp(J(1:3,3))


disp('Angular velocity')
disp('Joint 1 ')
disp(J(4:6,1))
disp('Joint 2 ')
disp(J(4:6,2))
disp('Joint 3 ')
disp(J(4:6,3))


