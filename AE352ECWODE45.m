function main:
close all; clear all;

1 = 10;
v0 = 10;
state = [0;v0/l;pi/2;0];

tMax = 100;
trate = 100
[t,x] = ode45(@f, linspace(0, tMax, tMax*tRate), state);
pos = [];
for i=1:tMax*tRate
    pos = [pos;l*cos(x(i,1))*sin(x(i,3)) l*sin(x(i,1))*sin(x(i,3)) l*cos(x(i,3))];
end

figure (1)
grid on;
plot3(pos(:,1),pos(:,2),pos(:,3));

end

function dxdt = f(t,x)
l = 10;
phi_ddot = (x(2)*sin(x(3))*cos(x(3))+ 9.81/10*sin(x(3)));
theta_ddot = -x(2)*x(4)*cot(x(3))/sin(x(3));

xdot = [x(2); theta_ddot;x(4);phi_ddot];

dxdt = xdot;
end