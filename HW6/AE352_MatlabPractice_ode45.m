%%  Using ode45: 
%   Case 1 - Pendulum
clear; close all; clc;

t0 = 0;         % initial time
tf = 30;        % final time
y0 = [30; 0];   % initial conditions

[t,y] = ode45(@diff_eq,[t0 tf],y0);

figure()
[yaxis, h1, h2] = plotyy(t,y(:,1),t, y(:,2));
grid on
set(h1,'Color','k','LineStyle','--')
set(h2,'Color','r','LineStyle','-')
ylabel(yaxis(1),'Angle (deg)')
ylabel(yaxis(2),'Angular Velocity (deg/s)')
xlabel('Time (s)')
legend('Position','Velocity')

%%  Case 2 - Projectile Motion
clear; close all; clc;

v = 30;
theta = 45;

vy = v*sind(theta);
vx = v*cosd(theta);

t0 = 0;
tf = vy*2/9.81;
y0 = [0; 0; vy; vx];

[t,y] = ode45(@diff_eq2, t0:0.05:tf, y0);

plot(y(:,2),y(:,1),'.b')
xlabel('X-Distance [m]')
ylabel('Y-Distance [m]')
axis([0 max(y(:,2)) 0 max(y(:,1))]);

%%  Case 3 - Two Body Problem (Newtonian Gravity)
clear; close all; clc;

% Earth - Moon System
a = 384748*10^3;     % m
G = 6.67408 * 10^-11;   % m^3/kg*s^2
m_e = 5.972*10^24;  % kg
m_m = 7.3477*10^22;  % kg
mu = m_e * G;
v = sqrt(mu/a);
% ====================

t0 = 0;
tf = 2*pi*sqrt(a^3 / mu);
y_0 = [a; 0; 0; v; 0; 0; 0; 0];

[t,y] = ode45(@diff_eq4, linspace(t0,10*tf,1000), y_0);

plot(y(:,1),y(:,2),'--r')
hold on
plot(y(:,5),y(:,6),'k')
%%  Case 4 - Review HW #2
clear; close all; clc;
%only uncomment the line below if the solution for HW2 is in the folder
%solution