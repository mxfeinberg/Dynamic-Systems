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
dt = 30/1000;
g(1) = 9.788;
t(1) = 0;
omega(1) = 0;
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
    
    if(i*dt <= 10)
        %omega(i+1) = omega(i) + dt *da0;
        %omega(i+1) = omega(i) + (pi/90)*dt;
        omega(i+1) = omega(i) + (pi/400)*dt;
    elseif(i*dt >10 && i*dt <= 20)
        omega(i+1) = omega(i) - (pi/400)*dt;
        
    elseif(i*dt > 20 && i*dt <=25)
        %omega(i+1) = omega(i) - dt *da1;
        omega(i+1) = omega(i) - (pi/100)*dt;
    elseif(i*dt > 25 && i*dt <=30)
        %omega(i+1) = omega(i) - dt *da1;
        omega(i+1) = omega(i) + (pi/100)*dt;
        
    elseif(i*dt > 30 && i*dt <=35)
        %omega(i+1) = omega(i) - dt *da1;
        omega(i+1) = omega(i) - (pi/100)*dt;
    elseif(i*dt > 35 && i*dt <=40)
        %omega(i+1) = omega(i) - dt *da1;
        omega(i+1) = omega(i) + (pi/100)*dt;
        
    elseif(i*dt >40 && i*dt <= 50)
        omega(i+1) = omega(i) + (pi/400)*dt;
    elseif(i*dt >50 && i*dt <= 60)
        omega(i+1) = omega(i) - (pi/400)*dt;
        
    end
    
    
    
    if(i*dt <= 20)
        %angle(i+1) = angle(i) + dt * omega(i+1)+0.5*da0*dt*dt;
        %angle(i+1) = angle(i) + omega(i+1)*dt +0.5*(pi/180)*dt*dt;
        angle(i+1) = angle(i) + omega(i+1)*dt + 0.5*(pi/400)*dt^2;
    elseif(i*dt > 20 && i*dt <=30)
        %angle(i+1) = angle(i) - dt * omega(i+1) - 0.5 *da1*dt*dt;
        angle(i+1) = angle(i) + omega(i+1)*dt - 0.5*(pi/100)*dt*dt;
        
    elseif(i*dt > 30 && i*dt <=40)
        %angle(i+1) = angle(i) - dt * omega(i+1) - 0.5 *da1*dt*dt;
        angle(i+1) = angle(i) + omega(i+1)*dt - 0.5*(pi/100)*dt*dt;
    elseif(i*dt > 40 && i*dt <= 60)
        %angle(i+1) = angle(i) - dt * omega(i+1) - 0.5 *da1*dt*dt;
        angle(i+1) = angle(i) + omega(i+1)*dt + 0.5*(pi/100)*dt*dt;
        
    end
    
    if(i*dt <= 20)
        %g(i+1) = (1.8 - cos(angle(i+1)))*9.81;
        %g(i+1) = g(i) + (v(i+1)^2)/(v(i+1)/omega(i+1))*dt - g(i) * cos(angle(i+1))*dt;
        %g(i+1) = (v(i+1)*omega(i+1)) - g(i) * cos(angle(i+1));
        
        g(i+1) = (1.8  - cos(pi/2 - angle(i+1)))*9.78 - 9.78*cos(pi/2 - angle(i+1));
        
        %g(i+1) = V1*omega(i+1) - 9.78*cos(pi/2-angle(i+1));
        
        %g(i+1) = V1 * omega(i+1) * sin(angle(i+1)) + 9.81*cos(angle(i+1));
        
        %g(i+1) = g(i) - (v(i+1)*omega(i+1))*cos(angle(i+1));
        %g(i+1) = v(i+1)*omega(i+1) - 9.81*cos(angle(i+1));
    elseif(i*dt > 20 && i*dt <=30)
        
        g(i+1) = 9.78*cos(pi/2 - angle(i+1)) - 0.5*8.93*cos(pi/2 - angle(i+1));
        
        %g(i+1) = - 9.78*cos(pi/2 - angle(i+1))-V1*omega(i+1);
        %g(i+1) = ((v(i+1))^2)/(v(i+1)/omega(i+1)) - g(i)*cos(angle(i+1));
        %g(i+1) = (v(i+1)*omega(i+1)) - g(i) * cos(angle(i+1));
        %g(i+1) = 9.81*cos(angle(i+1));
    elseif(i*dt > 30 && i*dt <=40)
        g(i+1) = 9.78*cos(pi/2- angle(i+1)) - 0.5*8.93*cos(pi/2 - angle(i+1));
    elseif(i*dt > 40 && i*dt <= 60)
        g(i+1) = (1.8  - cos(pi/2 - angle(i+1)))*9.78 - 9.78*cos(pi/2 - angle(i+1));
    
    end
end
figure(1)
plot(t, angle, 'rs');
figure(2)
plot(t, omega, 'rs');
figure(3)
plot(t, g, 'rs');
figure(4)
plot(t, v/omega, 'bs');
