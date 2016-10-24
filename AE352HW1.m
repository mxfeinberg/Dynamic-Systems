%% AE 352 HW 1
%  HW 1 Part B
close all; clear all;
KM_TO_MPS = 1/3.6;
V0 = 810 * KM_TO_MPS;
V1 = 650 * KM_TO_MPS;
V2 = 390 * KM_TO_MPS;
dv0 = (V1-V0)/20;
dv1 = (V2-V1)/10;
a0 = 0;
a1 = pi/40;
a2 = pi/80;
da0 = (a1-a0)/20;
da1 = (a2-a0)/160;
v(1) = V0;
dt = 30/100;
g(1) = 9.8;
t(1) = 0;
omega(1) = 0;
angle(1) = 0;
% R = V\w


for i=1:100
    t(i+1) = t(i)+dt;
    if(i*dt <= 20)
        v(i+1) = v(i) + dt*dv0;
    elseif(i*dt > 20 && i*dt <=30)
        v(i+1) = v(i) + dt*dv1;
    end
    
    if(i*dt <= 20)
        %omega(i+1) = omega(i) + dt *da0;
        %omega(i+1) = omega(i) + (pi/90)*dt;
        omega(i+1) = omega(i) + (pi/420)*dt;
    elseif(i*dt > 20 && i*dt <=30)
        %omega(i+1) = omega(i) - dt *da1;
        omega(i+1) = omega(i) - (pi/210)*dt;
    end
    
    
    if(i*dt <= 20)
        %angle(i+1) = angle(i) + dt * omega(i+1)+0.5*da0*dt*dt;
        %angle(i+1) = angle(i) + omega(i+1)*dt +0.5*(pi/180)*dt*dt;
        angle(i+1) = angle(i) + omega(i+1)*dt +0.5*(pi/420)*dt*dt;
    elseif(i*dt > 20 && i*dt <=30)
        %angle(i+1) = angle(i) - dt * omega(i+1) - 0.5 *da1*dt*dt;
         angle(i+1) = angle(i) - omega(i+1)*dt - 0.5*(pi/210)*dt*dt;
    end
    if(i*dt <= 20)
        %g(i+1) = (1.8 - cos(angle(i+1)))*9.81;
        %g(i+1) = g(i) + (v(i+1)^2)/(v(i+1)/omega(i+1))*dt - g(i) * cos(angle(i+1))*dt;
        g(i+1) = (1.8  -cos(angle(i+1)))*9.81;
    elseif(i*dt > 20 && i*dt <=30)
        %g(i+1) = 9.81*cos(angle(i+1));
        %g(i+1) = abs(((v(i+1))^2)/(v(i+1)/omega(i+1)) - g(i)*cos(angle(i+1)));
        g(i+1) = 9.81*cos(angle(i+1));
    
    end
    %g(i+1) = ((v(i+1))^2)/(v(i+1)/omega(i+1)) - g(i)*cos(angle(i+1));
    
end
plot(t, angle, 'rs');
