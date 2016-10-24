close all; clear all;
KM_TO_MPS = 1/3.6;
V0 = 810 * KM_TO_MPS;
V1 = 650 * KM_TO_MPS;
V2 = 390 * KM_TO_MPS;
dv0 = (V1-V0)/20;
dv1 = (V2-V1)/10;
a0 = 0;
a1 = pi/4;
da0 = a1/20;
da1 = a1/10;
dt = 30/1000;
v(1) = V0;
g(1) = 9.81;
t(1) = 0;
omega(1) = 0;
OMEGA = da0;
angle(1) = 0;

for i = 1:1000
    
    t(i+1) = t(i)+dt;
    if(i*dt <= 20)
        v(i+1) = v(i) + dt*dv0;
    elseif(i*dt > 20 && i*dt <=30)
        v(i+1) = v(i) + dt*dv1;
    elseif(i*dt > 30 && i*dt <=40)
        v(i+1) = v(i) - dt*dv1;
    elseif(i*dt > 40 && i*dt <=60)
        v(i+1) = v(i) - dt*dv0;
    end
    
    if(i*dt <= 20)
        angle(i+1) = angle(i) + OMEGA*dt;
    elseif(i*dt > 20 && i*dt <=30)
        angle(i+1) = angle(i) + da1*dt;
    elseif(i*dt > 30 && i*dt <=40)
        angle(i+1) = angle(i) - da1*dt
    elseif(i*dt > 40 && i*dt <=60)
        angle(i+1) = angle(i) = da1*dt
    end
   
end
plot(t, angle, 'bs');