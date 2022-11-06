l1=0.165;
l2=0.118;
t1=linspace(-99.67,99.67)*pi/180;
t2=linspace(-112.32,112.32)*pi/180;
d3=linspace(0,0.116);
[q1,q2,D3]=ndgrid(t1,t2,d3);  %Creates the matrices for each variable 
xM = l1 * cos(q1) + l2 * cos(q2+q1);
yM = l1 * sin(q1) + l2 * sin(q2+q1);
zM = D3;
plot3(xM(:),yM(:),zM(:),'r.')

xL = xlim; %all values of x 
yL = ylim; % all values of y 
line(xL, [0 0],'color','b','linewidth',1) %Draw x-axis
line([0 0], yL,'color','b','linewidth',1) %Draw y-axis
pause(1)
