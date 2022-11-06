% Link lengths are in meter
a1 = 0.165;  
a2 = 0.118;
d1 = 0.166;
d3 = 0.116;

% Define the D-H table for the RRP robot
% create a numerical or symbolic DH parameter 
%L   = Link([Th  d    a     alpha offset])
L(1) = Link([0,  d1,  a1,     0,     0]);          % Revolute joint
L(2) = Link([0,   0,  a2,    pi,     0]);          % Revolute joint
L(3) = Link([0,  d3,   0,     0,     1]);          % Prismatic joint
SCARA = SerialLink(L,'name','SCARA');               % seriallink(L) to create the link


w=[-1 1 -1 1 -1 1];

% Vary joint variable #1
for q1 = -1.7395697:0.1:1.7395697
	SCARA.plot([q1,0,0], 'workspace', w);
	pause(0.1);
end
for q1 = 1.7395697:0.1:-1.7395697
	SCARA.plot([q1,0,0], 'workspace', w);
	pause(0.1);
end

% Vary joint variable #2
for q2 = -1.96035382:0.1:1.96035382
	SCARA.plot([0,q2,0],  'workspace', w);
	pause(0.1);
end
for q2 = 1.96035382:0.1:-1.96035382
	SCARA.plot([0,q2,0],  'workspace', w);
	pause(0.1);
end


% Vary joint variable #3
for q3 = 0:0.1:0.116
	SCARA.plot([0,0,q3],  'workspace', w);
	pause(0.1);
end
for q3 = 0.116:0.1:0
	SCARA.plot([0,0,q3],  'workspace', w);
	pause(0.1);
end

figure;
SCARA.plot([0,0,0],  'workspace', w);

% Now we will try to use the "Teach Pendant"
disp('Hit any key to continue - Use the "Teach Pendant"')
SCARA.qlim = [[-1.7395697 1.7395697]; [-1.96035382 1.96035382]; [0 0.116]]; % Need to set the joint limits
SCARA.teach