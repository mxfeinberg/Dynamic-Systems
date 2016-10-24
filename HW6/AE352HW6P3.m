%%  AE 352 HW 6 
%   Problem 3
function main
clear all; close all; clc;

t0 = 0;         % initial time
tf = 100;        % final time
y0 = [0; 0; -1*pi/2; 0; ];   % initial conditions

[t,y] = ode45(@diff1,[t0 tf],y0);

figure(1)
plot(t,y(:,1));
xlabel('time (s)');
ylabel('x-position (units)');
grid on

figure(1)
plot(t,y(:,1));
xlabel('time (s)');
ylabel('x-position (units)');
grid on

figure(2)
plot(t,y(:,3));
xlabel('time (s)');
ylabel('\theta (radians)');
grid on

y0_EC = [0; 0; -1*pi/2; 0; pi/2; 0];
[u,z] = ode45(@diff2,[t0 5],y0_EC);
figure(3)
plot(u,z(:,3), 'r-', u,z(:,5), 'b-');
grid on
end

function state = diff1(t,y)
g = -9.81;% m/s^2
m = 10;   % kg
M = 100;  % kg
R = 1;    % units
% ===================
ddot_X = (R*y(4)^2*m*sin(y(3))+m*g*sin(y(3))*cos(y(3))) ...
          /(M+m-m*cos(y(3))^2*R);
state = [y(2); ddot_X; y(4); (-1 * ddot_X*cos(y(3))-g*sin(y(3)))/R]; 
end

function state = diff2(u,y)
g = -9.81;% m/s^2
m1 = 10;  % kg
m2 = 1;   % kg
M = 100;  % kg
R = 1;    % units
% ===================
ddot_X = (R*y(4)^2*m1*sin(y(3))+R*y(6)^2*m2*sin(y(5)) ...
          - m1*g*sin(y(3))*cos(y(3))-m2*g*sin(y(5))*cos(y(5))) ...
          /(M+m1+m2-m1*cos(y(3))^2*R - m2*cos(y(5))^2*R );
state = [y(2); ddot_X; y(4); (-1 * ddot_X*cos(y(3))+g*sin(y(3)))/R; y(6);...
          (-1 * ddot_X*cos(y(5))+g*sin(y(5)))/R]; 
end