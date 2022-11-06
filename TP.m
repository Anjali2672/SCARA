%DH parameters

a1 = 0.165;
a2 = 0.118;
d1 = 0.166;
d3 = 0.116;

% Link Description
%L   = Link([theta, d,  a,  alpha,   R/P])
L(1) = Link([0,d1,a1,0,0],'standard');          % Revolute joint
L(2) = Link([0,0,a2,pi,0],'standard');          % Revolute joint
L(3) = Link([0,d3,0,0,1],'standard');          % Prismatic joint
L(3).qlim = [0,0.116]; 
SCARA = SerialLink(L,'name','SCARA');          % seriallink(L) to create the link


q1 = [90 90 0.1];
q2 = [90 90 0.1];
q3 = [0 0 0.02];
q = (1:1:100);

qinit = [0 0 0]; % initial position x = 0, y = 0, z = 0

t =(0:0.9:3); %time vector for where one transformation took 3 seconds + pause(0.02) before undergo next transformations;

% The trajectory of this scara is :
% qinit -> q1 -> q2 -> q3 -> q1 -> qinit

% First Transformation = initial position to 1st position 
transformation1 = jtraj(qinit,q1,t);
SCARA.plot(transformation1,'workspace',[-1 1 -1 1 -1 1]);
pause(0.02);

% Second Transformation = 1st position to 2nd position 
transformation2 = jtraj(q1,q2,t);
SCARA.plot(transformation2,'workspace',[-1 1 -1 1 -1 1]);
pause(0.02);

% Third Transformation = 2nd position to 3rd position 
transformation3 = jtraj(q2,q3,t);
SCARA.plot(transformation3,'workspace',[-1 1 -1 1 -1 1]);
pause(0.02);

% Fourth Transformation = 3rd position to 1th position 
transformation4 = jtraj(q3,q1,t);
SCARA.plot(transformation4,'workspace',[-1 1 -1 1 -1 1]);
pause(0.02);


% Fifth Transformation = 1st position to initial position 
transformation5 = jtraj(q1,qinit,t);
SCARA.plot(transformation5,'workspace',[-1 1 -1 1 -1 1]);
pause(0.02);

trajectory = [0 0 0; 
           -0.0197 0.2019 0.1610;
            0.2824  0.1628 0.006;
            0 0  0;
            0 0 0];
        
[nx,ny] = size(trajectory) ;
figure(1)
hold on

for i = 1:nx-1
    v=[trajectory(i,:);trajectory(i+1,:)];
    plot3(v(:,1),v(:,2),v(:,3),'g');
    plot3(v(:,1),v(:,2),v(:,3),'bo')
end

text(trajectory(1,1),trajectory(1,2),trajectory(1,3), ' initial position');
text(trajectory(2,1),trajectory(2,2),trajectory(2,3), ' T1');
text(trajectory(3,1),trajectory(3,2),trajectory(3,3), ' T2');
text(trajectory(4,1),trajectory(4,2),trajectory(4,3), ' T3');


 xlabel('X');
 ylabel('Y');
 zlabel('Z');

view(3);        

figure(2)
wpts = trajectory;
[q, qd, qdd, tvec, pp] = trapveltraj(wpts, 501);
subplot(3,1,1)
plot(tvec, q)
xlabel('t')
ylabel('Positions')
legend('X','Y','Z')
subplot(3,1,2)
plot(tvec, qd)
xlabel('t')
ylabel('Velocities')
legend('X','Y','Z')
subplot(3,1,3)
plot(tvec, qdd)
xlabel('t')
ylabel('Accelerations')
legend('X','Y','Z')







