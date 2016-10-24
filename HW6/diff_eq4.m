function state = diff_eq4(t,y)
% Earth - Moon System
G = 6.67408 * 10^-11;   % m^3/kg*s^2
m_e = 5.972*10^24;  % kg
m_m = 7.3477*10^22;  % kg
% ===================
dx = (y(1) - y(5));
dy = (y(2) - y(6));
r = sqrt((y(1) - y(5)) * (y(1) - y(5)) + (y(2) - y(6))*(y(2) - y(6)));
state = [y(3); y(4); ...
            -G*m_e*dx/(r^3); -G*m_e*dy/(r^3); ...
                y(7); y(8); 
                    G*m_m*dx/(r^3); G*m_m*dy/(r^3)];
end