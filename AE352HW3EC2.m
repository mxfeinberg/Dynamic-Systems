function main
close all; clear all;

l = 10;
v0 = 10;
state = [0;v0/l;pi/2;0];

tMax = 100;
tRate = 100
[t,x] = ode45(@f, linspace(0, tMax, tMax*tRate), state);
pos = [];
for i=1:tMax*tRate
    pos = [pos;l*cos(x(i,1))*sin(x(i,3)) l*sin(x(i,1))*sin(x(i,3)) l*cos(x(i,3))];
end


x1(1)=0;
y1(1)=0;
z1(1)=0;
x2(1)=0;
y2(1)=0;
z2(1)=0;
for t = 1:360
    x1(t) = 10*cosd(t-1);
    x2(t) = 0;
    y1(t) = 0;
    y2(t) = 10*cosd(t-1);
    z1(t) = 10*sind(t-1);
    z2(t) = 10*sind(t-1);
end
figure (1)

title('Particle Trajectory in 3 Space');
hold on;
grid on;
%plot3(x,y,z,'g-');
plot3(x1,y1,z1,'b-');
plot3(x2,y2,z2,'r-');

grid on;
plot3(pos(:,1),pos(:,2),pos(:,3));



end

function dxdt = f(t,x)
l = 10;
phi_ddot = (x(2)*sin(x(3))*cos(x(3))+ 9.81/10*sin(x(3)));
theta_ddot = -2*x(2)*x(4)*cot(x(3));

xdot = [x(2); theta_ddot;x(4);phi_ddot];

dxdt = xdot;
end