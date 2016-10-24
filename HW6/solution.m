function solution

% INTEGRATE THE ANGULAR RATE EQUATIONS
R0 = eye(3,3);
xH0 = zeros(3,1);
tMax = 6;
tRate = 30;
[t,xR] = ode45(@fR,linspace(0,tMax,tMax*tRate),RtoX(R0));
[t,xH] = ode45(@fH,t,xH0);

plot_animate(t,xR,xH);

HtoR(xH(size(xH,1),:))
XtoR(xR(size(xH,1),:))
xH(size(xH,1),:)

function xdot = fR(t,x)
R = XtoR(x);
w = 10*exp(-1*t)*[sin(t); sin(2*t); sin(3*t)];
Rdot = R*[0 -w(3) w(2); w(3) 0 -w(1); -w(2) w(1) 0];
xdot = RtoX(Rdot);

function thetadot = fH(t,H)
% %%
w = 10*exp(-1*t)*[sin(t); sin(2*t); sin(3*t)];
B = [cos(H(3))/cos(H(2)), -sin(H(3))/cos(H(2)), 0; ...
    sin(H(3)), cos(H(3)), 0; ...
    -tan(H(2))*cos(H(3)), tan(H(2))*sin(H(3)), 1];
thetadot = B*w;

function X = RtoX(R)
X = reshape(R,9,1);

function R = XtoR(X)
R = reshape(X,3,3);


function R=HtoR(H)
% %%
% CONVERT FROM XYZ EULER ANGLES TO A ROTATION MATRIX
R = [cos(H(2))*cos(H(3)), -cos(H(2))*sin(H(3)), sin(H(2)); ...
    (sin(H(1))*sin(H(2))*cos(H(3)))+(cos(H(1))*sin(H(3))), (-sin(H(1))*sin(H(2))*sin(H(3)))+(cos(H(1))*cos(H(3))), -sin(H(1))*cos(H(2)); ...
    (-cos(H(1))*sin(H(2))*cos(H(3)))+(sin(H(1))*sin(H(3))), (cos(H(1))*sin(H(2))*sin(H(3)))+(sin(H(1))*cos(H(3))), cos(H(1))*cos(H(2))];



function plot_animate(t,xR,xH)
% PLOT THE RESULTS
figure(1);
clf;
subplot(1,2,1);
plot(t,xR);
xlabel('time');
ylabel('elements of R');
title('R as a function of time');
subplot(1,2,2);
for i=1:length(t)
    detR(i) = det(XtoR(xR(i,:)));
end
plot(t,detR);
xlabel('time');
ylabel('det(R)');
title('determinant of R as a function of time');

figure(2);
plot(t,xH);
xlabel('time');
ylabel('Euler angle (rad)');

figure(3);

% CREATE A BOX
[p1,faces,colors] = makebox(0.5,1,0.2);

% SETUP THE PLOT
clf;
axis(1.25*[-1 1 -1 1 -1 1]);
axis equal;
hold on;
plot3(0,0,0,'k.','markersize',16);
hBox = patch('Vertices',p1','Faces',faces,...
          'CData',colors,'FaceColor','flat');
hTitle = title(sprintf('t = %4.2f',0));
lighting flat
light('Position',[0 -2 -1])
light('Position',[0 -2 1])
drawnow;

% ANIMATE THE RESULTS
i = 1;
dt = max(t)/(length(t)-1);
tic;
while (i<length(t))
    if (toc > dt)
        tic;
        i = i+1;
        R = XtoR(xR(i,:));
        p0 = R*p1;
        set(hBox,'Vertices',p0');
        set(hTitle,'string',sprintf('t = %4.2f',t(i)));
        
        drawnow;
    end
end


function [verts,faces,colors] = makebox(x,y,z)
verts = [0 x x 0 0 x x 0; 0 0 0 0 y y y y; 0 0 z z 0 0 z z];
faces = [1 2 3 4; 2 6 7 3; 6 5 8 7; 5 1 4 8; 4 3 7 8; 5 6 2 1];
colors(:,:,1) = 1*ones(1,size(faces,1));
colors(:,:,2) = 1*ones(1,size(faces,1));
colors(:,:,3) = 0*ones(1,size(faces,1));
colors(1,5,1) = 1;
colors(1,5,2) = 0;
colors(1,5,3) = 0;

